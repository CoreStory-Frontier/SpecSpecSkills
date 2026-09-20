---
type: Deployment
title: Application Runtime
description: One deployable application runtime for equipment reservation.
spec_id: DEPLOY-application-runtime
layer: L3
provenance: supplied
generator: agent
---

# Purpose

The Application Runtime contains the Equipment Reservation application in one deployable unit.

# Topology

- One application runtime contains browser access, equipment scheduling, equipment handoff, and
  access-control responsibilities.
- The workforce identity source remains an external system.
- No other external integration is in scope.
- No separate service runtime is required for an internal responsibility boundary.

# Environments

None supplied.

# Configuration

None supplied.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [View reservations](../../product/capabilities/view-reservations.md)
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../../product/capabilities/track-equipment-use.md)
- [Control employee access](../../product/capabilities/control-employee-access.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
