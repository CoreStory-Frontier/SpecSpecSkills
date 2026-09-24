---
type: "Source File"
title: "EQSHED.PRG"
description: "Visual FoxPro source file at app/programs/EQSHED.PRG."
spec_id: "FILE-app-programs-eqshed-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQSHED.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "082b7bbb204142f08e31556fa3ef0896b49a0cb0"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQSHED.PRG supports the Schedule Management responsibility. The source starts: `* Schedule Management Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQSHED.PRG:1`.
- Its direct owning Module is [Schedule Management](../../../modules/schedule-management.md).

# Symbols

- `Availability` — FUNCTION Availability(tnEquipId, ttStart, ttEnd) Evidence: `app/programs/EQSHED.PRG:4`.
- `Reserve` — FUNCTION Reserve(tcActorId, tnEquipId, ttStart, ttEnd) Evidence: `app/programs/EQSHED.PRG:33`.
- `AddMaintenance` — FUNCTION AddMaintenance(tcActorId, tnEquipId, ttStart, ttEnd, tcReason) Evidence: `app/programs/EQSHED.PRG:86`.
- `CancelInvalid` — FUNCTION CancelInvalid(tcActorId, tnRsvId) Evidence: `app/programs/EQSHED.PRG:146`.
- `MyReservations` — FUNCTION MyReservations(tcActorId) Evidence: `app/programs/EQSHED.PRG:189`.
- `EquipmentHistory` — FUNCTION EquipmentHistory(tnEquipId) Evidence: `app/programs/EQSHED.PRG:221`.
- `CompleteReturn` — FUNCTION CompleteReturn(tnRsvId) Evidence: `app/programs/EQSHED.PRG:251`.
- `EquipmentExists` — FUNCTION EquipmentExists(tnEquipId) Evidence: `app/programs/EQSHED.PRG:264`.

# Control flow

- `FUNCTION Availability` checks a condition, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:4`.
- `FUNCTION Reserve` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:33`.
- `FUNCTION AddMaintenance` checks a condition, iterates over records, updates rows, reads rows. Entry: `app/programs/EQSHED.PRG:86`.
- `FUNCTION CancelInvalid` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:146`.
- `FUNCTION MyReservations` checks a condition, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:189`.
- `FUNCTION EquipmentHistory` checks a condition, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:221`.
- `FUNCTION CompleteReturn` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:251`.
- `FUNCTION EquipmentExists` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQSHED.PRG:264`.

# Data & side effects

- database read `reservations` at `app/programs/EQSHED.PRG:12`.
- database read `maintenance` at `app/programs/EQSHED.PRG:21`.
- DBF write at `app/programs/EQSHED.PRG:69`.
- DBF write at `app/programs/EQSHED.PRG:70`.
- DBF write at `app/programs/EQSHED.PRG:117`.
- DBF write at `app/programs/EQSHED.PRG:118`.
- database read `reservations` at `app/programs/EQSHED.PRG:123`.
- database write `reservations` at `app/programs/EQSHED.PRG:132`.
- database read `maintenance` at `app/programs/EQSHED.PRG:170`.
- DBF write at `app/programs/EQSHED.PRG:180`.
- database read `reservations` at `app/programs/EQSHED.PRG:198`.
- database read `reservations` at `app/programs/EQSHED.PRG:227`.
- DBF write at `app/programs/EQSHED.PRG:258`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Errors

- `loResult.message = "Actor is not permitted to reserve equipment."` at `app/programs/EQSHED.PRG:40`.
- `loResult.message = "End time must be after start time."` at `app/programs/EQSHED.PRG:44`.
- `loResult.message = "Equipment does not exist."` at `app/programs/EQSHED.PRG:48`.
- `loResult.message = "Equipment is busy. Try again."` at `app/programs/EQSHED.PRG:56`.
- `loResult.message = "Equipment is unavailable for that period."` at `app/programs/EQSHED.PRG:61`.
- `loResult.message = "Actor is not permitted to record maintenance."` at `app/programs/EQSHED.PRG:94`.
- `loResult.message = "End time must be after start time."` at `app/programs/EQSHED.PRG:98`.
- `loResult.message = "Equipment does not exist."` at `app/programs/EQSHED.PRG:102`.
- `loResult.message = "Equipment is busy. Try again."` at `app/programs/EQSHED.PRG:110`.
- `loResult.message = "Actor is not permitted to cancel a reservation."` at `app/programs/EQSHED.PRG:153`.
- `loResult.message = "Reservation does not exist."` at `app/programs/EQSHED.PRG:161`.
- `loResult.message = "Only an invalid reservation can be cancelled."` at `app/programs/EQSHED.PRG:166`.
- `loResult.message = "Reservation has no overlapping maintenance."` at `app/programs/EQSHED.PRG:176`.

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Schedule Management](../../../modules/schedule-management.md).

# Evidence

- `app/programs/EQSHED.PRG:1` — file start.
- `git_blob: 082b7bbb204142f08e31556fa3ef0896b49a0cb0` — source content hash.
