---
type: "Module"
title: "Scheduling Operations"
description: "Route scheduling operations and provide cross-module contracts."
spec_id: "MOD-scheduling-operations"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Route scheduling operations and provide cross-module contracts. This boundary groups the linked source files.

# Responsibilities

- Route scheduling operations and provide cross-module contracts. Evidence: [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).

# Public surface

- `PROGRAM-ID. EQOPS00` — observed in [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- `MAIN-PARA` — observed in [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- `SEARCH-EQUIP` — observed in [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- `SEARCH-DONE` — observed in [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).

# Internal structure

- [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- [app/copybooks/EQCOMM.cpy](../files/app/copybooks/EQCOMM.cpy.md).

# Dependencies

- Uses [Equipment Catalog](equipment-catalog.md). Evidence: file-level import or call in L0.
- Uses [Schedule Management](schedule-management.md). Evidence: file-level import or call in L0.
- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.
- Uses [Equipment Use Management](equipment-use-management.md). Evidence: file-level import or call in L0.
- Uses [Actor Access](actor-access.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- [app/copybooks/EQCOMM.cpy](../files/app/copybooks/EQCOMM.cpy.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- [app/copybooks/EQCOMM.cpy](../files/app/copybooks/EQCOMM.cpy.md).

# Evidence

- [app/programs/EQOPS00.cbl](../files/app/programs/EQOPS00.cbl.md).
- [app/copybooks/EQCOMM.cpy](../files/app/copybooks/EQCOMM.cpy.md).
