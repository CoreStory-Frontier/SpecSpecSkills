---
type: Interface
title: Employee Equipment Interface
description: Browser-based employee access to equipment search and reservation functions.
spec_id: IFC-employee-equipment
layer: L3
provenance: supplied
generator: agent
---

# Purpose

The Employee Equipment Interface lets employees find equipment, reserve it, and view their own
reservations through a browser.

# Contract

| Operation | Input | Output | Outcome |
|---|---|---|---|
| `[inferred]` Find available equipment | Start time and end time | Matching Equipment items | Shows items with no overlapping confirmed Reservation or Maintenance Period. |
| `[inferred]` Create reservation | Equipment item, start time, and end time | Reservation result | Confirms one conflict-free Reservation or rejects the request. |
| `[inferred]` View own reservations | Actor context | Reservation list | Shows only Reservations for the employee. |

# Schema

| Shape | Fields |
|---|---|
| Availability request | `[inferred]` Start time and end time. |
| Equipment result | `[inferred]` Equipment identity, name, and description. |
| Reservation request | `[inferred]` Equipment identity, start time, and end time. |
| Reservation result | `[inferred]` Reservation identity, Equipment identity, period, and state. |

# Errors

- The product rejects a Reservation that overlaps another confirmed Reservation.
- The product rejects a Reservation that overlaps a Maintenance Period.
- `[inferred]` The product rejects a period whose end time is not after its start time.
- `[inferred]` The product does not perform an action when actor context is absent or does not
  permit the action.

# Guarantees

- The interface does not confirm overlapping Reservations for one Equipment item.
- The interface returns only the requesting employee's Reservations.
- The interface uses protocol-neutral contracts below the browser boundary.

# Examples

| Scenario | Result |
|---|---|
| `[inferred]` An employee searches for a period with one free item. | The result includes that Equipment item. |
| `[inferred]` Two employees concurrently request the same item and period. | One request receives a confirmed Reservation. The other request is rejected. |

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [View reservations](../../product/capabilities/view-reservations.md)
- [Control employee access](../../product/capabilities/control-employee-access.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
