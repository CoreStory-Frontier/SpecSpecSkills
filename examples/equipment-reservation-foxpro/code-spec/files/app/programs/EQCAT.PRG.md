---
type: "Source File"
title: "EQCAT.PRG"
description: "Visual FoxPro source file at app/programs/EQCAT.PRG."
spec_id: "FILE-app-programs-eqcat-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQCAT.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "69ffb4459b9ac2997723926cea2ad1432b6a1b89"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQCAT.PRG supports the Equipment Catalog responsibility. The source starts: `* Equipment Catalog Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQCAT.PRG:1`.
- Its direct owning Module is [Equipment Catalog](../../../modules/equipment-catalog.md).

# Symbols

- `AddEquipment` — FUNCTION AddEquipment(tcActorId, tcName, tcDescription) Evidence: `app/programs/EQCAT.PRG:4`.
- `ListEquipment` — FUNCTION ListEquipment(tcActorId) Evidence: `app/programs/EQCAT.PRG:43`.
- `GetEquipment` — FUNCTION GetEquipment(tcEquipId) Evidence: `app/programs/EQCAT.PRG:71`.

# Control flow

- `FUNCTION AddEquipment` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQCAT.PRG:4`.
- `FUNCTION ListEquipment` checks a condition, reads rows, returns a result. Entry: `app/programs/EQCAT.PRG:43`.
- `FUNCTION GetEquipment` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQCAT.PRG:71`.

# Data & side effects

- DBF write at `app/programs/EQCAT.PRG:32`.
- DBF write at `app/programs/EQCAT.PRG:33`.
- database read `equipment` at `app/programs/EQCAT.PRG:53`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Errors

- `loResult.message = "Actor is not permitted to add equipment."` at `app/programs/EQCAT.PRG:11`.
- `loResult.message = "Equipment name is required."` at `app/programs/EQCAT.PRG:15`.
- `loResult.message = "Equipment name already exists."` at `app/programs/EQCAT.PRG:25`.

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Catalog](../../../modules/equipment-catalog.md).

# Evidence

- `app/programs/EQCAT.PRG:1` — file start.
- `git_blob: 69ffb4459b9ac2997723926cea2ad1432b6a1b89` — source content hash.
