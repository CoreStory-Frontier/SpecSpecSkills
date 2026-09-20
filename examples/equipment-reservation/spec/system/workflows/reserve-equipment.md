---
type: Workflow
title: Reserve Equipment
description: Employee workflow for creating one conflict-free equipment reservation.
spec_id: WF-reserve-equipment
layer: L3
provenance: supplied
generator: agent
---

# Purpose

This workflow confirms one Reservation only when access, period, and availability checks pass.

# Steps

1. The employee requests one Equipment item for a start time and end time.
2. The workforce identity source supplies the employee's actor identity and roles.
3. The system checks that the actor has the employee role before it processes the request.
   - `[inferred]` If actor context is absent or access is not permitted, the system does not create
     a Reservation and reports that the action is unavailable.
4. `[inferred]` The system checks that the end time is after the start time.
   - `[inferred]` If the period is invalid, the system rejects the request.
5. The system checks the Equipment item for an overlapping Reservation.
6. The system checks the Equipment item for an overlapping Maintenance Period.
7. If either conflict exists, the system rejects the request and creates no Reservation.
8. If concurrent requests conflict, the system confirms one request and rejects the other.
9. If all checks pass, the system creates a confirmed Reservation for the employee and item.
10. The employee receives the confirmed Reservation or a rejection result.

# Outcomes

- One conflict-free request creates one confirmed Reservation.
- A conflicting request creates no Reservation.
- Concurrent conflicting requests cannot create overlapping confirmed Reservations.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md)

# Decomposition

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)

# Evidence

- [Web Access](../../components/web-access.md)
- [Equipment Scheduling](../../components/equipment-scheduling.md)
