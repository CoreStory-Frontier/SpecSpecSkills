---
type: "Module"
title: "Schedule Management"
description: "Manage availability, reservations, maintenance, and reservation state."
spec_id: "MOD-schedule-management"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Manage availability, reservations, maintenance, and reservation state. This boundary groups the linked source files.

# Responsibilities

- Manage availability, reservations, maintenance, and reservation state. Evidence: [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).

# Public surface

- `initialize(db)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `instant(value)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `period(start, end)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `unavailable_reason(db, equipment_id, start, end)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `availability(db, start, end)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `reservation(db, reservation_id)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `reserve(db, equipment_id, employee, start, end)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `reservations(db, employee=None, equipment_id=None)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `maintenance(db, equipment_id, start, end, reason)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `cancel(db, reservation_id)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
- `complete_return(db, reservation_id)` — observed in [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).

# Internal structure

- [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).

# Dependencies

- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.
- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.

# Files

- [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).

# Evidence

- [equipment_reservation/equipment_scheduling/schedule_management.py](../files/equipment_reservation/equipment_scheduling/schedule_management.py.md).
