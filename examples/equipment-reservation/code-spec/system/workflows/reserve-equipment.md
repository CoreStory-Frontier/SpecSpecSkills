---
type: "Workflow"
title: "Reserve Equipment"
description: "An employee requests and receives a reservation result."
spec_id: "WF-reserve-equipment"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

An employee requests and receives a reservation result.

# Steps

1. A user submits the action through [the interface](../../files/equipment_reservation/web_access/web_interaction.py.md).
2. The application checks actor access through [actor access](../../files/equipment_reservation/web_access/actor_access.py.md).
3. The domain logic handles the action through [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `equipment_reservation/equipment_scheduling/schedule_management.py:1`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md); source `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
