---
type: Data Entity
title: Reservation
description: An employee's claim on one equipment item for a defined period.
spec_id: ENT-reservation
layer: L3
provenance: supplied
generator: agent
---

# Purpose

A Reservation records an employee's use of one equipment item for a start and end time.

# Schema

| Field | Meaning |
|---|---|
| `reservation_id` | `[inferred]` Stable identity for the reservation. |
| `equipment` | `[inferred]` Reference to the reserved Equipment item. |
| `employee` | `[inferred]` Reference to the employee identity from the workforce identity source. |
| `start_time` | `[inferred]` Start of the reserved period. |
| `end_time` | `[inferred]` End of the reserved period. |
| `state` | `[inferred]` Confirmed, invalid, cancelled, or completed reservation state. |

# Relationships

- `[inferred]` Each Reservation refers to one [Equipment](equipment.md) item.
- `[inferred]` Each Reservation refers to one employee outside the product identity boundary.
- `[inferred]` One Reservation can have one [Equipment use](equipment-use.md) record.
- A [Maintenance period](maintenance-period.md) can make a Reservation invalid.

# Lifecycle

- The product confirms a Reservation after availability and access checks pass.
- A later overlapping Maintenance Period makes the Reservation invalid.
- A custodian can cancel an invalid Reservation.
- `[inferred]` A Reservation becomes completed after the associated equipment return.

# Invariants

- Two confirmed Reservations for the same Equipment item cannot overlap.
- A new Reservation cannot overlap a Maintenance Period for the Equipment item.
- When concurrent requests conflict, the product confirms one Reservation and rejects the other.
- `[inferred]` The end time is after the start time.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [View reservations](../../product/capabilities/view-reservations.md)
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../../product/capabilities/track-equipment-use.md)

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
