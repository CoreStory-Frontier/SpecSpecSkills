---
type: Capability
title: Reserve Equipment
description: Employees reserve an available equipment item for a defined period.
spec_id: CAP-reserve-equipment
layer: L4
provenance: supplied
generator: agent
---

# Purpose

Employees secure the use of one equipment item without creating a reservation conflict.

# Behavior

- An employee selects one equipment item and a defined start and end time.
- The product creates the reservation only when the item is available for the full period.
- The product rejects a reservation that overlaps another confirmed reservation for the same item.
- `[inferred]` The product rejects a reservation when the end time is not after the start time.

# Acceptance

- Given an equipment item is available for the full selected period, when an employee reserves it, then the product confirms the reservation for that item and period.
- Given an existing confirmed reservation overlaps the selected period, when an employee tries to reserve the same item, then the product rejects the new reservation.
- Given a maintenance period overlaps the selected period, when an employee tries to reserve the item, then the product rejects the reservation.
- `[inferred]` Given the selected end time is not after the start time, when an employee submits the reservation, then the product rejects it.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Maintenance period](../../system/data/maintenance-period.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Reserve equipment workflow](../../system/workflows/reserve-equipment.md)
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
- [Reserve equipment workflow](../../system/workflows/reserve-equipment.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)
