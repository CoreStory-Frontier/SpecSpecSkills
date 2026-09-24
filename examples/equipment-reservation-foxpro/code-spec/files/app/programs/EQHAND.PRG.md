---
type: "Source File"
title: "EQHAND.PRG"
description: "Visual FoxPro source file at app/programs/EQHAND.PRG."
spec_id: "FILE-app-programs-eqhand-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQHAND.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "aeeaeae0bc15d0f5e3a12af87e41ea6d6cde69f7"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQHAND.PRG supports the Equipment Use Management responsibility. The source starts: `* Equipment Use Management Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQHAND.PRG:1`.
- Its direct owning Module is [Equipment Use Management](../../../modules/equipment-use-management.md).

# Symbols

- `Pickup` — FUNCTION Pickup(tcActorId, tnRsvId, ttPickup) Evidence: `app/programs/EQHAND.PRG:4`.
- `ReturnEquipment` — FUNCTION ReturnEquipment(tcActorId, tnUseId, ttReturn) Evidence: `app/programs/EQHAND.PRG:48`.
- `HandoffHistory` — FUNCTION HandoffHistory(tcActorId, tnEquipId) Evidence: `app/programs/EQHAND.PRG:92`.
- `ReservationContext` — FUNCTION ReservationContext(tnRsvId) Evidence: `app/programs/EQHAND.PRG:123`.

# Control flow

- `FUNCTION Pickup` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQHAND.PRG:4`.
- `FUNCTION ReturnEquipment` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQHAND.PRG:48`.
- `FUNCTION HandoffHistory` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQHAND.PRG:92`.
- `FUNCTION ReservationContext` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQHAND.PRG:123`.

# Data & side effects

- DBF write at `app/programs/EQHAND.PRG:33`.
- DBF write at `app/programs/EQHAND.PRG:34`.
- DBF write at `app/programs/EQHAND.PRG:83`.
- database read `equipuse` at `app/programs/EQHAND.PRG:103`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Errors

- `loResult.message = "Actor is not permitted to record pickup."` at `app/programs/EQHAND.PRG:11`.
- `loResult.message = loReservation.message` at `app/programs/EQHAND.PRG:16`.
- `loResult.message = "Pickup requires a confirmed reservation."` at `app/programs/EQHAND.PRG:20`.
- `loResult.message = "Pickup is already recorded."` at `app/programs/EQHAND.PRG:28`.
- `loResult.message = "Actor is not permitted to record return."` at `app/programs/EQHAND.PRG:55`.
- `loResult.message = "Use record does not exist."` at `app/programs/EQHAND.PRG:63`.
- `loResult.message = "Return requires one pickup."` at `app/programs/EQHAND.PRG:68`.
- `loResult.message = "Return is already recorded."` at `app/programs/EQHAND.PRG:73`.
- `loResult.message = "Return time must be after pickup."` at `app/programs/EQHAND.PRG:78`.
- `loResult.message = ""` at `app/programs/EQHAND.PRG:140`.

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Use Management](../../../modules/equipment-use-management.md).

# Evidence

- `app/programs/EQHAND.PRG:1` — file start.
- `git_blob: aeeaeae0bc15d0f5e3a12af87e41ea6d6cde69f7` — source content hash.
