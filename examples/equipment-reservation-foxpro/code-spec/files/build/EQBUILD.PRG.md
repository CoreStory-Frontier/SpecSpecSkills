---
type: "Source File"
title: "EQBUILD.PRG"
description: "Visual FoxPro source file at build/EQBUILD.PRG."
spec_id: "FILE-build-eqbuild-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "build/EQBUILD.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "71cd352e71cb8bf076121511d309b8fe18d9d318"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQBUILD.PRG supports the Web Interaction responsibility. The source starts: `* Build the Equipment Reservation VFP9 project.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `build/EQBUILD.PRG:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

No named declarations observed.

# Control flow

- The file starts at `build/EQBUILD.PRG:1`; no named behavior was found.

# Data & side effects

- database read `the` at `build/EQBUILD.PRG:2`.
- database read `equipment_reservation` at `build/EQBUILD.PRG:16`.

# Dependencies

- Uses [EQACT.PRG](../app/programs/EQACT.PRG.md).
- Uses [EQCAT.PRG](../app/programs/EQCAT.PRG.md).
- Uses [EQDB.PRG](../app/programs/EQDB.PRG.md).
- Uses [EQHAND.PRG](../app/programs/EQHAND.PRG.md).
- Uses [EQOPS.PRG](../app/programs/EQOPS.PRG.md).
- Uses [EQSHED.PRG](../app/programs/EQSHED.PRG.md).
- Uses [EQWEB.PRG](../app/programs/EQWEB.PRG.md).
- Uses [setup.prg](../app/setup.prg.md).
- Uses [EQTEST.PRG](../app/tests/EQTEST.PRG.md).

# Tests

- [EQTEST.PRG](../app/tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `build/EQBUILD.PRG:1` — file start.
- `git_blob: 71cd352e71cb8bf076121511d309b8fe18d9d318` — source content hash.
