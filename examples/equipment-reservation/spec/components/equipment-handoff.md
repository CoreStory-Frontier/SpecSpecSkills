---
type: Component
title: Equipment Handoff
description: Equipment pickup, return, and use history.
spec_id: CMP-equipment-handoff
layer: L2
provenance: supplied
generator: agent
---

# Purpose

Equipment Handoff owns Equipment Use records and the pickup, return, and history behavior for
reserved Equipment.

# Responsibilities

- Act as the primary owner of Equipment Use data.
- Record Equipment pickup for a Reservation.
- Record Equipment return after pickup.
- Ask Equipment Scheduling to complete a confirmed Reservation after return; preserve invalid or cancelled states.
- Provide Reservation, pickup, and return history for an Equipment item.
- Use Equipment and Reservation identities owned by Equipment Scheduling.
- `[inferred]` Apply the proposed handoff eligibility checks before pickup or return.
- `[inferred]` Produce candidate handoff-history signals.
- It does not create Reservations or Maintenance Periods.

# Interfaces

- Performs pickup, return, and history behavior for the
  [Custodian Equipment Interface](../system/interfaces/custodian-equipment.md), which Web Access
  exposes.

# Dependencies

- `[inferred]` Uses [Equipment Scheduling](equipment-scheduling.md) for Equipment and Reservation
  context and to request the Reservation-completion transition.
- External systems: None.

# Modules

- [Equipment Use Management](../modules/equipment-use-management.md) owns pickup, return, and use
  history.

# Runtime notes

- Runs in the same application runtime as the other Components.
- Uses protocol-neutral interaction with Equipment Scheduling.
- No framework, storage product, or separate service runtime is selected.

# Related

- [Technical overview](../system/technical-overview.md)
- [Equipment](../system/data/equipment.md)
- [Reservation](../system/data/reservation.md)
- [Equipment use](../system/data/equipment-use.md)
- [Custodian equipment interface](../system/interfaces/custodian-equipment.md)
- [Record equipment pickup workflow](../system/workflows/record-equipment-pickup.md)
- [Record equipment return workflow](../system/workflows/record-equipment-return.md)
- [Equipment access](../system/authorization/equipment-access.md)
- [Use browser interaction](../system/decisions/0001-browser-interaction.md)
- [Use a modular monolith](../system/decisions/0002-modular-monolith.md)
- [Application runtime](../system/deployment/application-runtime.md)
- [Equipment operations](../system/observability/equipment-operations.md)

# Decomposition

- [Equipment Use Management](../modules/equipment-use-management.md)

# Evidence

- [Equipment Use Management](../modules/equipment-use-management.md)
