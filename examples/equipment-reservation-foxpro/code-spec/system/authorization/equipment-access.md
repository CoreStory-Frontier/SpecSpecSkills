---
type: "Authorization"
title: "Equipment Access"
description: "Role checks gate protected operations."
spec_id: "AUTHZ-equipment-access"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Role checks gate protected operations.

# Policy

| Role | Operations | Evidence |
|---|---|---|
| Employee | Search, reserve, own reservations | `app/programs/EQACT.PRG:41` |
| Custodian | Add, maintenance, cancel, pickup, return, history | `app/programs/EQACT.PRG:10` |
| Unknown or missing | Denied | `app/programs/EQACT.PRG:2` |

# Enforcement

- The request path checks authorization before dispatch. See [app/programs/EQWEB.PRG](../../files/app/programs/EQWEB.PRG.md).

# Guarantees

The source rejects a disallowed operation through its error path.

# Related

- [Control employee access](../../product/capabilities/control-employee-access.md).

# Decomposition

- [Web Access](../../components/web-access.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [app/programs/EQACT.PRG](../../files/app/programs/EQACT.PRG.md); source `app/programs/EQACT.PRG:1`.
