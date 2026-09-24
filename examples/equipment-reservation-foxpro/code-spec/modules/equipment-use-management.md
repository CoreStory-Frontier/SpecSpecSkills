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

- Record pickup, return, and equipment-use history. Evidence: [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).

# Public surface

- `FUNCTION Pickup` — observed in [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).
- `FUNCTION ReturnEquipment` — observed in [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).
- `FUNCTION HandoffHistory` — observed in [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).
- `FUNCTION ReservationContext` — observed in [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).

# Internal structure

- [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).

# Dependencies

- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).

# Related

- [Equipment Handoff](../components/equipment-handoff.md).

# Decomposition

- [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).

# Evidence

- [app/programs/EQHAND.PRG](../files/app/programs/EQHAND.PRG.md).
