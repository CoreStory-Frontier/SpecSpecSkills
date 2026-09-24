---
type: "Source File"
title: "EQSQLCA.cpy"
description: "COBOL copybook source file at app/copybooks/EQSQLCA.cpy."
spec_id: "FILE-app-copybooks-eqsqlca-cpy"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/copybooks/EQSQLCA.cpy"
language: "COBOL copybook"
role: "source"
git_blob: "c7fc178a81304e209c2912f3d9eb8dd3a1df987e"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQSQLCA.cpy supports the Equipment Catalog responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/copybooks/EQSQLCA.cpy:1`.
- Its direct owning Module is [Equipment Catalog](../../../modules/equipment-catalog.md).

# Symbols

No named declarations observed.

# Control flow

- Entry and behavior follow the declarations above. The first executable region starts at `app/copybooks/EQSQLCA.cpy:1`. Read the cited source for branch detail.

# Data & side effects

- The file reads or changes data, output, or logs. See `app/copybooks/EQSQLCA.cpy:4`.

# Dependencies

- Used by [EQWEB00.cbl](../programs/EQWEB00.cbl.md).
- Used by [EQACT00.cbl](../programs/EQACT00.cbl.md).
- Used by [EQCAT00.cbl](../programs/EQCAT00.cbl.md).
- Used by [EQSCH00.cbl](../programs/EQSCH00.cbl.md).
- Used by [EQHND00.cbl](../programs/EQHND00.cbl.md).
- Used by [EQTEST00.cbl](../tests/EQTEST00.cbl.md).

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Equipment Catalog](../../../modules/equipment-catalog.md).

# Evidence

- `app/copybooks/EQSQLCA.cpy:1` — file start.
- `git_blob: c7fc178a81304e209c2912f3d9eb8dd3a1df987e` — source content hash.
