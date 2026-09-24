---
type: "Data Entity"
title: "Equipment Use"
description: "Equipment use records pickup and return against a reservation."
spec_id: "ENT-equipment-use"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Equipment use records pickup and return against a reservation.

# Schema

| Field | Observed shape |
|---|---|
| `id` | INTEGER PRIMARY KEY |
| `reservation_id` | UNIQUE REFERENCES reservations(id) |
| `equipment_id` | REFERENCES equipment(id) |
| `employee` | TEXT NOT NULL |
| `pickup_time` | TEXT NOT NULL |
| `return_time` | TEXT |

Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- Pickup creates a use record. Return fills its return time. History reads both. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.

# Invariants

- One pickup is allowed per reservation. Return requires a later time and no earlier return. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Equipment Handoff](../../components/equipment-handoff.md).
- [equipment_reservation/equipment_handoff/equipment_use_management.py](../../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md); source `equipment_reservation/equipment_handoff/equipment_use_management.py:1`.
