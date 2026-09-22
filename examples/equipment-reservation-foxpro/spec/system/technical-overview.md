---
type: Technical Overview
title: Equipment Reservation Technical Overview
description: System boundary and system design for equipment reservation.
spec_id: TECH-overview
layer: L3
provenance: supplied
generator: agent
---

# Summary

Equipment Reservation is a browser-based application for shared workplace equipment. It manages
equipment, reservations, maintenance periods, pickup, return, and role-based access.

# Context

- Employees use the product to find equipment, reserve it, and view their reservations.
- Custodians manage equipment, maintenance, pickup, return, invalid reservations, and history.
- [Workforce identity](interfaces/workforce-identity.md) is outside the product boundary. It
  supplies actor identity and role information.
- Purchasing, payments, employee identity management, and automated physical access are outside
  the product boundary.
- The workforce identity source is the only external integration.
- No notification or other external integration is in scope.
- [Application runtime](deployment/application-runtime.md) defines one deployable application.
- No availability target or named runtime technology is supplied.

# Components

- [Web Access](../components/web-access.md) exposes browser functions and coordinates access.
- [Equipment Scheduling](../components/equipment-scheduling.md) owns availability, reservations,
  maintenance, and conflict rules.
- [Equipment Handoff](../components/equipment-handoff.md) owns pickup, return, and use history.

# Data

- [Equipment](data/equipment.md) identifies each physical asset.
- [Reservation](data/reservation.md) assigns equipment to an employee for a period.
- [Maintenance period](data/maintenance-period.md) makes equipment unavailable.
- [Equipment use](data/equipment-use.md) records pickup and return.

# Interfaces

- [Employee equipment interface](interfaces/employee-equipment.md) supports employee functions.
- [Custodian equipment interface](interfaces/custodian-equipment.md) supports custodian functions.
- [Workforce identity interface](interfaces/workforce-identity.md) supplies external actor context.

# Workflows

- [Reserve equipment](workflows/reserve-equipment.md) prevents reservation conflicts.
- [Manage maintenance](workflows/manage-maintenance.md) manages maintenance conflicts.
- [Cancel invalid reservation](workflows/cancel-invalid-reservation.md) cancels a Reservation that
  maintenance made invalid.
- [Record equipment pickup](workflows/record-equipment-pickup.md) records a handoff to an employee.
- [Record equipment return](workflows/record-equipment-return.md) records returned equipment.

# Cross-cutting concerns

- [Equipment access](authorization/equipment-access.md) defines role permissions.
- [Equipment operations](observability/equipment-operations.md) defines candidate outcome signals.
- The design stays protocol-neutral below the browser interaction boundary.

# Key decisions

- [Use browser interaction](decisions/0001-browser-interaction.md) records the supplied interaction
  channel.
- [Use a modular monolith](decisions/0002-modular-monolith.md) records the supplied deployment and
  internal-boundary choice.

# Related

- [Find equipment](../product/capabilities/find-equipment.md)
- [Reserve equipment](../product/capabilities/reserve-equipment.md)
- [View reservations](../product/capabilities/view-reservations.md)
- [Manage equipment availability](../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../product/capabilities/track-equipment-use.md)
- [Control employee access](../product/capabilities/control-employee-access.md)

# Decomposition

- [Web Access](../components/web-access.md)
- [Equipment Scheduling](../components/equipment-scheduling.md)
- [Equipment Handoff](../components/equipment-handoff.md)

# Evidence

- [Web Access](../components/web-access.md)
- [Equipment Scheduling](../components/equipment-scheduling.md)
- [Equipment Handoff](../components/equipment-handoff.md)
