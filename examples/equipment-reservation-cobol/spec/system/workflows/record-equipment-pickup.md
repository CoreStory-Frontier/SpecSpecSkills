---
type: Workflow
title: Record Equipment Pickup
description: Custodian workflow for recording employee pickup of reserved equipment.
spec_id: WF-record-equipment-pickup
layer: L3
provenance: supplied
generator: agent
---

# Purpose

This workflow records the handoff of reserved Equipment to an employee.

# Steps

1. The custodian requests pickup recording for a Reservation.
2. The workforce identity source supplies the custodian's actor identity and roles.
3. The system checks that the actor has the custodian role before it processes the request.
   - `[inferred]` If actor context is absent or access is not permitted, the system creates no
     Equipment Use record and reports that the action is unavailable.
4. `[inferred]` The system checks that the Reservation is confirmed.
   - `[inferred]` If the Reservation is not confirmed, the system records no pickup.
5. `[inferred]` The system checks that the Reservation has no Equipment Use record.
   - `[inferred]` If a record exists, the system records no second pickup.
6. The system creates an Equipment Use record with the Reservation, Equipment, employee, and
   pickup time.
7. `[inferred]` The custodian receives the recorded pickup result.

# Outcomes

- A recorded pickup appears in the Equipment item's use history.
- `[inferred]` An ineligible or duplicate pickup creates no Equipment Use record.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
