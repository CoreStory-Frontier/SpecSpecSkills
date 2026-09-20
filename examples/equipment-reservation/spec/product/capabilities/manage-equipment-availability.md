---
type: Capability
title: Manage Equipment Availability
description: Custodians manage equipment records, maintenance periods, and invalid reservations.
spec_id: CAP-manage-equipment-availability
layer: L4
provenance: supplied
generator: agent
---

# Purpose

Custodians keep equipment records and availability current.

# Behavior

- A custodian adds each physical equipment item as a unique asset.
- A custodian blocks an equipment item for a maintenance period.
- The product makes an item unavailable during its maintenance period.
- A custodian can cancel an invalid reservation.
- A later maintenance period makes an overlapping reservation invalid.

# Acceptance

- Given two physical equipment items, when a custodian adds both items, then the product creates two distinct equipment records.
- Given a custodian records a maintenance period, when that period overlaps an employee search, then the product shows the item as unavailable.
- Given a later maintenance period overlaps a reservation, when the product records the period, then the product treats the reservation as invalid.
- Given a custodian identifies a reservation as invalid, when the custodian cancels it, then the product shows the reservation as cancelled.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Maintenance period](../../system/data/maintenance-period.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Manage maintenance workflow](../../system/workflows/manage-maintenance.md)
- [Cancel invalid reservation workflow](../../system/workflows/cancel-invalid-reservation.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)

# Related

- [Product overview](../overview.md)

# Evidence

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Maintenance period](../../system/data/maintenance-period.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Manage maintenance workflow](../../system/workflows/manage-maintenance.md)
- [Cancel invalid reservation workflow](../../system/workflows/cancel-invalid-reservation.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)
