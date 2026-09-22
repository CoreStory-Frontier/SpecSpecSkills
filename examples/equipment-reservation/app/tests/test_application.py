"""Exercise product behavior through real HTTP handlers and SQLite transactions."""

import pytest
import logging
from concurrent.futures import ThreadPoolExecutor
from threading import Barrier

from equipment_reservation.web_access.web_interaction import create_app
from equipment_reservation.equipment_scheduling import scheduling_operations

START = '2030-01-01T10:00'
END = '2030-01-01T11:00'


@pytest.fixture
def app(tmp_path):
    """Create an isolated persistent database per test."""
    return create_app({'TESTING': True, 'DATABASE': str(tmp_path / 'test.sqlite'), 'SECRET_KEY': 'test-only'})


def call(app, operation, identity='alice', **values):
    """Use a fresh browser session and its CSRF token for an application request."""
    client = app.test_client()
    client.get('/')
    with client.session_transaction() as session:
        token = session['csrf']
    response = client.post('/action/' + operation, data={'identity': identity, 'csrf': token, **values}, headers={'Accept': 'application/json'})
    return response.status_code, response.json


def asset(app):
    """Create one distinct equipment record as a custodian."""
    status, body = call(app, 'add', 'casey', name='Camera', description='Shared kit')
    assert status == 200
    return body['result']['id']


def booking(app, key, **values):
    """Create a reservation with fixed default dates and allow targeted overrides."""
    return call(app, 'reserve', **{'equipment_id': key, 'start': START, 'end': END, **values})


def test_p1_journey(app):
    """F1-F2 R1-R2 R4 V1-V3 M1: reserve and isolate owner data with persistence."""
    key = asset(app)
    assert asset(app) != key
    assert call(app, 'search', start=START, end=END)[1]['result'][0]['available']
    assert booking(app, key)[0] == 200
    assert booking(app, key)[0] == 400
    assert booking(app, key, start=END, end=START)[0] == 400
    assert not call(app, 'search', start=START, end=END)[1]['result'][0]['available']
    assert len(call(app, 'mine')[1]['result']) == 1
    assert call(app, 'mine', 'bob')[1]['result'] == []
    assert call(app, 'mine', '')[0] == 403
    restarted = create_app(app.config)
    assert len(call(restarted, 'mine')[1]['result']) == 1


def test_adjacent_and_timezone(app):
    """Approved UTC and half-open rules accept adjacency and reject equivalent-time conflicts."""
    key = asset(app)
    assert booking(app, key)[0] == 200
    assert booking(app, key, start='2030-01-01T12:00+02:00', end='2030-01-01T13:00+02:00')[0] == 400
    assert booking(app, key, start=END, end='2030-01-01T12:00')[0] == 200


@pytest.mark.parametrize('identity,expected', [('alice',403), ('bob',403), ('casey',200), ('drew',200), ('',403), ('unknown',403)])
def test_add_access(app, identity, expected):
    """A1-A4: only custodian and dual-role identities can create assets."""
    assert call(app, 'add', identity, name='Tripod')[0] == expected


def test_csrf_and_invalid_input(app):
    """Deny forged form submissions and reject missing names and malformed periods."""
    assert app.test_client().post('/action/add', data={'identity':'casey', 'name':'X'}).status_code == 403
    assert call(app, 'add', 'casey', name=' ')[0] == 400
    assert call(app, 'search', start='bad', end=END)[0] == 400


def test_maintenance_and_cancel(app):
    """F3 R3 M2-M4: maintenance blocks, invalidates, and allows only invalid cancellation."""
    key = asset(app)
    first = booking(app, key)[1]['result']['id']
    assert call(app, 'cancel', 'casey', reservation_id=first)[0] == 400
    assert call(app, 'maintenance', 'casey', equipment_id=key, start=END, end=START)[0] == 400
    later = booking(app, key, start=END, end='2030-01-01T12:00')[1]['result']['id']
    status, body = call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END, reason='Service')
    assert status == 200 and body['result']['invalid_reservations'] == [first]
    assert not call(app, 'search', start=START, end=END)[1]['result'][0]['available']
    assert booking(app, key)[0] == 400
    assert call(app, 'cancel', 'casey', reservation_id=first)[1]['result']['state'] == 'cancelled'
    assert call(app, 'cancel', 'casey', reservation_id=first)[0] == 400
    assert call(app, 'cancel', 'casey', reservation_id=later)[0] == 400
    assert call(app, 'maintenance', 'alice', equipment_id=key, start=START, end=END)[0] == 403
    assert call(app, 'cancel', 'alice', reservation_id=first)[0] == 403


