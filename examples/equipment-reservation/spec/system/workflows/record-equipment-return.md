---
type: Workflow
title: Record Equipment Return
description: Custodian workflow for recording return of equipment after pickup.
spec_id: WF-record-equipment-return
layer: L3
provenance: supplied
generator: agent
---

# Purpose

This workflow records the return of Equipment that an employee picked up.

# Steps

1. The custodian requests return recording for an Equipment Use record.
2. The workforce identity source supplies the custodian's actor identity and roles.
3. The system checks that the actor has the custodian role before it processes the request.
   - `[inferred]` If actor context is absent or access is not permitted, the system records no
     return and reports that the action is unavailable.
4. `[inferred]` The system checks that the Equipment Use record contains pickup and no return.
   - `[inferred]` If no pickup exists or a return already exists, the system records no return.
5. The system records the return time in the Equipment Use record.
6. `[inferred]` The system changes the associated Reservation to completed.
7. `[inferred]` The custodian receives the recorded return result.

# Outcomes

- A recorded return appears in the Equipment item's use history.
- `[inferred]` The associated Reservation becomes completed.
- `[inferred]` A return without one prior pickup is not recorded.

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
