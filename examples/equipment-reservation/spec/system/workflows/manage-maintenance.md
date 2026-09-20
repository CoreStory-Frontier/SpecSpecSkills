---
type: Workflow
title: Manage Maintenance
description: Custodian workflow for recording equipment maintenance and finding invalid reservations.
spec_id: WF-manage-maintenance
layer: L3
provenance: supplied
generator: agent
---

# Purpose

This workflow makes one Equipment item unavailable for maintenance. It identifies Reservations
that the later Maintenance Period makes invalid.

# Steps

1. The custodian requests a Maintenance Period for one Equipment item.
2. The workforce identity source supplies the custodian's actor identity and roles.
3. The system checks that the actor has the custodian role before it processes the request.
   - `[inferred]` If actor context is absent or access is not permitted, the system records no
     Maintenance Period and reports that the action is unavailable.
4. `[inferred]` The system checks that the end time is after the start time.
   - `[inferred]` If the period is invalid, the system rejects the request.
5. The system records the Maintenance Period for the Equipment item.
6. The system makes the Equipment item unavailable during that period.
7. The system finds each Reservation that overlaps the new Maintenance Period.
8. The system marks each overlapping Reservation as invalid.
9. `[inferred]` The custodian receives the Maintenance Period and the set of invalid Reservations.

# Outcomes

- The Equipment item is unavailable during the Maintenance Period.
- Each Reservation that the later Maintenance Period overlaps becomes invalid.
- Non-overlapping Reservations keep their current state.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
