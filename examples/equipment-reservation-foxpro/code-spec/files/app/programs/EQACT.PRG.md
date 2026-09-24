---
type: "Source File"
title: "EQACT.PRG"
description: "Visual FoxPro source file at app/programs/EQACT.PRG."
spec_id: "FILE-app-programs-eqact-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQACT.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "629db5453ed84fd95775761424b47e1162e8a73d"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQACT.PRG supports the Actor Access responsibility. The source starts: `* Actor Access Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQACT.PRG:1`.
- Its direct owning Module is [Actor Access](../../../modules/actor-access.md).

# Symbols

- `ActorContext` — FUNCTION ActorContext(tcActorId) Evidence: `app/programs/EQACT.PRG:6`.
- `Authorize` — FUNCTION Authorize(tcActorId, tcOperation) Evidence: `app/programs/EQACT.PRG:33`.

# Control flow

- `FUNCTION ActorContext` checks a condition, iterates over records, reads rows, returns a result. Entry: `app/programs/EQACT.PRG:6`.
- `FUNCTION Authorize` checks a condition, dispatches on a case, returns a result. Entry: `app/programs/EQACT.PRG:33`.

# Data & side effects

- DBF write at `app/programs/EQACT.PRG:3`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Actor Access](../../../modules/actor-access.md).

# Evidence

- `app/programs/EQACT.PRG:1` — file start.
- `git_blob: 629db5453ed84fd95775761424b47e1162e8a73d` — source content hash.
