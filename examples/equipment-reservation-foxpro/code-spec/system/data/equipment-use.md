---
type: "Data Entity"
title: "Equipment Use"
description: "Equipment use records pickup and return against a reservation."
spec_id: "ENT-equipment-use"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Equipment use records pickup and return against a reservation.

# Schema

| Field | Observed shape |
|---|---|
| `use_id` | I |
| `rsv_id` | I |
| `equip_id` | I |
| `actor_id` | C(12) |
| `pickup_time` | T |
| `return_time` | T |

Source: `app/setup.prg:25`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- Pickup creates a use record. Return fills its return time. History reads both. Evidence: `app/programs/EQHAND.PRG:2`.

# Invariants

- One pickup is allowed per reservation. Return requires a later time and no earlier return. Evidence: `app/programs/EQHAND.PRG:2`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Equipment Handoff](../../components/equipment-handoff.md).
- [app/programs/EQHAND.PRG](../../files/app/programs/EQHAND.PRG.md); source `app/programs/EQHAND.PRG:1`.
