---
type: "Source File"
title: "EQTIMES.cpy"
description: "COBOL copybook source file at app/copybooks/EQTIMES.cpy."
spec_id: "FILE-app-copybooks-eqtimes-cpy"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/copybooks/EQTIMES.cpy"
language: "COBOL copybook"
role: "source"
git_blob: "9355225ac9f267a746882d0d9095478654cf24bd"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQTIMES.cpy supports the Schedule Management responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/copybooks/EQTIMES.cpy:1`.
- Its direct owning Module is [Schedule Management](../../../modules/schedule-management.md).

# Symbols

- `EQ-TIMESTAMP-WORK` — 01 EQ-TIMESTAMP-WORK. Evidence: `app/copybooks/EQTIMES.cpy:4`.
- `EQ-TS-START` — 05 EQ-TS-START           PIC X(26). Evidence: `app/copybooks/EQTIMES.cpy:5`.
- `EQ-TS-END` — 05 EQ-TS-END             PIC X(26). Evidence: `app/copybooks/EQTIMES.cpy:6`.
- `EQ-TS-PICKUP` — 05 EQ-TS-PICKUP          PIC X(26). Evidence: `app/copybooks/EQTIMES.cpy:7`.
- `EQ-TS-RETURN` — 05 EQ-TS-RETURN          PIC X(26). Evidence: `app/copybooks/EQTIMES.cpy:8`.

# Control flow

- Entry and behavior follow the declarations above. The first executable region starts at `app/copybooks/EQTIMES.cpy:4`. Read the cited source for branch detail.

# Dependencies

No internal file dependency identified.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Schedule Management](../../../modules/schedule-management.md).

# Evidence

- `app/copybooks/EQTIMES.cpy:1` — file start.
- `git_blob: 9355225ac9f267a746882d0d9095478654cf24bd` — source content hash.
