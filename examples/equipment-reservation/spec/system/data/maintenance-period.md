---
type: Data Entity
title: Maintenance Period
description: A defined period when one equipment item is unavailable for reservation.
spec_id: ENT-maintenance-period
layer: L3
provenance: supplied
generator: agent
---

# Purpose

A Maintenance Period blocks one equipment item for a defined start and end time.

# Schema

| Field | Meaning |
|---|---|
| `maintenance_period_id` | `[inferred]` Stable identity for the maintenance period. |
| `equipment` | `[inferred]` Reference to the Equipment item under maintenance. |
| `start_time` | `[inferred]` Start of the maintenance period. |
| `end_time` | `[inferred]` End of the maintenance period. |
| `reason` | `[inferred]` Custodian-supplied maintenance context. |

# Relationships

- `[inferred]` Each Maintenance Period refers to one [Equipment](equipment.md) item.
- A Maintenance Period can overlap and invalidate many [Reservations](reservation.md).

# Lifecycle

- A custodian records the Maintenance Period.
- The product makes the Equipment item unavailable for the period.
- The product treats each overlapping Reservation as invalid.

# Invariants

- An employee cannot create a Reservation that overlaps the Maintenance Period.
- A later Maintenance Period makes each overlapping Reservation invalid.
- `[inferred]` The end time is after the start time.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md)

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md)
