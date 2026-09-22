---
type: Data Entity
title: Equipment Use
description: Pickup and return history for one reserved equipment item.
spec_id: ENT-equipment-use
layer: L3
provenance: supplied
generator: agent
---

# Purpose

Equipment Use records the pickup and return of reserved equipment.

# Schema

| Field | Meaning |
|---|---|
| `equipment_use_id` | `[inferred]` Stable identity for the use record. |
| `reservation` | `[inferred]` Reference to the Reservation for this use. |
| `equipment` | `[inferred]` Reference to the Equipment item. |
| `employee` | `[inferred]` Reference to the employee who receives the item. |
| `pickup_time` | `[inferred]` Recorded pickup time. |
| `return_time` | `[inferred]` Recorded return time, when the item is returned. |

# Relationships

- `[inferred]` Each Equipment Use record refers to one [Reservation](reservation.md).
- `[inferred]` Each Equipment Use record refers to one [Equipment](equipment.md) item.
- `[inferred]` Each Equipment Use record refers to one employee outside the product identity
  boundary.

# Lifecycle

- A custodian records pickup and creates the Equipment Use record.
- A custodian records return and completes the Equipment Use record.
- The product keeps the record in the Equipment item's use history.

# Invariants

- `[inferred]` Pickup and return belong to the same Reservation and Equipment item.
- `[inferred]` Return cannot be recorded before pickup.
- `[inferred]` One Reservation has no more than one Equipment Use record.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md)

# Decomposition

- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Equipment Handoff](../../components/equipment-handoff.md)
