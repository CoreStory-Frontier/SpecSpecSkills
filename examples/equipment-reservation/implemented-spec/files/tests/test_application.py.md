---
type: "Source File"
title: "tests/test_application.py"
description: "Exercise product behavior through real HTTP handlers and SQLite transactions."
spec_id: "FILE-tests-test-application-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "tests/test_application.py"
git_blob: "5c9c48cf7c85b2da44e70e6e33fd97f203b2d732"
language: "python"
role: "test"
revision_status: "uncommitted"
---

# Purpose

Exercise product behavior through real HTTP handlers and SQLite transactions.

# Responsibilities

- Create an isolated persistent database per test.
- Use a fresh browser session and its CSRF token for an application request.
- Create one distinct equipment record as a custodian.
- Create a reservation with fixed default dates and allow targeted overrides.
- F1-F2 R1-R2 R4 V1-V3 M1: reserve and isolate owner data with persistence.
- Approved UTC and half-open rules accept adjacency and reject equivalent-time conflicts.
- A1-A4: only custodian and dual-role identities can create assets.
- Deny forged form submissions and reject missing names and malformed periods.
- F3 R3 M2-M4: maintenance blocks, invalidates, and allows only invalid cancellation.
- Approved state filtering frees the non-maintenance portion of an invalid reservation.
- H1-H3: preserve item history and the approved return transition for each state.
- Reject absent pickup, unknown records, and pickup after invalidation.
- A1-A4: each valid operation succeeds only for its required role, including role union.
- Start independent requests together and collect their actual HTTP outcomes.
- Two conflicting valid requests confirm exactly one reservation across connections.
- Maintenance wins eventual availability regardless of serialized operation order.
- Concurrent duplicate pickup and return requests record exactly one of each.
- Return and maintenance retain a complete use record and a valid historical state.
- A scheduling failure rolls back the handoff return instead of leaving split state.
- The four candidate event contracts carry asset, outcome, period, and event context.
- Completed bookings release availability; nonexistent resources never create records.
- Pickup either precedes invalidation or is rejected; maintenance always invalidates.

# Symbols

## File binding

`START = '2030-01-01T10:00'`

Evidence: `tests/test_application.py:11-11`.

## File binding

`END = '2030-01-01T11:00'`

Evidence: `tests/test_application.py:12-12`.

## `app(tmp_path)`

Create an isolated persistent database per test.

Calls: `create_app`, `str`.

Evidence: `tests/test_application.py:16-18`.

## `call(app, operation, identity='alice', **values)`

Use a fresh browser session and its CSRF token for an application request.

Calls: `app.test_client`, `client.get`, `client.post`, `client.session_transaction`.

Evidence: `tests/test_application.py:21-28`.

## `asset(app)`

Create one distinct equipment record as a custodian.

Calls: `call`.

Evidence: `tests/test_application.py:31-35`.

## `booking(app, key, **values)`

Create a reservation with fixed default dates and allow targeted overrides.

Calls: `call`.

Evidence: `tests/test_application.py:38-40`.

## `test_p1_journey(app)`

F1-F2 R1-R2 R4 V1-V3 M1: reserve and isolate owner data with persistence.

Calls: `asset`, `booking`, `call`, `create_app`, `len`.

Evidence: `tests/test_application.py:43-56`.

## `test_adjacent_and_timezone(app)`

Approved UTC and half-open rules accept adjacency and reject equivalent-time conflicts.

Calls: `asset`, `booking`.

Evidence: `tests/test_application.py:59-64`.

## `test_add_access(app, identity, expected)`

A1-A4: only custodian and dual-role identities can create assets.

Calls: `call`, `pytest.mark.parametrize`.

Evidence: `tests/test_application.py:68-70`.

## `test_csrf_and_invalid_input(app)`

Deny forged form submissions and reject missing names and malformed periods.

Calls: `app.test_client`, `app.test_client().post`, `call`.

Evidence: `tests/test_application.py:73-77`.

## `test_maintenance_and_cancel(app)`

F3 R3 M2-M4: maintenance blocks, invalidates, and allows only invalid cancellation.

Calls: `asset`, `booking`, `call`.

Evidence: `tests/test_application.py:80-95`.

## `test_invalid_and_cancelled_do_not_block_outside_maintenance(app)`

Approved state filtering frees the non-maintenance portion of an invalid reservation.

Calls: `asset`, `booking`, `call`.

Evidence: `tests/test_application.py:98-105`.

## `test_handoff_and_state_preservation(app, state)`

H1-H3: preserve item history and the approved return transition for each state.

Calls: `asset`, `booking`, `call`, `len`, `pytest.mark.parametrize`.

Branch conditions: `state != 'confirmed'`; `state == 'cancelled'`.

Evidence: `tests/test_application.py:109-132`.

## `test_invalid_handoff(app)`

