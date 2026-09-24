---
type: "Source File"
title: "test_application.py"
description: "Python test file at tests/test_application.py."
spec_id: "FILE-tests-test-application-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "tests/test_application.py"
language: "Python"
role: "test"
git_blob: "5c9c48cf7c85b2da44e70e6e33fd97f203b2d732"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] test_application.py supports the Web Interaction responsibility. The source starts: `"""Exercise product behavior through real HTTP handlers and SQLite transactions."""`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `tests/test_application.py:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `app(tmp_path)` — Create an isolated persistent database per test. Evidence: `tests/test_application.py:16`.
- `call(app, operation, identity)` — Use a fresh browser session and its CSRF token for an application request. Evidence: `tests/test_application.py:21`.
- `asset(app)` — Create one distinct equipment record as a custodian. Evidence: `tests/test_application.py:31`.
- `booking(app, key)` — Create a reservation with fixed default dates and allow targeted overrides. Evidence: `tests/test_application.py:38`.
- `test_p1_journey(app)` — F1-F2 R1-R2 R4 V1-V3 M1: reserve and isolate owner data with persistence. Evidence: `tests/test_application.py:43`.
- `test_adjacent_and_timezone(app)` — Approved UTC and half-open rules accept adjacency and reject equivalent-time conflicts. Evidence: `tests/test_application.py:59`.
- `test_add_access(app, identity, expected)` — A1-A4: only custodian and dual-role identities can create assets. Evidence: `tests/test_application.py:68`.
- `test_csrf_and_invalid_input(app)` — Deny forged form submissions and reject missing names and malformed periods. Evidence: `tests/test_application.py:73`.
- `test_maintenance_and_cancel(app)` — F3 R3 M2-M4: maintenance blocks, invalidates, and allows only invalid cancellation. Evidence: `tests/test_application.py:80`.
- `test_invalid_and_cancelled_do_not_block_outside_maintenance(app)` — Approved state filtering frees the non-maintenance portion of an invalid reservation. Evidence: `tests/test_application.py:98`.
- `test_handoff_and_state_preservation(app, state)` — H1-H3: preserve item history and the approved return transition for each state. Evidence: `tests/test_application.py:109`.
- `test_invalid_handoff(app)` — Reject absent pickup, unknown records, and pickup after invalidation. Evidence: `tests/test_application.py:135`.
- `test_all_operation_access(app, identity, operation)` — A1-A4: each valid operation succeeds only for its required role, including role union. Evidence: `tests/test_application.py:148`.
- `race()` — Start independent requests together and collect their actual HTTP outcomes. Evidence: `tests/test_application.py:167`.
- `run(operation)` — Wait for peer requests before executing the supplied operation. Evidence: `tests/test_application.py:170`.
- `test_concurrent_reservations(app)` — Two conflicting valid requests confirm exactly one reservation across connections. Evidence: `tests/test_application.py:178`.
- `test_concurrent_maintenance_and_reservation(app)` — Maintenance wins eventual availability regardless of serialized operation order. Evidence: `tests/test_application.py:186`.
- `test_concurrent_handoffs(app)` — Concurrent duplicate pickup and return requests record exactly one of each. Evidence: `tests/test_application.py:196`.
- `test_concurrent_return_and_maintenance(app)` — Return and maintenance retain a complete use record and a valid historical state. Evidence: `tests/test_application.py:208`.
- `test_return_failure_rolls_back(app, monkeypatch)` — A scheduling failure rolls back the handoff return instead of leaving split state. Evidence: `tests/test_application.py:220`.
- `fail()` — Simulate a schedule error after the use-record write. Evidence: `tests/test_application.py:225`.
- `test_operational_signals(app, caplog)` — The four candidate event contracts carry asset, outcome, period, and event context. Evidence: `tests/test_application.py:235`.
- `test_completed_availability_and_unknown_ids(app)` — Completed bookings release availability; nonexistent resources never create records. Evidence: `tests/test_application.py:249`.
- `test_concurrent_pickup_and_maintenance(app)` — Pickup either precedes invalidation or is rejected; maintenance always invalidates. Evidence: `tests/test_application.py:261`.

# Control flow

- `def app(tmp_path)` returns a result. Entry: `tests/test_application.py:16`.
- `def call(app, operation, identity='alice', **values)` iterates over records, returns a result. Entry: `tests/test_application.py:21`.
- `def asset(app)` returns a result. Entry: `tests/test_application.py:31`.
- `def booking(app, key, **values)` returns a result. Entry: `tests/test_application.py:38`.
- `def test_p1_journey(app)` defines a contract or declaration. Entry: `tests/test_application.py:43`.
- `def test_adjacent_and_timezone(app)` defines a contract or declaration. Entry: `tests/test_application.py:59`.
- `def test_add_access(app, identity, expected)` defines a contract or declaration. Entry: `tests/test_application.py:68`.
- `def test_csrf_and_invalid_input(app)` defines a contract or declaration. Entry: `tests/test_application.py:73`.
- `def test_maintenance_and_cancel(app)` defines a contract or declaration. Entry: `tests/test_application.py:80`.
- `def test_invalid_and_cancelled_do_not_block_outside_maintenance(app)` defines a contract or declaration. Entry: `tests/test_application.py:98`.
- `def test_handoff_and_state_preservation(app, state)` checks a condition, iterates over records, returns a result. Entry: `tests/test_application.py:109`.
- `def test_invalid_handoff(app)` defines a contract or declaration. Entry: `tests/test_application.py:135`.
- `def test_all_operation_access(app, identity, operation)` checks a condition, iterates over records. Entry: `tests/test_application.py:148`.
- `def race(*operations)` iterates over records, returns a result. Entry: `tests/test_application.py:167`.
- `def test_concurrent_reservations(app)` iterates over records. Entry: `tests/test_application.py:178`.
- `def test_concurrent_maintenance_and_reservation(app)` iterates over records. Entry: `tests/test_application.py:186`.
- `def test_concurrent_handoffs(app)` checks a condition, iterates over records, returns a result. Entry: `tests/test_application.py:196`.
- `def test_concurrent_return_and_maintenance(app)` iterates over records, returns a result. Entry: `tests/test_application.py:208`.
- `def test_return_failure_rolls_back(app, monkeypatch)` returns a result. Entry: `tests/test_application.py:220`.
- `def test_operational_signals(app, caplog)` iterates over records. Entry: `tests/test_application.py:235`.
- `def test_completed_availability_and_unknown_ids(app)` defines a contract or declaration. Entry: `tests/test_application.py:249`.
- `def test_concurrent_pickup_and_maintenance(app)` checks a condition. Entry: `tests/test_application.py:261`.

# Data & side effects

- database read `concurrent` at `tests/test_application.py:5`.
- database read `threading` at `tests/test_application.py:6`.
- database read `equipment_reservation` at `tests/test_application.py:8`.
- database read `equipment_reservation` at `tests/test_application.py:9`.

# Dependencies

- Uses [scheduling_operations.py](../equipment_reservation/equipment_scheduling/scheduling_operations.py.md).

# Errors

- `assert status == 200` at `tests/test_application.py:34`.
- `assert asset(app) != key` at `tests/test_application.py:46`.
- `assert call(app, 'search', start=START, end=END)[1]['result'][0]['available']` at `tests/test_application.py:47`.
- `assert booking(app, key)[0] == 200` at `tests/test_application.py:48`.
- `assert booking(app, key)[0] == 400` at `tests/test_application.py:49`.
- `assert booking(app, key, start=END, end=START)[0] == 400` at `tests/test_application.py:50`.
- `assert not call(app, 'search', start=START, end=END)[1]['result'][0]['available']` at `tests/test_application.py:51`.
- `assert len(call(app, 'mine')[1]['result']) == 1` at `tests/test_application.py:52`.
- `assert call(app, 'mine', 'bob')[1]['result'] == []` at `tests/test_application.py:53`.
- `assert call(app, 'mine', '')[0] == 403` at `tests/test_application.py:54`.
- `assert len(call(restarted, 'mine')[1]['result']) == 1` at `tests/test_application.py:56`.
- `raise ValueError('Injected failure')` at `tests/test_application.py:227`.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `tests/test_application.py:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `tests/test_application.py:1` — file start.
- `git_blob: 5c9c48cf7c85b2da44e70e6e33fd97f203b2d732` — source content hash.
