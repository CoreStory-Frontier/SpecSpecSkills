---
type: Capability
title: Control Employee Access
description: The product controls employee access to equipment functions.
spec_id: CAP-control-employee-access
layer: L4
provenance: supplied
generator: agent
---

# Purpose

The product controls employee access to equipment functions. A user can have both employee and
custodian roles.

# Behavior

- Employees can find and reserve equipment.
- Employees can view their own reservations.
- Custodians can manage equipment, maintenance, pickup, return, and invalid reservations.
- Custodians can view equipment history.
- The product does not manage employee identities.
- The product uses employee and custodian roles as access rules.
- The product does not perform an action that the actor's roles do not permit.

# Acceptance

- Given an employee uses a permitted employee function, when the product checks access, then the product performs the action.
- Given an employee attempts a custodian function without the custodian role, when the product checks access, then the product does not perform the action.
- Given a custodian uses a permitted custodian function, when the product checks access, then the product performs the action.
- Given a user has both roles, when the product checks access, then the product permits the functions assigned to both roles.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Workforce identity interface](../../system/interfaces/workforce-identity.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)

# Related

- [Product overview](../overview.md)

# Evidence

- [Technical overview](../../system/technical-overview.md)
- [Employee equipment interface](../../system/interfaces/employee-equipment.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Workforce identity interface](../../system/interfaces/workforce-identity.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
