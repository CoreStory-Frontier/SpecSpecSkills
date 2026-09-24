---
type: "Interface"
title: "Custodian Equipment"
description: "Custodians add equipment, manage maintenance, and record handoff."
spec_id: "IFC-custodian-equipment"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Custodians add equipment, manage maintenance, and record handoff.

# Contract

- Actions: `add, maintenance, cancel, pickup, return, history`. The entry path parses input and dispatches the operation. Source: `app/programs/EQWEB.PRG:1`.
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

- [View reservations](../../product/capabilities/view-reservations.md).
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).
- [Track equipment use](../../product/capabilities/track-equipment-use.md).
- [Control employee access](../../product/capabilities/control-employee-access.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [app/programs/EQWEB.PRG](../../files/app/programs/EQWEB.PRG.md); source `app/programs/EQWEB.PRG:1`.
