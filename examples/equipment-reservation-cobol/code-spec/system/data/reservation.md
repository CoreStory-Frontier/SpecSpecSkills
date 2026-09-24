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
| `RSRV_ID` | identity primary key |
| `EQUIP_ID` | foreign key |
| `ACTOR_ID` | CHAR(12) |
| `RSRV_START` | TIMESTAMP |
| `RSRV_END` | TIMESTAMP |
| `RSRV_STATE` | checked |

Source: `db/schema.sql:19`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A successful reserve creates a confirmed record. Maintenance can invalidate it. A custodian can cancel an invalid record. Return can complete a confirmed record. Evidence: `app/programs/EQSCH00.cbl:3`.

# Invariants

- Only confirmed reservations block overlapping booking. State moves to invalid on overlapping maintenance, cancelled after invalidation, or completed after eligible return. Evidence: `app/programs/EQSCH00.cbl:3`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).
- [View reservations](../../product/capabilities/view-reservations.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md); source `app/programs/EQSCH00.cbl:1`.
