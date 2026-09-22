---
type: Capability
title: View Reservations
description: Employees view only their own equipment reservations.
spec_id: CAP-view-reservations
layer: L4
provenance: supplied
generator: agent
---

# Purpose

Employees can review their equipment reservations without seeing another employee's reservations.

# Behavior

- An employee can request their own Reservations.
- The product shows only Reservations assigned to that employee.
- `[inferred]` The product shows an empty result when the employee has no Reservations.
- `[inferred]` The product returns no Reservation data when actor context is absent or access is
  not permitted.

# Acceptance

- Given an employee has Reservations, when the employee requests them, then the product shows
  only that employee's Reservations.
- `[inferred]` Given an employee has no Reservations, when the employee requests them, then the
  product shows an empty result.
- `[inferred]` Given actor context is absent or access is not permitted, when a person requests
  Reservations, then the product returns no Reservation data and reports that the action is
  unavailable.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Reservation](../../system/data/reservation.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)

# Related

- [Product overview](../overview.md)

# Evidence

- [Technical overview](../../system/technical-overview.md)
- [Reservation](../../system/data/reservation.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
