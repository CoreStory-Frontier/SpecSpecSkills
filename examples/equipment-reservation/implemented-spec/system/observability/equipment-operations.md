---
type: Observability
title: Equipment Operations
description: Candidate signals for reservation conflicts, availability, and equipment history.
spec_id: OBS-equipment-operations
layer: L3
provenance: supplied
generator: agent
---

# Purpose

Equipment Operations defines candidate signals for the supplied product success measures. No
numeric target, alert threshold, or service level is supplied.

# Signals

| Name | Kind | Dimensions | Meaning |
|---|---|---|---|
| `[inferred]` Reservation conflict result | Event | Equipment item and result | Counts confirmed and rejected conflicting requests. |
| `[inferred]` Availability result | Event | Equipment item, selected period, observed result, and availability reason | Records the availability result and whether reservation or maintenance made an item unavailable. |
| `[inferred]` Handoff history event | Event | Equipment item and event kind | Records pickup and return events used for traceable history. |
| `[inferred]` Invalid reservation event | Event | Equipment item and Reservation | Records a Reservation invalidated by later maintenance. |

# Alerts

None supplied.

# Health

None supplied.

# Related

- [Find equipment](../../product/capabilities/find-equipment.md)
- [Reserve equipment](../../product/capabilities/reserve-equipment.md)
- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md)
- [Track equipment use](../../product/capabilities/track-equipment-use.md)

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md)
- [Equipment Handoff](../../components/equipment-handoff.md)
