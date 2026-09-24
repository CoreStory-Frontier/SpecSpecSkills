---
type: "Interface"
title: "Employee Equipment"
description: "Employees search, reserve, and view owned reservations."
spec_id: "IFC-employee-equipment"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Employees search, reserve, and view owned reservations.

# Contract

- Actions: `search, reserve, mine`. The entry path parses input and dispatches the operation. Source: `app/programs/EQWEB.PRG:1`.
- The domain operation returns a result or an error. Source: `app/programs/EQWEB.PRG:53`.

# Schema

- Request fields observed: `actor, action, equip_id, rsv_id, use_id, start, end, name, description, reason`.
- Field parsing or form source: `web/index.html`.
- The response is an operation result or error. Inspect the linked entry Source File for the runtime-specific shape.

# Errors

- Invalid or unauthorized actions use the error path in [app/programs/EQWEB.PRG](../../files/app/programs/EQWEB.PRG.md).

# Guarantees

A request reaches a domain operation only after the observed authorization check.

# Examples

- See the action examples in [README.md](../../files/README.md.md).

# Related

- [Find equipment](../../product/capabilities/find-equipment.md).
- [Reserve equipment](../../product/capabilities/reserve-equipment.md).
- [View reservations](../../product/capabilities/view-reservations.md).
- [Control employee access](../../product/capabilities/control-employee-access.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQWEB.PRG](../../files/app/programs/EQWEB.PRG.md); source `app/programs/EQWEB.PRG:1`.