def test_invalid_and_cancelled_do_not_block_outside_maintenance(app):
    """Approved state filtering frees the non-maintenance portion of an invalid reservation."""
    key = asset(app)
    old = booking(app, key, end='2030-01-01T14:00')[1]['result']['id']
    call(app, 'maintenance', 'casey', equipment_id=key, start='2030-01-01T13:00', end='2030-01-01T14:00')
    assert call(app, 'search', start=START, end=END)[1]['result'][0]['available']
    assert call(app, 'cancel', 'casey', reservation_id=old)[0] == 200
    assert booking(app, key)[0] == 200


@pytest.mark.parametrize('state', ['confirmed', 'invalid', 'cancelled'])
def test_handoff_and_state_preservation(app, state):
    """H1-H3: preserve item history and the approved return transition for each state."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    status, body = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)
    assert status == 200
    use_id = body['result']['id']
    assert call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[0] == 400
    assert call(app, 'return', 'casey', use_id=use_id, return_time='2030-01-01T09:00')[0] == 400
    if state != 'confirmed':
        call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END)
    if state == 'cancelled':
        call(app, 'cancel', 'casey', reservation_id=rid)
    assert call(app, 'return', 'casey', use_id=use_id, return_time=END)[0] == 200
    assert call(app, 'return', 'casey', use_id=use_id, return_time=END)[0] == 400
    history = call(app, 'history', 'casey', equipment_id=key)[1]['result']
    assert len(history['reservations']) == len(history['uses']) == 1
    assert history['uses'][0]['return_time'] is not None
    assert history['reservations'][0]['state'] == ('completed' if state == 'confirmed' else state)
    # Later maintenance must not overwrite completed or cancelled records.
    call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END)
    assert call(app, 'history', 'casey', equipment_id=key)[1]['result']['reservations'][0]['state'] == history['reservations'][0]['state']
    other = asset(app)
    assert call(app, 'history', 'casey', equipment_id=other)[1]['result']['uses'] == []


def test_invalid_handoff(app):
    """Reject absent pickup, unknown records, and pickup after invalidation."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    assert call(app, 'return', 'casey', use_id=1, return_time=END)[0] == 400
    assert call(app, 'pickup', 'casey', reservation_id=999, pickup_time=START)[0] == 400
    call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END)
    assert call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[0] == 400
    assert call(app, 'history', 'casey', equipment_id=999)[0] == 400


@pytest.mark.parametrize('identity', ['alice', 'bob', 'casey', 'drew', '', 'unknown'])
@pytest.mark.parametrize('operation', ['add','catalog','reservations','search','reserve','mine','maintenance','cancel','pickup','return','history'])
def test_all_operation_access(app, identity, operation):
    """A1-A4: each valid operation succeeds only for its required role, including role union."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    values = dict(equipment_id=key, reservation_id=rid, name='Lens', start='2030-01-01T12:00', end='2030-01-01T13:00', pickup_time=START, return_time=END)
    if operation == 'return':
        values['use_id'] = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[1]['result']['id']
    if operation == 'cancel':
        call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END)
    employee_operation = operation in ('search','reserve','mine')
    allowed = identity in (('alice','bob','drew') if employee_operation else ('casey','drew'))
    before = call(app, 'history', 'casey', equipment_id=key)[1]['result']
    status, body = call(app, operation, identity, **values)
    assert status == (200 if allowed else 403)
    if not allowed:
        assert body['result'] is None
        assert call(app, 'history', 'casey', equipment_id=key)[1]['result'] == before


def race(*operations):
    """Start independent requests together and collect their actual HTTP outcomes."""
    barrier = Barrier(len(operations))
    def run(operation):
        """Wait for peer requests before executing the supplied operation."""
        barrier.wait(timeout=5)
        return operation()
    with ThreadPoolExecutor(max_workers=len(operations)) as pool:
        return list(pool.map(run, operations))


def test_concurrent_reservations(app):
    """Two conflicting valid requests confirm exactly one reservation across connections."""
    key = asset(app)
    results = race(lambda: booking(app, key), lambda: booking(app, key, identity='bob'))
    assert sorted(status for status, _ in results) == [200,400]
    assert len(call(app, 'reservations', 'casey')[1]['result']) == 1


def test_concurrent_maintenance_and_reservation(app):
    """Maintenance wins eventual availability regardless of serialized operation order."""
    key = asset(app)
    results = race(lambda: booking(app, key), lambda: call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END))
    assert results[1][0] == 200
    rows = call(app, 'reservations', 'casey')[1]['result']
    assert not any(row['state'] == 'confirmed' for row in rows)
    assert not call(app, 'search', start=START, end=END)[1]['result'][0]['available']


def test_concurrent_handoffs(app):
    """Concurrent duplicate pickup and return requests record exactly one of each."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    operation = lambda: call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)
    results = race(operation, operation)
    assert sorted(status for status, _ in results) == [200,400]
    use_id = next(body['result']['id'] for status, body in results if status == 200)
    operation = lambda: call(app, 'return', 'casey', use_id=use_id, return_time=END)
    assert sorted(status for status, _ in race(operation, operation)) == [200,400]


