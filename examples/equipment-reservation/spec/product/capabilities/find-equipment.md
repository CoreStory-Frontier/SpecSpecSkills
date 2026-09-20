---
type: Capability
title: Find Equipment
description: Employees find equipment that is available for a selected period.
spec_id: CAP-find-equipment
layer: L4
provenance: supplied
generator: agent
---

# Purpose

Employees identify equipment that they can reserve for a defined start and end time.

# Behavior

- The product tracks each physical equipment item as a unique asset.
- The employee supplies a reservation start time and end time.
- The product shows an item as available only when no reservation overlaps the selected period.
- The product shows an item as unavailable during a maintenance period.

# Acceptance

- Given an equipment item has no overlapping reservation or maintenance period, when an employee searches for the selected period, then the product shows the item as available.
- Given an equipment item has an overlapping reservation, when an employee searches for the selected period, then the product does not show the item as available.
- Given an equipment item has a maintenance period that overlaps the selected period, when an employee searches, then the product does not show the item as available.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Maintenance period](../../system/data/maintenance-period.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
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
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)
