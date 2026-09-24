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

- Route scheduling operations and provide cross-module contracts. Evidence: [app/setup.prg](../files/app/setup.prg.md).

# Public surface

- `FUNCTION SearchEquipment` — observed in [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).
- `FUNCTION Execute` — observed in [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).

# Internal structure

- [app/setup.prg](../files/app/setup.prg.md).
- [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).
- [app/programs/EQDB.PRG](../files/app/programs/EQDB.PRG.md).

# Dependencies

- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [app/setup.prg](../files/app/setup.prg.md).
- [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).
- [app/programs/EQDB.PRG](../files/app/programs/EQDB.PRG.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/setup.prg](../files/app/setup.prg.md).
- [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).
- [app/programs/EQDB.PRG](../files/app/programs/EQDB.PRG.md).

# Evidence

- [app/setup.prg](../files/app/setup.prg.md).
- [app/programs/EQOPS.PRG](../files/app/programs/EQOPS.PRG.md).
- [app/programs/EQDB.PRG](../files/app/programs/EQDB.PRG.md).
