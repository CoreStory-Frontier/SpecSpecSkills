---
type: "Source File"
title: "equipment_reservation/equipment_handoff/equipment_use_management.py"
description: "Own Equipment Use records, eligibility checks, handoff events, and composed history."
spec_id: "FILE-equipment-reservation-equipment-handoff-equipment-use-management-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_handoff/equipment_use_management.py"
git_blob: "c38529ffa437931729604debee56165b4d31d398"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Own Equipment Use records, eligibility checks, handoff events, and composed history.

# Responsibilities

- Create Equipment Use storage with one-use-per-reservation and asset references.
- Record one pickup for a confirmed reservation or reject ineligible/duplicate requests.
- Record an ordered, unique return and update scheduling in the same transaction.
- Compose all reservation and use records for exactly one known Equipment item.
- Dispatch a previously authorized handoff request, rejecting unknown operations.

# Symbols

## File binding

`logger = logging.getLogger(__name__)`

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:7-7`.

## `initialize(db)`

Create Equipment Use storage with one-use-per-reservation and asset references.

Calls: `db.execute`.

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:10-12`.

## `pickup(db, reservation_id, pickup_time)`

Record one pickup for a confirmed reservation or reject ineligible/duplicate requests.

Calls: `ValueError`, `db.execute`, `db.execute('SELECT * FROM equipment_use WHERE id=?', (key,)).fetchone`, `db.execute('SELECT 1 FROM equipment_use WHERE reservation_id=?', (reservation_id,)).fetchone`, `dict`, `logger.info`, `scheduling.handoff_context`, `scheduling.timestamp`.

Branch conditions: `db.execute('SELECT 1 FROM equipment_use WHERE reservation_id=?', (reservation_id,)).fetchone()`; `item['state'] != 'confirmed'`.

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:15-25`.

## `record_return(db, use_id, return_time)`

Record an ordered, unique return and update scheduling in the same transaction.

Calls: `ValueError`, `db.execute`, `db.execute('SELECT * FROM equipment_use WHERE id=?', (use_id,)).fetchone`, `dict`, `logger.info`, `scheduling.complete_return`, `scheduling.timestamp`.

Branch conditions: `row is None or row['return_time'] is not None`; `time < row['pickup_time']`.

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:28-39`.

## `history(db, equipment_id)`

Compose all reservation and use records for exactly one known Equipment item.

Calls: `db.execute`, `dict`, `scheduling.history_context`.

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:42-46`.

## `execute(db, operation, values)`

Dispatch a previously authorized handoff request, rejecting unknown operations.

Calls: `ValueError`, `history`, `pickup`, `record_return`, `values.get`.

Branch conditions: `operation == 'history'`; `operation == 'pickup'`; `operation == 'return'`.

Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:49-57`.


# Control flow

pickup obtains scheduling context, normalizes the time, checks confirmed state and absence of a use record, then inserts. record_return checks pickup, absence of return, and time order before updating use and requesting scheduling completion in the same transaction. history combines scheduling context with use rows for one item. execute dispatches three operations and rejects other names.

# Data & side effects

SQLite operations use the caller transaction; changes commit together or roll back on error. Candidate outcome events use Python logging before the caller commits. Logs are not a durable transaction ledger.

# Dependencies

- Uses [equipment_reservation/equipment_scheduling/scheduling_operations.py](../equipment_scheduling/scheduling_operations.py.md).
- External/standard-library imports: logging.
- Used by [equipment_reservation/web_access/web_interaction.py](../web_access/web_interaction.py.md).

# Errors

Validation raises ValueError as described by each operation. SQLite and other unexpected failures propagate; transaction owners roll back.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [equipment-use-management](../../../modules/equipment-use-management.md)

# Evidence

- `equipment_reservation/equipment_handoff/equipment_use_management.py:7-7`
- `equipment_reservation/equipment_handoff/equipment_use_management.py:10-12`
- `equipment_reservation/equipment_handoff/equipment_use_management.py:15-25`
- `equipment_reservation/equipment_handoff/equipment_use_management.py:28-39`
- `equipment_reservation/equipment_handoff/equipment_use_management.py:42-46`
- `equipment_reservation/equipment_handoff/equipment_use_management.py:49-57`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
