---
type: "Source File"
title: "equipment_reservation/equipment_scheduling/scheduling_operations.py"
description: "Expose protocol-neutral scheduling contracts and the shared transaction boundary."
spec_id: "FILE-equipment-reservation-equipment-scheduling-scheduling-operations-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/equipment_scheduling/scheduling_operations.py"
git_blob: "2b5a780f736fe45fc37957095cd350579f450cc1"
language: "python"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Expose protocol-neutral scheduling contracts and the shared transaction boundary.

# Responsibilities

- Provide the application transaction without exposing storage through HTTP contracts.
- Initialize catalog and schedule storage in dependency order.
- Dispatch an authorized scheduling operation; propagate validation errors.
- Supply reservation and asset context owned by Scheduling for handoff checks.
- Ask Schedule Management to complete a still-confirmed reservation after return.
- Supply asset identity and all reservation states for use-history composition.
- Expose the scheduling UTC time shape to handoff consumers.

# Symbols

## `transaction(path)`

Provide the application transaction without exposing storage through HTTP contracts.

Calls: `catalog.transaction`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:7-9`.

## `initialize(db)`

Initialize catalog and schedule storage in dependency order.

Calls: `catalog.initialize`, `schedule.initialize`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:12-15`.

## `execute(db, operation, actor, values)`

Dispatch an authorized scheduling operation; propagate validation errors.

Calls: `ValueError`, `catalog.add`, `catalog.all_equipment`, `schedule.availability`, `schedule.cancel`, `schedule.maintenance`, `schedule.reservations`, `schedule.reserve`, `values.get`.

Branch conditions: `operation == 'add'`; `operation == 'cancel'`; `operation == 'catalog'`; `operation == 'maintenance'`; `operation == 'mine'`; `operation == 'reservations'`; `operation == 'reserve'`; `operation == 'search'`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:18-36`.

## `handoff_context(db, reservation_id)`

Supply reservation and asset context owned by Scheduling for handoff checks.

Calls: `catalog.get`, `schedule.reservation`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:39-42`.

## `complete_return(db, reservation_id)`

Ask Schedule Management to complete a still-confirmed reservation after return.

Calls: `schedule.complete_return`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:45-47`.

## `history_context(db, equipment_id)`

Supply asset identity and all reservation states for use-history composition.

Calls: `catalog.get`, `schedule.reservations`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:50-52`.

## `timestamp(value)`

Expose the scheduling UTC time shape to handoff consumers.

Calls: `schedule.instant`.

Evidence: `equipment_reservation/equipment_scheduling/scheduling_operations.py:55-57`.


# Control flow

initialize creates catalog then schedule storage. execute selects one operation and delegates to catalog or schedule. The mine branch passes the authorized actor as the employee filter. Unknown operations fail. Handoff and history helpers compose authoritative catalog and schedule context; completion and timestamp helpers delegate to Schedule Management.

# Data & side effects

Dispatches calls to owned scheduling operations in the caller transaction.

# Dependencies

- Uses [equipment_reservation/equipment_scheduling/equipment_catalog.py](equipment_catalog.py.md).
- Uses [equipment_reservation/equipment_scheduling/schedule_management.py](schedule_management.py.md).
- Used by [equipment_reservation/equipment_handoff/equipment_use_management.py](../equipment_handoff/equipment_use_management.py.md).
- Used by [equipment_reservation/web_access/web_interaction.py](../web_access/web_interaction.py.md).
- Used by [tests/test_application.py](../../tests/test_application.py.md).

# Errors

Validation raises ValueError as described by each operation. SQLite and other unexpected failures propagate; transaction owners roll back.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [scheduling-operations](../../../modules/scheduling-operations.md)

# Evidence

- `equipment_reservation/equipment_scheduling/scheduling_operations.py:7-9`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:12-15`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:18-36`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:39-42`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:45-47`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:50-52`
- `equipment_reservation/equipment_scheduling/scheduling_operations.py:55-57`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
