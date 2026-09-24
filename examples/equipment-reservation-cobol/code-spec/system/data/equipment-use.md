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
| `USE_ID` | identity primary key |
| `RSRV_ID` | unique foreign key |
| `EQUIP_ID` | foreign key |
| `ACTOR_ID` | CHAR(12) |
| `PICKUP_TS` | TIMESTAMP |
| `RETURN_TS` | TIMESTAMP nullable |

Source: `db/schema.sql:46`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- Pickup creates a use record. Return fills its return time. History reads both. Evidence: `app/programs/EQHND00.cbl:3`.

# Invariants

- One pickup is allowed per reservation. Return requires a later time and no earlier return. Evidence: `app/programs/EQHND00.cbl:3`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Equipment Handoff](../../components/equipment-handoff.md).
- [app/programs/EQHND00.cbl](../../files/app/programs/EQHND00.cbl.md); source `app/programs/EQHND00.cbl:1`.
