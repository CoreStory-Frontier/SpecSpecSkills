---
type: Module
title: Schedule Management
description: Reservation, maintenance, availability, and conflict behavior.
spec_id: MOD-schedule-management
layer: L1
provenance: supplied
generator: agent
---

# Purpose

Schedule Management owns Reservation and Maintenance Period data. `[inferred]` It owns the
consistency boundary for availability, time conflicts, and Reservation state changes.

# Responsibilities

- `[inferred]` Own Reservation and Maintenance Period records.
- `[inferred]` Find availability for an Equipment item and a selected period.
- `[inferred]` Reject a Reservation or Maintenance Period when its end time is not after its start
  time.
- `[inferred]` Create one confirmed Reservation when no schedule conflict exists.
- `[inferred]` Prevent overlapping confirmed Reservations for one Equipment item.
- `[inferred]` Confirm one request and reject the other when concurrent Reservation requests
  conflict.
- Record Maintenance Periods and invalidate overlapping confirmed Reservations, including after pickup.
- `[inferred]` Cancel a Reservation only when later maintenance made it invalid.
- Complete confirmed Reservations after return; preserve invalid and cancelled states.
- Use UTC times and half-open periods. Only confirmed Reservations block booking availability.
- `[inferred]` Produce candidate reservation, availability, and invalid-reservation signals.
- `[inferred]` It does not own Equipment or Equipment Use records.

# Public surface

| Planned contract | Owner | Consumer | Purpose |
|---|---|---|---|
| `[inferred]` Availability decision | Schedule Management | Scheduling Operations | Report whether an Equipment item is available for a period. |
| `[inferred]` Reservation lifecycle | Schedule Management | Scheduling Operations | Create, read, invalidate, cancel, or complete a Reservation. |
| `[inferred]` Maintenance schedule | Schedule Management | Scheduling Operations | Record Maintenance Periods and report affected Reservations. |

# Internal structure

- `[inferred]` Conflict behavior evaluates Reservation and Maintenance Period overlap.
- `[inferred]` Reservation lifecycle behavior controls valid Reservation state changes.
- Maintenance behavior blocks Equipment and invalidates overlapping confirmed Reservations only.
- `[inferred]` Signal behavior describes candidate schedule outcomes.

# Dependencies

- `[inferred]` Uses [Equipment Catalog](equipment-catalog.md) to validate Equipment identity.
- `[inferred]` [Scheduling Operations](scheduling-operations.md) uses Schedule Management.

# Files

_L0 source-file documentation is outside this design scope._

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md)

# Decomposition

_L1 is the terminal layer of this design bundle._

# Evidence

_L0 evidence is outside this design scope._
