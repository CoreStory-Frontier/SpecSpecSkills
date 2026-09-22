---
type: Workflow
title: Cancel Invalid Reservation
description: Custodian workflow for cancelling a reservation invalidated by maintenance.
spec_id: WF-cancel-invalid-reservation
layer: L3
provenance: supplied
generator: agent
---

# Purpose

This workflow lets a custodian cancel a Reservation that later maintenance made invalid.

# Steps

1. The custodian requests cancellation of one Reservation.
2. The workforce identity source supplies the custodian's actor identity and roles.
3. The system checks that the actor has the custodian role before it processes the request.
   - `[inferred]` If actor context is absent or access is not permitted, the system does not
     cancel the Reservation and reports that the action is unavailable.
4. The system checks that a later Maintenance Period overlaps the Reservation.
5. If no overlapping Maintenance Period exists, the system does not cancel the Reservation.
6. If the overlap exists, the system changes the Reservation from invalid to cancelled.
7. The custodian receives the resulting Reservation state.

# Outcomes

- A Reservation invalidated by later maintenance can become cancelled.
- A Reservation without the maintenance conflict is not cancelled by this workflow.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
