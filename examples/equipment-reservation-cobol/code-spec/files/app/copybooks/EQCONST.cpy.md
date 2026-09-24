---
type: "Source File"
title: "EQCONST.cpy"
description: "COBOL copybook source file at app/copybooks/EQCONST.cpy."
spec_id: "FILE-app-copybooks-eqconst-cpy"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/copybooks/EQCONST.cpy"
language: "COBOL copybook"
role: "source"
git_blob: "37bff26639737f08b5c87492b89637bb84d53a00"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQCONST.cpy supports the Schedule Management responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/copybooks/EQCONST.cpy:1`.
- Its direct owning Module is [Schedule Management](../../../modules/schedule-management.md).

# Symbols

- `EQ-CONSTANTS` — 01 EQ-CONSTANTS. Evidence: `app/copybooks/EQCONST.cpy:4`.
- `EQ-OP-ADD` — 05 EQ-OP-ADD             PIC X(12) VALUE 'ADD'. Evidence: `app/copybooks/EQCONST.cpy:5`.
- `EQ-OP-SEARCH` — 05 EQ-OP-SEARCH          PIC X(12) VALUE 'SEARCH'. Evidence: `app/copybooks/EQCONST.cpy:6`.
- `EQ-OP-RESERVE` — 05 EQ-OP-RESERVE         PIC X(12) VALUE 'RESERVE'. Evidence: `app/copybooks/EQCONST.cpy:7`.
- `EQ-OP-MINE` — 05 EQ-OP-MINE            PIC X(12) VALUE 'MINE'. Evidence: `app/copybooks/EQCONST.cpy:8`.
- `EQ-OP-MAINT` — 05 EQ-OP-MAINT           PIC X(12) VALUE 'MAINT'. Evidence: `app/copybooks/EQCONST.cpy:9`.
- `EQ-OP-CANCEL` — 05 EQ-OP-CANCEL          PIC X(12) VALUE 'CANCEL'. Evidence: `app/copybooks/EQCONST.cpy:10`.
- `EQ-OP-PICKUP` — 05 EQ-OP-PICKUP          PIC X(12) VALUE 'PICKUP'. Evidence: `app/copybooks/EQCONST.cpy:11`.
- `EQ-OP-RETURN` — 05 EQ-OP-RETURN          PIC X(12) VALUE 'RETURN'. Evidence: `app/copybooks/EQCONST.cpy:12`.
- `EQ-OP-HISTORY` — 05 EQ-OP-HISTORY         PIC X(12) VALUE 'HISTORY'. Evidence: `app/copybooks/EQCONST.cpy:13`.
- `EQ-OP-CATALOG` — 05 EQ-OP-CATALOG         PIC X(12) VALUE 'CATALOG'. Evidence: `app/copybooks/EQCONST.cpy:14`.
- `EQ-OP-CONTEXT` — 05 EQ-OP-CONTEXT         PIC X(12) VALUE 'CONTEXT'. Evidence: `app/copybooks/EQCONST.cpy:15`.
- `EQ-STATE-CONFIRMED` — 05 EQ-STATE-CONFIRMED    PIC X(10) VALUE 'CONFIRMED'. Evidence: `app/copybooks/EQCONST.cpy:16`.
- `EQ-STATE-INVALID` — 05 EQ-STATE-INVALID      PIC X(10) VALUE 'INVALID'. Evidence: `app/copybooks/EQCONST.cpy:17`.
- `EQ-STATE-CANCELLED` — 05 EQ-STATE-CANCELLED    PIC X(10) VALUE 'CANCELLED'. Evidence: `app/copybooks/EQCONST.cpy:18`.
- `EQ-STATE-COMPLETED` — 05 EQ-STATE-COMPLETED    PIC X(10) VALUE 'COMPLETED'. Evidence: `app/copybooks/EQCONST.cpy:19`.

# Control flow

- Entry and behavior follow the declarations above. The first executable region starts at `app/copybooks/EQCONST.cpy:4`. Read the cited source for branch detail.

# Dependencies

No internal file dependency identified.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Schedule Management](../../../modules/schedule-management.md).

# Evidence

- `app/copybooks/EQCONST.cpy:1` — file start.
- `git_blob: 37bff26639737f08b5c87492b89637bb84d53a00` — source content hash.
