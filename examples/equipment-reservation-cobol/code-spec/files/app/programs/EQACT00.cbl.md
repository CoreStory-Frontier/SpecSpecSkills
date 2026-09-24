---
type: "Source File"
title: "EQACT00.cbl"
description: "COBOL source file at app/programs/EQACT00.cbl."
spec_id: "FILE-app-programs-eqact00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQACT00.cbl"
language: "COBOL"
role: "source"
git_blob: "f5f17a0d6ed21978a944153acbbadb11dd465a6b"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQACT00.cbl supports the Actor Access responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQACT00.cbl:1`.
- Its direct owning Module is [Actor Access](../../../modules/actor-access.md).

# Symbols

- `EQACT00` — PROGRAM-ID. EQACT00. Evidence: `app/programs/EQACT00.cbl:8`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQACT00.cbl:18`.
- `LOAD-ACTOR` — LOAD-ACTOR. Evidence: `app/programs/EQACT00.cbl:59`.
- `DONE` — DONE. Evidence: `app/programs/EQACT00.cbl:86`.

# Control flow

- `MAIN-PARA` checks a condition, dispatches on an operation. Entry: `app/programs/EQACT00.cbl:18`.
- `LOAD-ACTOR` dispatches on an operation, reads rows. Entry: `app/programs/EQACT00.cbl:59`.
- `DONE` defines a contract or declaration. Entry: `app/programs/EQACT00.cbl:86`.

# Data & side effects

- DBF write at `app/programs/EQACT00.cbl:4`.
- database read `EQP_ACTR` at `app/programs/EQACT00.cbl:63`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQSQLCA.cpy](../copybooks/EQSQLCA.cpy.md).
- Used by [EQWEB00.cbl](EQWEB00.cbl.md).
- Used by [EQTEST00.cbl](../tests/EQTEST00.cbl.md).

# Errors

- `MOVE 'Unknown operation.' TO EQ-ERROR` at `app/programs/EQACT00.cbl:49`.
- `MOVE 'Actor is not known.' TO EQ-ERROR` at `app/programs/EQACT00.cbl:74`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Actor Access](../../../modules/actor-access.md).

# Evidence

- `app/programs/EQACT00.cbl:1` — file start.
- `git_blob: f5f17a0d6ed21978a944153acbbadb11dd465a6b` — source content hash.
