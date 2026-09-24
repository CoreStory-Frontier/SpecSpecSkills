---
type: "Module"
title: "Equipment Use Management"
description: "Record pickup, return, and equipment-use history."
spec_id: "MOD-equipment-use-management"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Record pickup, return, and equipment-use history. This boundary groups the linked source files.

# Responsibilities

- Record pickup, return, and equipment-use history. Evidence: [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).

# Public surface

- `PROGRAM-ID. EQHND00` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `MAIN-PARA` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `RECORD-PICKUP` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `PICKUP-DONE` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `RECORD-RETURN` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `RETURN-DONE` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `HISTORY` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
- `HISTORY-DONE` — observed in [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).

# Internal structure

- [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).

# Dependencies

- Uses [Scheduling Operations](scheduling-operations.md). Evidence: file-level import or call in L0.
- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.
- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).

# Related

- [Equipment Handoff](../components/equipment-handoff.md).

# Decomposition

- [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).

# Evidence

- [app/programs/EQHND00.cbl](../files/app/programs/EQHND00.cbl.md).
