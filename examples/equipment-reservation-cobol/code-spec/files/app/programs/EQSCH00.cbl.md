---
type: "Source File"
title: "EQSCH00.cbl"
description: "COBOL source file at app/programs/EQSCH00.cbl."
spec_id: "FILE-app-programs-eqsch00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQSCH00.cbl"
language: "COBOL"
role: "source"
git_blob: "1c72bdaf42acf92b2a1a6db94a9de37e488e367b"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQSCH00.cbl supports the Schedule Management responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQSCH00.cbl:1`.
- Its direct owning Module is [Schedule Management](../../../modules/schedule-management.md).

# Symbols

- `EQSCH00` — PROGRAM-ID. EQSCH00. Evidence: `app/programs/EQSCH00.cbl:6`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQSCH00.cbl:19`.
- `CHECK-AVAILABLE` — CHECK-AVAILABLE. Evidence: `app/programs/EQSCH00.cbl:46`.
- `AVAIL-DONE` — AVAIL-DONE. Evidence: `app/programs/EQSCH00.cbl:82`.
- `READ-CONTEXT` — READ-CONTEXT. Evidence: `app/programs/EQSCH00.cbl:85`.
- `CONTEXT-DONE` — CONTEXT-DONE. Evidence: `app/programs/EQSCH00.cbl:105`.
- `READ-CONTEXT` — READ-CONTEXT. Evidence: `app/programs/EQSCH00.cbl:108`.
- `CONTEXT-DONE` — CONTEXT-DONE. Evidence: `app/programs/EQSCH00.cbl:128`.
- `RESERVE-EQUIP` — RESERVE-EQUIP. Evidence: `app/programs/EQSCH00.cbl:131`.
- `RESERVE-DONE` — RESERVE-DONE. Evidence: `app/programs/EQSCH00.cbl:186`.
- `RECORD-MAINT` — RECORD-MAINT. Evidence: `app/programs/EQSCH00.cbl:189`.
- `MAINT-DONE` — MAINT-DONE. Evidence: `app/programs/EQSCH00.cbl:262`.
- `CANCEL-INVALID` — CANCEL-INVALID. Evidence: `app/programs/EQSCH00.cbl:265`.
- `CANCEL-DONE` — CANCEL-DONE. Evidence: `app/programs/EQSCH00.cbl:316`.
- `LIST-MINE` — LIST-MINE. Evidence: `app/programs/EQSCH00.cbl:319`.
- `LIST-RESERVATIONS` — LIST-RESERVATIONS. Evidence: `app/programs/EQSCH00.cbl:350`.
- `COMPLETE-RETURN` — COMPLETE-RETURN. Evidence: `app/programs/EQSCH00.cbl:381`.

# Control flow

- `MAIN-PARA` dispatches on an operation. Entry: `app/programs/EQSCH00.cbl:19`.
- `CHECK-AVAILABLE` checks a condition, reads rows. Entry: `app/programs/EQSCH00.cbl:46`.
- `AVAIL-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:82`.
- `READ-CONTEXT` dispatches on an operation, reads rows. Entry: `app/programs/EQSCH00.cbl:85`.
- `CONTEXT-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:105`.
- `READ-CONTEXT` dispatches on an operation, reads rows. Entry: `app/programs/EQSCH00.cbl:108`.
- `CONTEXT-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:128`.
- `RESERVE-EQUIP` checks a condition, iterates over records, inserts a row, reads rows. Entry: `app/programs/EQSCH00.cbl:131`.
- `RESERVE-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:186`.
- `RECORD-MAINT` checks a condition, iterates over records, iterates until a condition, inserts a row. Entry: `app/programs/EQSCH00.cbl:189`.
- `MAINT-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:262`.
- `CANCEL-INVALID` checks a condition, iterates over records, updates rows, reads rows. Entry: `app/programs/EQSCH00.cbl:265`.
- `CANCEL-DONE` defines a contract or declaration. Entry: `app/programs/EQSCH00.cbl:316`.
- `LIST-MINE` checks a condition, iterates until a condition, reads rows. Entry: `app/programs/EQSCH00.cbl:319`.
- `LIST-RESERVATIONS` checks a condition, iterates until a condition, reads rows. Entry: `app/programs/EQSCH00.cbl:350`.
- `COMPLETE-RETURN` checks a condition, updates rows. Entry: `app/programs/EQSCH00.cbl:381`.

# Data & side effects

- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:51`.
- database read `EQP_MAINT` at `app/programs/EQSCH00.cbl:68`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:91`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:114`.
- database read `EQP_EQUIP` at `app/programs/EQSCH00.cbl:139`.
- database write `EQP_RSRVN` at `app/programs/EQSCH00.cbl:165`.
- database read `SYSIBM` at `app/programs/EQSCH00.cbl:179`.
- database read `EQP_EQUIP` at `app/programs/EQSCH00.cbl:197`.
- database write `EQP_MAINT` at `app/programs/EQSCH00.cbl:212`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:228`.
- database write `EQP_RSRVN` at `app/programs/EQSCH00.cbl:250`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:269`.
- database read `EQP_MAINT` at `app/programs/EQSCH00.cbl:291`.
- database write `EQP_RSRVN` at `app/programs/EQSCH00.cbl:307`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:325`.
- database read `EQP_RSRVN` at `app/programs/EQSCH00.cbl:356`.
- database write `EQP_RSRVN` at `app/programs/EQSCH00.cbl:383`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQSQLCA.cpy](../copybooks/EQSQLCA.cpy.md).
- Used by [EQOPS00.cbl](EQOPS00.cbl.md).

# Errors

- `MOVE 'Schedule operation is not supported.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:42`.
- `MOVE 'Reservation conflict check failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:59`.
- `MOVE 'Maintenance conflict check failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:75`.
- `MOVE 'Reservation does not exist.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:99`.
- `MOVE 'Reservation context read failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:102`.
- `MOVE 'Reservation does not exist.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:122`.
- `MOVE 'Reservation context read failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:125`.
- `MOVE 'End time must be after start time.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:134`.
- `MOVE 'Equipment does not exist.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:145`.
- `MOVE 'Equipment lock failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:150`.
- `MOVE 'Equipment is unavailable for that period.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:161`.
- `MOVE 'Reservation insert failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:174`.
- `MOVE 'Reservation identity read failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:183`.
- `MOVE 'End time must be after start time.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:192`.
- `MOVE 'Equipment does not exist.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:203`.
- `MOVE 'Equipment lock failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:208`.
- `MOVE 'Maintenance insert failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:221`.
- `MOVE 'Reservation invalidation failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:256`.
- `MOVE 'Reservation does not exist.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:275`.
- `MOVE 'Reservation read failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:280`.
- `MOVE 'Only an invalid reservation can be cancelled.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:285`.
- `MOVE 'Maintenance overlap check failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:298`.
- `MOVE 'Reservation has no overlapping maintenance.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:303`.
- `MOVE 'Reservation cancel failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:313`.
- `MOVE 'Reservation list failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:347`.
- `MOVE 'Reservation history failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:378`.
- `MOVE 'Reservation completion failed.' TO EQ-ERROR` at `app/programs/EQSCH00.cbl:390`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Schedule Management](../../../modules/schedule-management.md).

# Evidence

- `app/programs/EQSCH00.cbl:1` — file start.
- `git_blob: 1c72bdaf42acf92b2a1a6db94a9de37e488e367b` — source content hash.

# Notes

- `READ-CONTEXT` is declared at lines 85 and 108. `CONTEXT-DONE` is declared at lines 105 and 128. The source has duplicate paragraph labels. Target compilation was unavailable, so the compiler result is unknown.
