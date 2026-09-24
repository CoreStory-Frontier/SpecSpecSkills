---
type: "Module"
title: "Schedule Management"
description: "Manage availability, reservations, maintenance, and reservation state."
spec_id: "MOD-schedule-management"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Manage availability, reservations, maintenance, and reservation state. This boundary groups the linked source files.

# Responsibilities

- Manage availability, reservations, maintenance, and reservation state. Evidence: [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).

# Public surface

- `PROGRAM-ID. EQSCH00` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `MAIN-PARA` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `CHECK-AVAILABLE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `AVAIL-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `READ-CONTEXT` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `CONTEXT-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `READ-CONTEXT` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `CONTEXT-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `RESERVE-EQUIP` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `RESERVE-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `RECORD-MAINT` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `MAINT-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `CANCEL-INVALID` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `CANCEL-DONE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `LIST-MINE` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `LIST-RESERVATIONS` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- `COMPLETE-RETURN` — observed in [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).

# Internal structure

- [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- [app/copybooks/EQCONST.cpy](../files/app/copybooks/EQCONST.cpy.md).
- [app/copybooks/EQTIMES.cpy](../files/app/copybooks/EQTIMES.cpy.md).

# Dependencies

- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- [app/copybooks/EQCONST.cpy](../files/app/copybooks/EQCONST.cpy.md).
- [app/copybooks/EQTIMES.cpy](../files/app/copybooks/EQTIMES.cpy.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- [app/copybooks/EQCONST.cpy](../files/app/copybooks/EQCONST.cpy.md).
- [app/copybooks/EQTIMES.cpy](../files/app/copybooks/EQTIMES.cpy.md).

# Evidence

- [app/programs/EQSCH00.cbl](../files/app/programs/EQSCH00.cbl.md).
- [app/copybooks/EQCONST.cpy](../files/app/copybooks/EQCONST.cpy.md).
- [app/copybooks/EQTIMES.cpy](../files/app/copybooks/EQTIMES.cpy.md).