Reject absent pickup, unknown records, and pickup after invalidation.

Calls: `asset`, `booking`, `call`.

Evidence: `tests/test_application.py:135-143`.

## `test_all_operation_access(app, identity, operation)`

A1-A4: each valid operation succeeds only for its required role, including role union.

Calls: `asset`, `booking`, `call`, `dict`, `pytest.mark.parametrize`.

Branch conditions: `not allowed`; `operation == 'cancel'`; `operation == 'return'`.

Evidence: `tests/test_application.py:148-164`.

## `race(*operations)`

Start independent requests together and collect their actual HTTP outcomes.

Calls: `Barrier`, `ThreadPoolExecutor`, `barrier.wait`, `len`, `list`, `operation`, `pool.map`.

Evidence: `tests/test_application.py:167-175`.

## `run(operation)`

Wait for peer requests before executing the supplied operation.

Calls: `barrier.wait`, `operation`.

Evidence: `tests/test_application.py:170-173`.

## `test_concurrent_reservations(app)`

Two conflicting valid requests confirm exactly one reservation across connections.

Calls: `asset`, `booking`, `call`, `len`, `race`, `sorted`.

Evidence: `tests/test_application.py:178-183`.

## `test_concurrent_maintenance_and_reservation(app)`

Maintenance wins eventual availability regardless of serialized operation order.

Calls: `any`, `asset`, `booking`, `call`, `race`.

Evidence: `tests/test_application.py:186-193`.

## `test_concurrent_handoffs(app)`

Concurrent duplicate pickup and return requests record exactly one of each.

Calls: `asset`, `booking`, `call`, `next`, `race`, `sorted`.

Evidence: `tests/test_application.py:196-205`.

## `test_concurrent_return_and_maintenance(app)`

Return and maintenance retain a complete use record and a valid historical state.

Calls: `asset`, `booking`, `call`, `race`.

Evidence: `tests/test_application.py:208-217`.

## `test_return_failure_rolls_back(app, monkeypatch)`

A scheduling failure rolls back the handoff return instead of leaving split state.

Calls: `ValueError`, `asset`, `booking`, `call`, `monkeypatch.setattr`.

Evidence: `tests/test_application.py:220-232`.

## `fail(*args)`

Simulate a schedule error after the use-record write.

Calls: `ValueError`.

Evidence: `tests/test_application.py:225-227`.

## `test_operational_signals(app, caplog)`

The four candidate event contracts carry asset, outcome, period, and event context.

Calls: `asset`, `booking`, `call`, `caplog.set_level`.

Evidence: `tests/test_application.py:235-246`.

## `test_completed_availability_and_unknown_ids(app)`

Completed bookings release availability; nonexistent resources never create records.

Calls: `asset`, `booking`, `call`.

Evidence: `tests/test_application.py:249-258`.

## `test_concurrent_pickup_and_maintenance(app)`

Pickup either precedes invalidation or is rejected; maintenance always invalidates.

Calls: `asset`, `booking`, `call`, `len`, `race`.

Evidence: `tests/test_application.py:261-269`.


# Control flow

The listed operations run in caller order. Conditions above select validation and failure paths. Tests assert results; failures stop the test.

# Data & side effects

Uses isolated SQLite files and HTTP/browser sessions; browser tests bind a temporary localhost server.

# Dependencies

- Uses [equipment_reservation/equipment_scheduling/scheduling_operations.py](../equipment_reservation/equipment_scheduling/scheduling_operations.py.md).
- Uses [equipment_reservation/web_access/web_interaction.py](../equipment_reservation/web_access/web_interaction.py.md).
- External/standard-library imports: concurrent.futures, logging, pytest, threading.

# Errors

Assertion failures report unmet test expectations; setup and browser failures fail the run.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Related

- [web-interaction](../../modules/web-interaction.md)

# Evidence

- `tests/test_application.py:11-11`
- `tests/test_application.py:12-12`
- `tests/test_application.py:16-18`
- `tests/test_application.py:21-28`
- `tests/test_application.py:31-35`
- `tests/test_application.py:38-40`
- `tests/test_application.py:43-56`
- `tests/test_application.py:59-64`
- `tests/test_application.py:68-70`
- `tests/test_application.py:73-77`
- `tests/test_application.py:80-95`
- `tests/test_application.py:98-105`
- `tests/test_application.py:109-132`
- `tests/test_application.py:135-143`
- `tests/test_application.py:148-164`
- `tests/test_application.py:167-175`
- `tests/test_application.py:170-173`
- `tests/test_application.py:178-183`
- `tests/test_application.py:186-193`
- `tests/test_application.py:196-205`
- `tests/test_application.py:208-217`
- `tests/test_application.py:220-232`
- `tests/test_application.py:225-227`
- `tests/test_application.py:235-246`
- `tests/test_application.py:249-258`
- `tests/test_application.py:261-269`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
