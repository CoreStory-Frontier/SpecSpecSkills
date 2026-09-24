---
type: "Data Entity"
title: "Maintenance Period"
description: "Maintenance blocks an equipment period."
spec_id: "ENT-maintenance-period"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

Maintenance blocks an equipment period.

# Schema

| Field | Observed shape |
|---|---|
| `maint_id` | I |
| `equip_id` | I |
| `start_time` | T |
| `end_time` | T |
| `reason` | C(80) |

Source: `app/setup.prg:22`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A custodian records a period. The source keeps its historical row. Evidence: `app/programs/EQSHED.PRG:2`.

# Invariants

- The end follows the start. A maintenance period blocks overlap and invalidates confirmed reservations on that equipment. Evidence: `app/programs/EQSHED.PRG:2`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md); source `app/programs/EQSHED.PRG:1`.
