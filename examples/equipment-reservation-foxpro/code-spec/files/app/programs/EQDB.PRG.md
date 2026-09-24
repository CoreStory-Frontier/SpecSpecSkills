---
type: "Source File"
title: "EQDB.PRG"
description: "Visual FoxPro source file at app/programs/EQDB.PRG."
spec_id: "FILE-app-programs-eqdb-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQDB.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "0593cba60ac1a34ab0a4bac510185ed2d3e1ed4f"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQDB.PRG supports the Scheduling Operations responsibility. The source starts: `* Shared DBF helpers for the Equipment Reservation reference.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQDB.PRG:1`.
- Its direct owning Module is [Scheduling Operations](../../../modules/scheduling-operations.md).

# Symbols

- `NextId` — FUNCTION NextId(tcTable, tcField) Evidence: `app/programs/EQDB.PRG:3`.
- `OpenTable` — FUNCTION OpenTable(tcTable) Evidence: `app/programs/EQDB.PRG:20`.
- `CloseTable` — FUNCTION CloseTable(tcTable) Evidence: `app/programs/EQDB.PRG:28`.

# Control flow

- `FUNCTION NextId` checks a condition, reads rows, returns a result. Entry: `app/programs/EQDB.PRG:3`.
- `FUNCTION OpenTable` checks a condition, returns a result. Entry: `app/programs/EQDB.PRG:20`.
- `FUNCTION CloseTable` checks a condition, returns a result. Entry: `app/programs/EQDB.PRG:28`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../../modules/scheduling-operations.md).

# Evidence

- `app/programs/EQDB.PRG:1` — file start.
- `git_blob: 0593cba60ac1a34ab0a4bac510185ed2d3e1ed4f` — source content hash.
