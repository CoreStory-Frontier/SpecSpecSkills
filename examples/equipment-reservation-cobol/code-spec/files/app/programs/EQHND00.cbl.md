---
type: "Source File"
title: "EQHND00.cbl"
description: "COBOL source file at app/programs/EQHND00.cbl."
spec_id: "FILE-app-programs-eqhnd00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQHND00.cbl"
language: "COBOL"
role: "source"
git_blob: "880ffdb5c7729c3d3e4699315915d8157ca149b4"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQHND00.cbl supports the Equipment Use Management responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQHND00.cbl:1`.
- Its direct owning Module is [Equipment Use Management](../../../modules/equipment-use-management.md).

# Symbols

- `EQHND00` — PROGRAM-ID. EQHND00. Evidence: `app/programs/EQHND00.cbl:6`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQHND00.cbl:20`.
- `RECORD-PICKUP` — RECORD-PICKUP. Evidence: `app/programs/EQHND00.cbl:35`.
- `PICKUP-DONE` — PICKUP-DONE. Evidence: `app/programs/EQHND00.cbl:85`.
- `RECORD-RETURN` — RECORD-RETURN. Evidence: `app/programs/EQHND00.cbl:88`.
- `RETURN-DONE` — RETURN-DONE. Evidence: `app/programs/EQHND00.cbl:141`.
- `HISTORY` — HISTORY. Evidence: `app/programs/EQHND00.cbl:144`.
- `HISTORY-DONE` — HISTORY-DONE. Evidence: `app/programs/EQHND00.cbl:180`.

# Control flow

- `MAIN-PARA` dispatches on an operation. Entry: `app/programs/EQHND00.cbl:20`.
- `RECORD-PICKUP` checks a condition, inserts a row, reads rows. Entry: `app/programs/EQHND00.cbl:35`.
- `PICKUP-DONE` defines a contract or declaration. Entry: `app/programs/EQHND00.cbl:85`.
- `RECORD-RETURN` checks a condition, iterates over records, updates rows, reads rows. Entry: `app/programs/EQHND00.cbl:88`.
- `RETURN-DONE` defines a contract or declaration. Entry: `app/programs/EQHND00.cbl:141`.
- `HISTORY` checks a condition, iterates until a condition, reads rows. Entry: `app/programs/EQHND00.cbl:144`.
- `HISTORY-DONE` defines a contract or declaration. Entry: `app/programs/EQHND00.cbl:180`.

# Data & side effects

- database read `EQP_USE` at `app/programs/EQHND00.cbl:50`.
- database write `EQP_USE` at `app/programs/EQHND00.cbl:64`.
- database read `EQP_USE` at `app/programs/EQHND00.cbl:77`.
- database read `EQP_USE` at `app/programs/EQHND00.cbl:94`.
- database write `EQP_USE` at `app/programs/EQHND00.cbl:124`.
- database write `failed` at `app/programs/EQHND00.cbl:130`.
- database read `EQP_USE` at `app/programs/EQHND00.cbl:155`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQSQLCA.cpy](../copybooks/EQSQLCA.cpy.md).
- Uses [EQOPS00.cbl](EQOPS00.cbl.md).
- Used by [EQWEB00.cbl](EQWEB00.cbl.md).
- Used by [EQTEST00.cbl](../tests/EQTEST00.cbl.md).

# Errors

- `MOVE 'Handoff operation is not supported.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:31`.
- `MOVE 'Pickup requires a confirmed reservation.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:44`.
- `MOVE 'Use record check failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:55`.
- `MOVE 'Pickup is already recorded.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:60`.
- `MOVE 'Pickup insert failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:72`.
- `MOVE 'Use identity read failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:82`.
- `MOVE 'Use record does not exist.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:100`.
- `MOVE 'Use record read failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:105`.
- `MOVE 'Return requires one pickup.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:110`.
- `MOVE 'Return is already recorded.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:115`.
- `MOVE 'Return time must be after pickup.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:120`.
- `MOVE 'Return update failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:130`.
- `MOVE 'Reservation completion failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:138`.
- `MOVE 'Use history failed.' TO EQ-ERROR` at `app/programs/EQHND00.cbl:177`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Use Management](../../../modules/equipment-use-management.md).

# Evidence

- `app/programs/EQHND00.cbl:1` — file start.
- `git_blob: 880ffdb5c7729c3d3e4699315915d8157ca149b4` — source content hash.
