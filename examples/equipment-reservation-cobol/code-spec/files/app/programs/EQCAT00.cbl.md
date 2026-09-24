---
type: "Source File"
title: "EQCAT00.cbl"
description: "COBOL source file at app/programs/EQCAT00.cbl."
spec_id: "FILE-app-programs-eqcat00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQCAT00.cbl"
language: "COBOL"
role: "source"
git_blob: "b0a35f89d182a8743ba9143b59985785ca8ef44e"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQCAT00.cbl supports the Equipment Catalog responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQCAT00.cbl:1`.
- Its direct owning Module is [Equipment Catalog](../../../modules/equipment-catalog.md).

# Symbols

- `EQCAT00` — PROGRAM-ID. EQCAT00. Evidence: `app/programs/EQCAT00.cbl:6`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQCAT00.cbl:18`.
- `ADD-EQUIP` — ADD-EQUIP. Evidence: `app/programs/EQCAT00.cbl:31`.
- `ADD-DONE` — ADD-DONE. Evidence: `app/programs/EQCAT00.cbl:69`.
- `LIST-EQUIP` — LIST-EQUIP. Evidence: `app/programs/EQCAT00.cbl:72`.

# Control flow

- `MAIN-PARA` dispatches on an operation. Entry: `app/programs/EQCAT00.cbl:18`.
- `ADD-EQUIP` checks a condition, inserts a row, reads rows. Entry: `app/programs/EQCAT00.cbl:31`.
- `ADD-DONE` defines a contract or declaration. Entry: `app/programs/EQCAT00.cbl:69`.
- `LIST-EQUIP` checks a condition, iterates until a condition, reads rows. Entry: `app/programs/EQCAT00.cbl:72`.

# Data & side effects

- database read `EQP_EQUIP` at `app/programs/EQCAT00.cbl:35`.
- database write `EQP_EQUIP` at `app/programs/EQCAT00.cbl:49`.
- database read `EQP_EQUIP` at `app/programs/EQCAT00.cbl:61`.
- database read `EQP_EQUIP` at `app/programs/EQCAT00.cbl:77`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQSQLCA.cpy](../copybooks/EQSQLCA.cpy.md).
- Used by [EQOPS00.cbl](EQOPS00.cbl.md).

# Errors

- `MOVE 'Catalog operation is not supported.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:27`.
- `MOVE 'Equipment name check failed.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:40`.
- `MOVE 'Equipment name already exists.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:45`.
- `MOVE 'Equipment insert failed.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:56`.
- `MOVE 'Equipment identity read failed.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:66`.
- `MOVE 'Equipment list failed.' TO EQ-ERROR` at `app/programs/EQCAT00.cbl:95`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Catalog](../../../modules/equipment-catalog.md).

# Evidence

- `app/programs/EQCAT00.cbl:1` — file start.
- `git_blob: b0a35f89d182a8743ba9143b59985785ca8ef44e` — source content hash.
