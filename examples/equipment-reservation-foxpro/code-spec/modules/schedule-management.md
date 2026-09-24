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

- Manage availability, reservations, maintenance, and reservation state. Evidence: [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).

# Public surface

- `FUNCTION Availability` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION Reserve` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION AddMaintenance` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION CancelInvalid` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION MyReservations` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION EquipmentHistory` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION CompleteReturn` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
- `FUNCTION EquipmentExists` — observed in [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).

# Internal structure

- [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).

# Dependencies

- Uses [Web Interaction](web-interaction.md). Evidence: file-level import or call in L0.

# Files

- [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).

# Related

- [Equipment Scheduling](../components/equipment-scheduling.md).

# Decomposition

- [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).

# Evidence

- [app/programs/EQSHED.PRG](../files/app/programs/EQSHED.PRG.md).
