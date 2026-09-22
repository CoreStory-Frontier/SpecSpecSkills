---
type: Data Entity
title: Equipment
description: One physical equipment asset that employees can reserve.
spec_id: ENT-equipment
layer: L3
provenance: supplied
generator: agent
---

# Purpose

Equipment identifies each physical item as a separate asset.

# Schema

| Field | Meaning |
|---|---|
| `equipment_id` | `[inferred]` Stable identity for one physical item. |
| `name` | `[inferred]` Employee-visible equipment name. |
| `description` | `[inferred]` Employee-visible details about the item. |

# Relationships

- `[inferred]` One Equipment item can have many [Reservations](reservation.md).
- `[inferred]` One Equipment item can have many [Maintenance periods](maintenance-period.md).
- `[inferred]` One Equipment item can have many [Equipment use](equipment-use.md) records.

# Lifecycle

- A custodian adds the Equipment item.
- Employees can reserve the item when it has no conflicting reservation or maintenance period.
- Custodians record pickup and return for the item.

# Invariants

- Each physical item has a distinct Equipment identity.
- An item is unavailable during an overlapping confirmed Reservation.
- An item is unavailable during an overlapping maintenance period.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../../product/capabilities/track-equipment-use.md)

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
