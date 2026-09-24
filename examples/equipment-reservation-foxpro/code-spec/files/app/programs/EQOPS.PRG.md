---
type: "Source File"
title: "EQOPS.PRG"
description: "Visual FoxPro source file at app/programs/EQOPS.PRG."
spec_id: "FILE-app-programs-eqops-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQOPS.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "c95add14b60271686824605f044267d712b8168a"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQOPS.PRG supports the Scheduling Operations responsibility. The source starts: `* Scheduling Operations Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQOPS.PRG:1`.
- Its direct owning Module is [Scheduling Operations](../../../modules/scheduling-operations.md).

# Symbols

- `SearchEquipment` — FUNCTION SearchEquipment(tcActorId, ttStart, ttEnd) Evidence: `app/programs/EQOPS.PRG:4`.
- `Execute` — FUNCTION Execute(tcActorId, tcOperation, tnEquipId, tnRsvId, tnUseId, ttStart, ttEnd, tcName, tcDesc Evidence: `app/programs/EQOPS.PRG:19`.

# Control flow

- `FUNCTION SearchEquipment` checks a condition, iterates over records, returns a result. Entry: `app/programs/EQOPS.PRG:4`.
- `FUNCTION Execute` dispatches on a case, returns a result. Entry: `app/programs/EQOPS.PRG:19`.

# Data & side effects

- The file reads or changes data, output, or logs. See `app/programs/EQOPS.PRG:6`.

# Dependencies

- Used by [EQWEB.PRG](EQWEB.PRG.md).
- Used by [EQTEST.PRG](../tests/EQTEST.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Errors

- `loResult.message = "Unknown scheduling operation."` at `app/programs/EQOPS.PRG:49`.

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../../modules/scheduling-operations.md).

# Evidence

- `app/programs/EQOPS.PRG:1` — file start.
- `git_blob: c95add14b60271686824605f044267d712b8168a` — source content hash.
