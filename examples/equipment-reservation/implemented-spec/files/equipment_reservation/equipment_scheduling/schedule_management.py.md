---
type: "Source File"
title: "equipment_reservation/equipment_scheduling/schedule_management.py"
description: "Own schedule records, UTC periods, conflict rules, and schedule outcome signals."
spec_id: "FILE-equipment-reservation-equipment-scheduling-schedule-management-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/schedule_management.py"
git_blob: "f3de4211155e07aa39b0076d27a425808b7b1480"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Own schedule records, UTC periods, conflict rules, and schedule outcome signals.

# Responsibilities

- Create reservation and maintenance tables; foreign keys protect asset references.
- Normalize an ISO timestamp to UTC; naive form inputs explicitly mean UTC.
- Return normalized half-open bounds, rejecting non-positive durations.
- Report maintenance or confirmed-reservation overlap; adjacent bounds are free.
- Return each asset with availability and emit the decision context.
- Return the authoritative reservation context or reject an unknown identity.
- Confirm one conflict-free request within the caller's serialized transaction.
- Read reservations with optional owner and asset filters; retain all states.
- Block a period and atomically invalidate only overlapping confirmed reservations.
- Cancel only an invalid reservation with overlapping maintenance; otherwise reject.
- Complete a confirmed reservation; preserve invalid and cancelled historical states.

# Symbols

## File binding

`logger = logging.getLogger(__name__)`

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:8-8`.

## `initialize(db)`

Create reservation and maintenance tables; foreign keys protect asset references.

Calls: `db.execute`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:11-14`.

## `instant(value)`

Normalize an ISO timestamp to UTC; naive form inputs explicitly mean UTC.

Calls: `ValueError`, `datetime.fromisoformat`, `parsed.astimezone`, `parsed.astimezone(timezone.utc).isoformat`, `parsed.replace`.

Branch conditions: `parsed.tzinfo is None`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:17-25`.

## `period(start, end)`

Return normalized half-open bounds, rejecting non-positive durations.

Calls: `ValueError`, `instant`.

Branch conditions: `end <= start`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:28-33`.

## `unavailable_reason(db, equipment_id, start, end)`

Report maintenance or confirmed-reservation overlap; adjacent bounds are free.

Calls: `db.execute`, `db.execute("SELECT 1 FROM reservations WHERE equipment_id=? AND state='confirmed' AND start < ? AND end > ?", (equipment_id, end, start)).fetchone`, `db.execute('SELECT 1 FROM maintenance WHERE equipment_id=? AND start < ? AND end > ?', (equipment_id, end, start)).fetchone`.

Branch conditions: `db.execute("SELECT 1 FROM reservations WHERE equipment_id=? AND state='confirmed' AND start < ? AND end > ?", (equipment_id, end, start)).fetchone()`; `db.execute('SELECT 1 FROM maintenance WHERE equipment_id=? AND start < ? AND end > ?', (equipment_id, end, start)).fetchone()`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:36-42`.

## `availability(db, start, end)`

Return each asset with availability and emit the decision context.

Calls: `catalog.all_equipment`, `item.update`, `logger.info`, `period`, `result.append`, `unavailable_reason`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:45-54`.

## `reservation(db, reservation_id)`

Return the authoritative reservation context or reject an unknown identity.

Calls: `ValueError`, `db.execute`, `db.execute('SELECT * FROM reservations WHERE id=?', (reservation_id,)).fetchone`, `dict`.

Branch conditions: `row is None`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:57-62`.

## `reserve(db, equipment_id, employee, start, end)`

Confirm one conflict-free request within the caller's serialized transaction.

Calls: `ValueError`, `catalog.get`, `db.execute`, `logger.info`, `period`, `reservation`, `unavailable_reason`.

Branch conditions: `reason`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:65-75`.

## `reservations(db, employee=None, equipment_id=None)`

Read reservations with optional owner and asset filters; retain all states.

Calls: `db.execute`, `dict`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:78-80`.

## `maintenance(db, equipment_id, start, end, reason)`

Block a period and atomically invalidate only overlapping confirmed reservations.

Calls: `catalog.get`, `db.execute`, `logger.info`, `period`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:83-92`.

## `cancel(db, reservation_id)`

Cancel only an invalid reservation with overlapping maintenance; otherwise reject.

Calls: `ValueError`, `db.execute`, `db.execute('SELECT 1 FROM maintenance WHERE equipment_id=? AND start < ? AND end > ?', (item['equipment_id'], item['end'], item['start'])).fetchone`, `reservation`.

Branch conditions: `item['state'] != 'invalid' or not overlap`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:95-102`.

## `complete_return(db, reservation_id)`

Complete a confirmed reservation; preserve invalid and cancelled historical states.

Calls: `db.execute`, `reservation`.

Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:105-109`.


# Control flow

period normalizes both bounds before comparison. Availability loops through assets and checks maintenance before confirmed reservations. reserve checks the asset and conflicts before insert. maintenance inserts a period, collects affected confirmed reservations, updates their states, and logs each identity. cancel requires invalid state and overlapping maintenance. complete_return updates confirmed state only.

# Data & side effects

SQLite operations use the caller transaction; changes commit together or roll back on error. Candidate outcome events use Python logging before the caller commits. Logs are not a durable transaction ledger.

# Dependencies

- Uses [equipment_reservation/equipment_scheduling/equipment_catalog.py](equipment_catalog.py.md).
- External/standard-library imports: datetime, logging.
- Used by [equipment_reservation/equipment_scheduling/scheduling_operations.py](scheduling_operations.py.md).

# Errors

Validation raises ValueError as described by each operation. SQLite and other unexpected failures propagate; transaction owners roll back.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [schedule-management](../../../modules/schedule-management.md)

# Evidence

- `equipment_reservation/equipment_scheduling/schedule_management.py:8-8`
- `equipment_reservation/equipment_scheduling/schedule_management.py:11-14`
- `equipment_reservation/equipment_scheduling/schedule_management.py:17-25`
- `equipment_reservation/equipment_scheduling/schedule_management.py:28-33`
- `equipment_reservation/equipment_scheduling/schedule_management.py:36-42`
- `equipment_reservation/equipment_scheduling/schedule_management.py:45-54`
- `equipment_reservation/equipment_scheduling/schedule_management.py:57-62`
- `equipment_reservation/equipment_scheduling/schedule_management.py:65-75`
- `equipment_reservation/equipment_scheduling/schedule_management.py:78-80`
- `equipment_reservation/equipment_scheduling/schedule_management.py:83-92`
- `equipment_reservation/equipment_scheduling/schedule_management.py:95-102`
- `equipment_reservation/equipment_scheduling/schedule_management.py:105-109`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
