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

- Employee operations require an employee role; custodian operations require a custodian role. Source: `app/programs/EQACT.PRG:2`.
- Unknown actors and disallowed operations do not reach the domain action. Source: `app/programs/EQWEB.PRG:54`.
- Employees can search, reserve, and view their own reservations. Source: `app/programs/EQACT.PRG:41`.
- Custodians can manage equipment, maintenance, cancellation, handoff, and history. Source: `app/programs/EQACT.PRG:10`.
- An actor with both roles can use actions assigned to either role. Source: `app/programs/EQACT.PRG:2`.
- The local demo actor source is a substitute for employee identity management. Source: `app/programs/EQACT.PRG:1`.
- An unknown actor is denied. Source: `app/programs/EQACT.PRG:1`.

# Acceptance

- Given an actor with only the employee role, when the actor requests a custodian action, then the action is denied. Source: `app/programs/EQACT.PRG:2`. Execution status: see bundle record.
- Given an unknown actor, when the actor requests an action, then the domain operation is not performed. Source: `app/programs/EQWEB.PRG:54`. Execution status: see bundle record.
- Given one actor has both employee and custodian roles, when that actor requests either allowed action, then the role check permits it. Source: `app/programs/EQACT.PRG:2`. Execution status: see bundle record.

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
- Source: [app/programs/EQACT.PRG](../../files/app/programs/EQACT.PRG.md) at `app/programs/EQACT.PRG:1`.
