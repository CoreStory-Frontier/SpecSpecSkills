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
| `MAINT_ID` | identity primary key |
| `EQUIP_ID` | foreign key |
| `MAINT_START` | TIMESTAMP |
| `MAINT_END` | TIMESTAMP |
| `MAINT_REASON` | VARCHAR(80) |

Source: `db/schema.sql:34`.

# Relationships

Equipment is referenced by reservation, maintenance, and use records; use records refer to reservations.

# Lifecycle

- A custodian records a period. The source keeps its historical row. Evidence: `app/programs/EQSCH00.cbl:3`.

# Invariants

- The end follows the start. A maintenance period blocks overlap and invalidates confirmed reservations on that equipment. Evidence: `app/programs/EQSCH00.cbl:3`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md); source `app/programs/EQSCH00.cbl:1`.
