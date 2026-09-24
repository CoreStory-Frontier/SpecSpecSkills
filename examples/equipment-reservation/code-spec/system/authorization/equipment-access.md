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
| Employee | Search, reserve, own reservations | `equipment_reservation/web_access/actor_access.py:10` |
| Custodian | Add, maintenance, cancel, pickup, return, history | `equipment_reservation/web_access/actor_access.py:11` |
| Unknown or missing | Denied | `equipment_reservation/web_access/actor_access.py:17` |

# Enforcement

- The request path checks authorization before dispatch. See [equipment_reservation/web_access/web_interaction.py](../../files/equipment_reservation/web_access/web_interaction.py.md).

# Guarantees

The source rejects a disallowed operation through its error path.

# Related

- [Control employee access](../../product/capabilities/control-employee-access.md).

# Decomposition

- [Web Access](../../components/web-access.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [equipment_reservation/web_access/actor_access.py](../../files/equipment_reservation/web_access/actor_access.py.md); source `equipment_reservation/web_access/actor_access.py:1`.
