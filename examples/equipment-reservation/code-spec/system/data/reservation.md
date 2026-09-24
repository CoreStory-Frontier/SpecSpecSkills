---
type: "Data Entity"
title: "Reservation"
description: "A reservation stores an equipment, actor, period, and state."
spec_id: "ENT-reservation"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A reservation stores an equipment, actor, period, and state.

# Schema

| Field | Observed shape |
|---|---|
| `id` | INTEGER PRIMARY KEY |
| `equipment_id` | REFERENCES equipment(id) |
| `employee` | TEXT NOT NULL |
| `start` | TEXT NOT NULL |
| `end` | TEXT NOT NULL |
| `state` | CHECK confirmed/invalid/cancelled/completed |

Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A successful reserve creates a confirmed record. Maintenance can invalidate it. A custodian can cancel an invalid record. Return can complete a confirmed record. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.

# Invariants

- Only confirmed reservations block overlapping booking. State moves to invalid on overlapping maintenance, cancelled after invalidation, or completed after eligible return. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).
- [View reservations](../../product/capabilities/view-reservations.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md); source `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
