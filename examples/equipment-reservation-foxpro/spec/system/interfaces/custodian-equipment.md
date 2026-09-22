---
type: Interface
title: Custodian Equipment Interface
description: Browser-based custodian access to equipment management and handoff functions.
spec_id: IFC-custodian-equipment
layer: L3
provenance: supplied
generator: agent
---

# Purpose

The Custodian Equipment Interface lets custodians manage equipment, maintenance, handoffs,
invalid reservations, and equipment history through a browser.

# Contract

| Operation | Input | Output | Outcome |
|---|---|---|---|
| `[inferred]` Add equipment | Equipment details | Equipment result | Creates one distinct Equipment record. |
| `[inferred]` Record maintenance period | Equipment item and period | Maintenance Period result | Makes the item unavailable and invalidates overlapping confirmed Reservations. |
| `[inferred]` Cancel invalid reservation | Invalid Reservation | Reservation result | Changes the invalid Reservation to cancelled. |
| `[inferred]` Record pickup | Reservation and pickup time | Equipment Use result | Records the employee's pickup. |
| `[inferred]` Record return | Equipment Use and return time | Equipment Use result | Records the employee's return. |
| `[inferred]` View equipment history | Equipment item | History result | Shows Reservation, pickup, and return records. |

# Schema

| Shape | Fields |
|---|---|
| Equipment details | `[inferred]` Name and description. |
| Maintenance request | `[inferred]` Equipment identity, start time, end time, and reason. |
| Pickup request | `[inferred]` Reservation identity and pickup time. |
| Return request | `[inferred]` Equipment Use identity and return time. |
| History result | `[inferred]` Equipment identity, Reservations, pickup records, and return records. |

# Errors

- The product cancels only a Reservation that is invalid because of overlapping maintenance.
- `[inferred]` The product rejects a maintenance period whose end time is not after its start time.
- `[inferred]` The product rejects a return when no pickup exists for the Reservation.
- `[inferred]` The product does not perform an action when actor context is absent or does not
  permit the action.

# Guarantees

- Each added physical item has a distinct Equipment record.
- Equipment history keeps Reservation, pickup, and return records for the selected item.
- The interface uses protocol-neutral contracts below the browser boundary.

# Examples

| Scenario | Result |
|---|---|
| `[inferred]` A custodian records maintenance that overlaps a Reservation. | The Maintenance Period is recorded and the Reservation becomes invalid. |
| `[inferred]` A custodian records return after pickup. | The Equipment Use record contains both times. |

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../../product/capabilities/track-equipment-use.md)
- [Control employee access](../../product/capabilities/control-employee-access.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
