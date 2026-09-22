---
type: Authorization
title: Equipment Access
description: Employee and custodian access rules for equipment functions.
spec_id: AUTHZ-equipment-access
layer: L3
provenance: supplied
generator: agent
---

# Purpose

Equipment Access limits product actions to employee and custodian roles. A user can have both
roles.

# Policy

| Role | Resource | Action | Condition |
|---|---|---|---|
| Employee | Equipment | Find available items | The actor has the employee role. |
| Employee | Reservation | Create | The actor becomes the Reservation employee. |
| Employee | Reservation | View | The actor is the Reservation employee. |
| Custodian | Equipment | Add | The actor has the custodian role. |
| Custodian | Maintenance Period | Record | The actor has the custodian role. |
| Custodian | Reservation | Cancel | The actor has the custodian role. |
| Custodian | Equipment Use | Record pickup or return | The actor has the custodian role. |
| Custodian | Equipment history | View | The actor has the custodian role. |

A user with both roles receives the actions assigned to both roles.

# Enforcement

- `[inferred]` The system obtains actor identity and roles before each protected Interface
  operation.
- `[inferred]` The system evaluates the matching policy row before it changes or returns protected
  data.
- `[inferred]` When no policy row permits the action, the system does not perform it and reports
  that it is unavailable.

# Guarantees

- An employee can view only their own Reservations.
- A user without the custodian role cannot perform a custodian action.
- A user with both roles can perform the actions assigned to both roles.
- Business validation for availability, conflicts, periods, and state stays outside this policy.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [View reservations](../../product/capabilities/view-reservations.md)
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
