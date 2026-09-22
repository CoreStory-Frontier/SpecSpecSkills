---
type: Decision
title: Use Browser Interaction
description: Use a browser application with protocol-neutral system contracts.
spec_id: ADR-0001
layer: L3
provenance: supplied
generator: agent
status: proposed
---

# Status

Proposed.

# Context

Employees and custodians need an interaction channel for equipment reservation and management.
No framework, network protocol, or vendor is selected.

# Decision

Use a browser-based application. Keep the system contracts below the browser boundary
protocol-neutral.

# Consequences

- `[inferred]` Employees and custodians can use the product without a dedicated installed client.
- `[inferred]` The implementation must provide browser interactions for both roles.
- `[inferred]` A later design decision must select the browser delivery and system protocols.
- `[inferred]` Protocol-neutral L3 contracts do not specify transport-level behavior.

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
