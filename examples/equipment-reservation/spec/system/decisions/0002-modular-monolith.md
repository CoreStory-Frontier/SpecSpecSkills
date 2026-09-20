---
type: Decision
title: Use a Modular Monolith
description: Use one deployable application with internal responsibility boundaries.
spec_id: ADR-0002
layer: L3
provenance: supplied
generator: agent
status: proposed
---

# Status

Proposed.

# Context

The application has separate browser access, scheduling, and handoff responsibilities.
`[inferred]` No independent scaling, availability, or isolation requirement is known for these
responsibilities.

# Decision

Use one deployable application runtime. Keep browser access, equipment scheduling, and equipment
handoff as separate internal responsibility boundaries.

# Consequences

- `[inferred]` One deployment can contain all application responsibilities.
- `[inferred]` Internal boundaries can change without a network service boundary.
- `[inferred]` The scheduling boundary can own reservation consistency without a distributed
  transaction.
- `[inferred]` A later design can separate a boundary if scaling, availability, or isolation needs
  change.
- `[inferred]` A failure in the application runtime can affect all three responsibility
  boundaries.

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
