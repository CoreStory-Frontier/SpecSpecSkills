---
type: Component
title: Web Access
description: Browser interfaces, external actor context, and access coordination.
spec_id: CMP-web-access
layer: L2
provenance: supplied
generator: agent
---

# Purpose

Web Access is the browser-facing boundary for employee and custodian actions. It obtains external
actor context and coordinates access checks before it delegates application work.

# Responsibilities

- Expose the employee and custodian browser interfaces.
- Use the external workforce identity source for actor identity and roles.
- Coordinate the Equipment Access policy before protected actions.
- Delegate scheduling actions to [Equipment Scheduling](equipment-scheduling.md).
- Delegate pickup, return, and history actions to [Equipment Handoff](equipment-handoff.md).
- Return application results through the browser boundary.
- It does not own Equipment, Reservation, Maintenance Period, or Equipment Use data.

# Interfaces

- Exposes the [Employee Equipment Interface](../system/interfaces/employee-equipment.md) to
  employees.
- Exposes the [Custodian Equipment Interface](../system/interfaces/custodian-equipment.md) to
  custodians.
- Uses the external [Workforce Identity Interface](../system/interfaces/workforce-identity.md) for
  actor context.

# Dependencies

- Uses [Equipment Scheduling](equipment-scheduling.md) for equipment, reservation, maintenance,
  and conflict behavior.
- Uses [Equipment Handoff](equipment-handoff.md) for pickup, return, and history behavior.
- Uses the supplied external workforce identity source.

# Modules

- [Web Interaction](../modules/web-interaction.md) exposes browser interactions and coordinates
  requests.
- [Actor Access](../modules/actor-access.md) obtains actor context and evaluates access.

# Runtime notes

- Runs in the same application runtime as the other Components.
- Provides browser interaction while keeping delegated contracts protocol-neutral.
- `[inferred]` No separate scaling, availability, or isolation requirement is known.

# Related

- [Technical overview](../system/technical-overview.md)
- [Employee equipment interface](../system/interfaces/employee-equipment.md)
- [Custodian equipment interface](../system/interfaces/custodian-equipment.md)
- [Workforce identity interface](../system/interfaces/workforce-identity.md)
- [Reserve equipment workflow](../system/workflows/reserve-equipment.md)
- [Manage maintenance workflow](../system/workflows/manage-maintenance.md)
- [Cancel invalid reservation workflow](../system/workflows/cancel-invalid-reservation.md)
- [Record equipment pickup workflow](../system/workflows/record-equipment-pickup.md)
- [Record equipment return workflow](../system/workflows/record-equipment-return.md)
- [Equipment access](../system/authorization/equipment-access.md)
- [Use browser interaction](../system/decisions/0001-browser-interaction.md)
- [Use a modular monolith](../system/decisions/0002-modular-monolith.md)
- [Application runtime](../system/deployment/application-runtime.md)

# Decomposition

- [Web Interaction](../modules/web-interaction.md)
- [Actor Access](../modules/actor-access.md)

# Evidence

- [Web Interaction](../modules/web-interaction.md)
- [Actor Access](../modules/actor-access.md)
