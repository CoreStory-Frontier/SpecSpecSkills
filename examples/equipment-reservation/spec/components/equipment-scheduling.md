---
type: Component
title: Equipment Scheduling
description: Equipment availability, reservations, maintenance, and conflict rules.
spec_id: CMP-equipment-scheduling
layer: L2
provenance: supplied
generator: agent
---

# Purpose

Equipment Scheduling owns the rules and records that determine when an Equipment item can be
reserved or blocked for maintenance.

# Responsibilities

- Act as the primary owner of Equipment, Reservation, and Maintenance Period data.
- Find Equipment that is available for a selected period.
- Create one conflict-free Reservation for a successful request.
- Prevent overlapping confirmed Reservations for one Equipment item.
- Record Maintenance Periods and make overlapping Reservations invalid.
- Cancel a Reservation only when later maintenance made it invalid.
- `[inferred]` Change a Reservation to completed when Equipment Handoff reports a recorded return.
- Preserve the confirmed concurrent-request rule: one request succeeds and the other fails.
- `[inferred]` Produce candidate reservation, availability, and invalid-reservation signals.
- It does not own Equipment Use, pickup, return, or handoff history.

# Interfaces

- Performs search, reservation, and own-reservation behavior for the
  [Employee Equipment Interface](../system/interfaces/employee-equipment.md), which Web Access
  exposes.
- Performs equipment, maintenance, and invalid-reservation behavior for the
  [Custodian Equipment Interface](../system/interfaces/custodian-equipment.md), which Web Access
  exposes.

# Dependencies

- Internal Components: None.
- External systems: None.

# Modules

- [Equipment Catalog](../modules/equipment-catalog.md) owns Equipment records and catalog behavior.
- [Schedule Management](../modules/schedule-management.md) owns schedule data and conflict rules.
- [Scheduling Operations](../modules/scheduling-operations.md) coordinates scheduling operations.

# Runtime notes

- Runs in the same application runtime as the other Components.
- Owns the consistency boundary for Reservation conflicts and maintenance conflicts.
- No framework, storage product, or separate service runtime is selected.

# Related

- [Technical overview](../system/technical-overview.md)
- [Equipment](../system/data/equipment.md)
- [Reservation](../system/data/reservation.md)
- [Maintenance period](../system/data/maintenance-period.md)
- [Employee equipment interface](../system/interfaces/employee-equipment.md)
- [Custodian equipment interface](../system/interfaces/custodian-equipment.md)
- [Reserve equipment workflow](../system/workflows/reserve-equipment.md)
- [Manage maintenance workflow](../system/workflows/manage-maintenance.md)
- [Cancel invalid reservation workflow](../system/workflows/cancel-invalid-reservation.md)
- [Record equipment pickup workflow](../system/workflows/record-equipment-pickup.md)
- [Record equipment return workflow](../system/workflows/record-equipment-return.md)
- [Equipment access](../system/authorization/equipment-access.md)
- [Use browser interaction](../system/decisions/0001-browser-interaction.md)
- [Use a modular monolith](../system/decisions/0002-modular-monolith.md)
- [Application runtime](../system/deployment/application-runtime.md)
- [Equipment operations](../system/observability/equipment-operations.md)

# Decomposition

- [Equipment Catalog](../modules/equipment-catalog.md)
- [Schedule Management](../modules/schedule-management.md)
- [Scheduling Operations](../modules/scheduling-operations.md)

# Evidence

- [Equipment Catalog](../modules/equipment-catalog.md)
- [Schedule Management](../modules/schedule-management.md)
- [Scheduling Operations](../modules/scheduling-operations.md)
