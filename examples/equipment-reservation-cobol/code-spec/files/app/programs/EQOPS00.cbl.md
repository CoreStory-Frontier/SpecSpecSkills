---
type: "Source File"
title: "EQOPS00.cbl"
description: "COBOL source file at app/programs/EQOPS00.cbl."
spec_id: "FILE-app-programs-eqops00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQOPS00.cbl"
language: "COBOL"
role: "source"
git_blob: "7f3bd2eb1b6c92291e1e5fdbc302036cab0601e1"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQOPS00.cbl supports the Scheduling Operations responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQOPS00.cbl:1`.
- Its direct owning Module is [Scheduling Operations](../../../modules/scheduling-operations.md).

# Symbols

- `EQOPS00` — PROGRAM-ID. EQOPS00. Evidence: `app/programs/EQOPS00.cbl:7`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQOPS00.cbl:19`.
- `SEARCH-EQUIP` — SEARCH-EQUIP. Evidence: `app/programs/EQOPS00.cbl:53`.
- `SEARCH-DONE` — SEARCH-DONE. Evidence: `app/programs/EQOPS00.cbl:75`.

# Control flow

- `MAIN-PARA` dispatches on an operation. Entry: `app/programs/EQOPS00.cbl:19`.
- `SEARCH-EQUIP` checks a condition. Entry: `app/programs/EQOPS00.cbl:53`.
- `SEARCH-DONE` defines a contract or declaration. Entry: `app/programs/EQOPS00.cbl:75`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQCAT00.cbl](EQCAT00.cbl.md).
- Uses [EQSCH00.cbl](EQSCH00.cbl.md).
- Used by [EQWEB00.cbl](EQWEB00.cbl.md).
- Used by [EQHND00.cbl](EQHND00.cbl.md).
- Used by [EQTEST00.cbl](../tests/EQTEST00.cbl.md).

# Errors

- `MOVE 'Scheduling operation is not supported.' TO EQ-ERROR` at `app/programs/EQOPS00.cbl:49`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../../modules/scheduling-operations.md).

# Evidence

- `app/programs/EQOPS00.cbl:1` — file start.
- `git_blob: 7f3bd2eb1b6c92291e1e5fdbc302036cab0601e1` — source content hash.
