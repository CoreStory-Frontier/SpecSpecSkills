---
type: "Workflow"
title: "Record Equipment Return"
description: "A custodian records return and completes an eligible reservation."
spec_id: "WF-record-equipment-return"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A custodian records return and completes an eligible reservation.

# Steps

1. A user submits the action through [the interface](../../files/equipment_reservation/web_access/web_interaction.py.md).
2. The application checks actor access through [actor access](../../files/equipment_reservation/web_access/actor_access.py.md).
3. The domain logic handles the action through [equipment_reservation/equipment_handoff/equipment_use_management.py](../../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `equipment_reservation/equipment_handoff/equipment_use_management.py:1`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [equipment_reservation/equipment_handoff/equipment_use_management.py](../../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md); source `equipment_reservation/equipment_handoff/equipment_use_management.py:1`.
