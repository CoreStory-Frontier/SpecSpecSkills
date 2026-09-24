---
type: "Observability"
title: "Equipment Operations"
description: "Application logging emits availability, reservation, invalidation, and handoff events."
spec_id: "OBS-equipment-operations"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Application logging emits availability, reservation, invalidation, and handoff events.

# Signals

- Source log calls occur at `equipment_reservation/equipment_scheduling/schedule_management.py:52` and in the handoff source.

# Alerts

None observed.

# Health

None observed.

# Related

- [Product Overview](../../product/overview.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md); source `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
