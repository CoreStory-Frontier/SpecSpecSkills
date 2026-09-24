---
type: "Source File"
title: "reset.sql"
description: "SQL schema file at db/reset.sql."
spec_id: "FILE-db-reset-sql"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "db/reset.sql"
language: "SQL"
role: "schema"
git_blob: "6fcc35bfef707a4c037006ca459fbabd95603037"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] reset.sql supports the Equipment Catalog responsibility. The source starts: `-- Reset reference data between test runs. Keep the fixed actor rows.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `db/reset.sql:1`.
- Its direct owning Module is [Equipment Catalog](../../modules/equipment-catalog.md).

# Symbols

No named declarations observed.

# Data & side effects

- database write `EQP_USE` at `db/reset.sql:2`.
- database read `EQP_USE` at `db/reset.sql:2`.
- database write `EQP_MAINT` at `db/reset.sql:3`.
- database read `EQP_MAINT` at `db/reset.sql:3`.
- database write `EQP_RSRVN` at `db/reset.sql:4`.
- database read `EQP_RSRVN` at `db/reset.sql:4`.
- database write `EQP_EQUIP` at `db/reset.sql:5`.
- database read `EQP_EQUIP` at `db/reset.sql:5`.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `db/reset.sql:1`. Secret values are omitted.

# Related

- [Equipment Catalog](../../modules/equipment-catalog.md).

# Evidence

- `db/reset.sql:1` — file start.
- `git_blob: 6fcc35bfef707a4c037006ca459fbabd95603037` — source content hash.