def test_concurrent_return_and_maintenance(app):
    """Return and maintenance retain a complete use record and a valid historical state."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    use_id = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[1]['result']['id']
    results = race(lambda: call(app, 'return', 'casey', use_id=use_id, return_time=END), lambda: call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END))
    assert [status for status, _ in results] == [200,200]
    history = call(app, 'history', 'casey', equipment_id=key)[1]['result']
    assert history['reservations'][0]['state'] in ('completed','invalid')
    assert history['uses'][0]['return_time'] is not None


def test_return_failure_rolls_back(app, monkeypatch):
    """A scheduling failure rolls back the handoff return instead of leaving split state."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    use_id = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[1]['result']['id']
    def fail(*args):
        """Simulate a schedule error after the use-record write."""
        raise ValueError('Injected failure')
    monkeypatch.setattr(scheduling_operations, 'complete_return', fail)
    assert call(app, 'return', 'casey', use_id=use_id, return_time=END)[0] == 400
    history = call(app, 'history', 'casey', equipment_id=key)[1]['result']
    assert history['uses'][0]['return_time'] is None
    assert history['reservations'][0]['state'] == 'confirmed'


def test_operational_signals(app, caplog):
    """The four candidate event contracts carry asset, outcome, period, and event context."""
    caplog.set_level(logging.INFO)
    key = asset(app)
    call(app, 'search', start=START, end=END)
    rid = booking(app, key)[1]['result']['id']
    booking(app, key)
    use_id = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[1]['result']['id']
    call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END)
    call(app, 'return', 'casey', use_id=use_id, return_time=END)
    for message in ['availability equipment=', 'available=True reason=None','result=confirmed','result=rejected','invalid_reservation equipment=', 'reservation=', 'kind=pickup', 'kind=return']:
        assert message in caplog.text


def test_completed_availability_and_unknown_ids(app):
    """Completed bookings release availability; nonexistent resources never create records."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    use_id = call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START)[1]['result']['id']
    call(app, 'return', 'casey', use_id=use_id, return_time=END)
    assert booking(app, key, identity='bob')[0] == 200
    assert booking(app, 999)[0] == 400
    assert call(app, 'maintenance', 'casey', equipment_id=999, start=START, end=END)[0] == 400
    assert call(app, 'cancel', 'casey', reservation_id=999)[0] == 400


def test_concurrent_pickup_and_maintenance(app):
    """Pickup either precedes invalidation or is rejected; maintenance always invalidates."""
    key = asset(app)
    rid = booking(app, key)[1]['result']['id']
    results = race(lambda: call(app, 'pickup', 'casey', reservation_id=rid, pickup_time=START), lambda: call(app, 'maintenance', 'casey', equipment_id=key, start=START, end=END))
    assert results[0][0] in (200,400) and results[1][0] == 200
    history = call(app, 'history', 'casey', equipment_id=key)[1]['result']
    assert history['reservations'][0]['state'] == 'invalid'
    assert len(history['uses']) == (1 if results[0][0] == 200 else 0)
