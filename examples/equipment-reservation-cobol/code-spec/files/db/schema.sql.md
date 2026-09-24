---
type: "Source File"
title: "schema.sql"
description: "SQL schema file at db/schema.sql."
spec_id: "FILE-db-schema-sql"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "db/schema.sql"
language: "SQL"
role: "schema"
git_blob: "e95f18e1576189fd7daa2ba8f6e393ffacd6c5fe"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] schema.sql supports the Equipment Catalog responsibility. The source starts: `-- Equipment Reservation DB2 for z/OS schema.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `db/schema.sql:1`.
- Its direct owning Module is [Equipment Catalog](../../modules/equipment-catalog.md).

# Symbols

- `EQP_ACTR` — CREATE TABLE EQP_ACTR ( Evidence: `db/schema.sql:4`.
- `EQP_EQUIP` — CREATE TABLE EQP_EQUIP ( Evidence: `db/schema.sql:11`.
- `EQP_RSRVN` — CREATE TABLE EQP_RSRVN ( Evidence: `db/schema.sql:19`.
- `EQP_MAINT` — CREATE TABLE EQP_MAINT ( Evidence: `db/schema.sql:34`.
- `EQP_USE` — CREATE TABLE EQP_USE ( Evidence: `db/schema.sql:46`.
- `EQP_RSRVN_EQUIP_IX` — CREATE INDEX EQP_RSRVN_EQUIP_IX Evidence: `db/schema.sql:61`.
- `EQP_MAINT_EQUIP_IX` — CREATE INDEX EQP_MAINT_EQUIP_IX Evidence: `db/schema.sql:64`.
- `EQP_USE_EQUIP_IX` — CREATE INDEX EQP_USE_EQUIP_IX Evidence: `db/schema.sql:67`.

# Data & side effects

- database write `EQP_ACTR` at `db/schema.sql:4`.
- database write `EQP_EQUIP` at `db/schema.sql:11`.
- database write `EQP_RSRVN` at `db/schema.sql:19`.
- database write `EQP_MAINT` at `db/schema.sql:34`.
- database write `EQP_USE` at `db/schema.sql:46`.
- database write `EQP_ACTR` at `db/schema.sql:71`.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `db/schema.sql:1`. Secret values are omitted.

# Related

- [Equipment Catalog](../../modules/equipment-catalog.md).

# Evidence

- `db/schema.sql:1` — file start.
- `git_blob: e95f18e1576189fd7daa2ba8f6e393ffacd6c5fe` — source content hash.
