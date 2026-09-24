---
type: "Source File"
title: "setup.prg"
description: "Visual FoxPro source file at app/setup.prg."
spec_id: "FILE-app-setup-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/setup.prg"
language: "Visual FoxPro"
role: "source"
git_blob: "78b6965a7e8ed9ee854c9d33410ead3604555982"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] setup.prg supports the Scheduling Operations responsibility. The source starts: `* Equipment Reservation VFP9 data setup.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/setup.prg:1`.
- Its direct owning Module is [Scheduling Operations](../../modules/scheduling-operations.md).

# Symbols

No named declarations observed.

# Control flow

- The file starts at `app/setup.prg:1`; no named behavior was found.

# Data & side effects

- database read `the` at `app/setup.prg:2`.
- database write `data` at `app/setup.prg:29`.
- DBF write at `app/setup.prg:29`.
- database write `data` at `app/setup.prg:33`.
- DBF write at `app/setup.prg:33`.
- database write `data` at `app/setup.prg:38`.
- DBF write at `app/setup.prg:38`.
- database write `data` at `app/setup.prg:46`.
- DBF write at `app/setup.prg:46`.
- database write `data` at `app/setup.prg:51`.
- DBF write at `app/setup.prg:51`.
- DBF write at `app/setup.prg:58`.
- DBF write at `app/setup.prg:59`.
- DBF write at `app/setup.prg:60`.
- DBF write at `app/setup.prg:61`.
- DBF write at `app/setup.prg:62`.
- DBF write at `app/setup.prg:63`.
- DBF write at `app/setup.prg:64`.
- DBF write at `app/setup.prg:65`.

# Dependencies

- Used by [EQBUILD.PRG](../build/EQBUILD.PRG.md).

# Configuration

- Configuration or environment input is defined or read here. Evidence: `app/setup.prg:1`. Secret values are omitted.

# Tests

- [EQTEST.PRG](tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../modules/scheduling-operations.md).

# Evidence

- `app/setup.prg:1` — file start.
- `git_blob: 78b6965a7e8ed9ee854c9d33410ead3604555982` — source content hash.
