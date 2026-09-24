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

- Actions: `add, maintenance, cancel, pickup, return, history`. The entry path parses input and dispatches the operation. Source: `equipment_reservation/web_access/web_interaction.py:35`.
- The domain operation returns a result or an error. Source: `equipment_reservation/web_access/web_interaction.py:44`.

# Schema

- Request fields observed: `identity, csrf, operation, equipment_id, reservation_id, use_id, name, description, start, end, reason, pickup_time, return_time`.
- Field parsing or form source: `equipment_reservation/web_access/web_interaction.py`.
- The response is an operation result or error. Inspect the linked entry Source File for the runtime-specific shape.

# Errors

- Invalid or unauthorized actions use the error path in [equipment_reservation/web_access/web_interaction.py](../../files/equipment_reservation/web_access/web_interaction.py.md).

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
- [equipment_reservation/web_access/web_interaction.py](../../files/equipment_reservation/web_access/web_interaction.py.md); source `equipment_reservation/web_access/web_interaction.py:1`.
