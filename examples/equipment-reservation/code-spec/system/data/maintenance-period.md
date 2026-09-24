---
type: "Data Entity"
title: "Maintenance Period"
description: "Maintenance blocks an equipment period."
spec_id: "ENT-maintenance-period"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Maintenance blocks an equipment period.

# Schema

| Field | Observed shape |
|---|---|
| `id` | INTEGER PRIMARY KEY |
| `equipment_id` | REFERENCES equipment(id) |
| `start` | TEXT NOT NULL |
| `end` | TEXT NOT NULL |
| `reason` | TEXT NOT NULL |

Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A custodian records a period. The source keeps its historical row. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.

# Invariants

- The end follows the start. A maintenance period blocks overlap and invalidates confirmed reservations on that equipment. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md); source `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
