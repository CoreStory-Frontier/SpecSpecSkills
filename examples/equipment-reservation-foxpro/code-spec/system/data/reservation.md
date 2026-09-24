---
type: "Data Entity"
title: "Reservation"
description: "A reservation stores an equipment, actor, period, and state."
spec_id: "ENT-reservation"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A reservation stores an equipment, actor, period, and state.

# Schema

| Field | Observed shape |
|---|---|
| `rsv_id` | I |
| `equip_id` | I |
| `actor_id` | C(12) |
| `start_time` | T |
| `end_time` | T |
| `state` | C(10) |

Source: `app/setup.prg:19`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A successful reserve creates a confirmed record. Maintenance can invalidate it. A custodian can cancel an invalid record. Return can complete a confirmed record. Evidence: `app/programs/EQSHED.PRG:2`.

# Invariants

- Only confirmed reservations block overlapping booking. State moves to invalid on overlapping maintenance, cancelled after invalidation, or completed after eligible return. Evidence: `app/programs/EQSHED.PRG:2`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).
- [View reservations](../../product/capabilities/view-reservations.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md); source `app/programs/EQSHED.PRG:1`.
