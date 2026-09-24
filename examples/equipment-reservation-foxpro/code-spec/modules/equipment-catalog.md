---
type: "Module"
title: "Equipment Catalog"
description: "Create and read equipment records."
spec_id: "MOD-equipment-catalog"
layer: "L1"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] Create and read equipment records. This boundary groups the linked source files.

# Responsibilities

- Create and read equipment records. Evidence: [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).

# Public surface

- `FUNCTION AddEquipment` — observed in [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).
- `FUNCTION ListEquipment` — observed in [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).
- `FUNCTION GetEquipment` — observed in [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).

# Internal structure

- [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).

# Dependencies

- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).

# Evidence

- [app/programs/EQCAT.PRG](../files/app/programs/EQCAT.PRG.md).
