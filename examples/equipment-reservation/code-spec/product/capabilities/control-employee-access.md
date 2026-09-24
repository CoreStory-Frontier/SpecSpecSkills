---
type: "Capability"
title: "Control employee access"
description: "The application applies role rules before protected operations."
spec_id: "CAP-control-employee-access"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] The application applies role rules before protected operations. The intent is inferred from the implemented action.

# Behavior

- Employee operations require an employee role; custodian operations require a custodian role. Source: `equipment_reservation/web_access/actor_access.py:17`.
- Unknown actors and disallowed operations do not reach the domain action. Source: `equipment_reservation/web_access/web_interaction.py:36`.
- Employees can search, reserve, and view their own reservations. Source: `equipment_reservation/web_access/actor_access.py:10`.
- Custodians can manage equipment, maintenance, cancellation, handoff, and history. Source: `equipment_reservation/web_access/actor_access.py:11`.
- An actor with both roles can use actions assigned to either role. Source: `equipment_reservation/web_access/actor_access.py:18`.
- The local demo actor source is a substitute for employee identity management. Source: `equipment_reservation/web_access/actor_access.py:3`.
- An unknown actor is denied. Source: `equipment_reservation/web_access/actor_access.py:3`.

# Acceptance

- Given an actor with only the employee role, when the actor requests a custodian action, then the action is denied. Source: `equipment_reservation/web_access/actor_access.py:17`. Execution status: see bundle record.
- Given an unknown actor, when the actor requests an action, then the domain operation is not performed. Source: `equipment_reservation/web_access/web_interaction.py:36`. Execution status: see bundle record.
- Given one actor has both employee and custodian roles, when that actor requests either allowed action, then the role check permits it. Source: `equipment_reservation/web_access/actor_access.py:18`. Execution status: see bundle record.

# Realized by

- [Equipment Access](../../system/authorization/equipment-access.md).
- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Equipment Access](../../system/authorization/equipment-access.md).
- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- Source: [equipment_reservation/web_access/actor_access.py](../../files/equipment_reservation/web_access/actor_access.py.md) at `equipment_reservation/web_access/actor_access.py:1`.
