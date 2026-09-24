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
| Employee | Search, reserve, own reservations | `app/programs/EQACT00.cbl:38` |
| Custodian | Add, maintenance, cancel, pickup, return, history | `app/programs/EQACT00.cbl:26` |
| Unknown or missing | Denied | `app/programs/EQACT00.cbl:74` |

# Enforcement

- The request path checks authorization before dispatch. See [app/programs/EQWEB00.cbl](../../files/app/programs/EQWEB00.cbl.md).

# Guarantees

The source rejects a disallowed operation through its error path.

# Related

- [Control employee access](../../product/capabilities/control-employee-access.md).

# Decomposition

- [Web Access](../../components/web-access.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [app/programs/EQACT00.cbl](../../files/app/programs/EQACT00.cbl.md); source `app/programs/EQACT00.cbl:1`.
