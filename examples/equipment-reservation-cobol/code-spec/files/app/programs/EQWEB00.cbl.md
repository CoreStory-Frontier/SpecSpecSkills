---
type: "Source File"
title: "EQWEB00.cbl"
description: "COBOL source file at app/programs/EQWEB00.cbl."
spec_id: "FILE-app-programs-eqweb00-cbl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQWEB00.cbl"
language: "COBOL"
role: "source"
git_blob: "dfbfa4569a4f5fcd66561c5cb345189e5b06bde2"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQWEB00.cbl supports the Web Interaction responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQWEB00.cbl:1`.
- Its direct owning Module is [Web Interaction](../../../modules/web-interaction.md).

# Symbols

- `EQWEB00` — PROGRAM-ID. EQWEB00. Evidence: `app/programs/EQWEB00.cbl:7`.
- `MAIN-PARA` — MAIN-PARA. Evidence: `app/programs/EQWEB00.cbl:31`.
- `PARSE-REQUEST` — PARSE-REQUEST. Evidence: `app/programs/EQWEB00.cbl:88`.
- `PROCESS-LINE` — PROCESS-LINE. Evidence: `app/programs/EQWEB00.cbl:114`.
- `APPEND-LINE` — APPEND-LINE. Evidence: `app/programs/EQWEB00.cbl:163`.
- `APPEND-KEY-VALUE` — APPEND-KEY-VALUE. Evidence: `app/programs/EQWEB00.cbl:172`.
- `SEND-RESULT` — SEND-RESULT. Evidence: `app/programs/EQWEB00.cbl:182`.
- `SEND-ERROR` — SEND-ERROR. Evidence: `app/programs/EQWEB00.cbl:261`.
- `DONE` — DONE. Evidence: `app/programs/EQWEB00.cbl:282`.

# Control flow

- `MAIN-PARA` checks a condition, dispatches on an operation. Entry: `app/programs/EQWEB00.cbl:31`.
- `PARSE-REQUEST` checks a condition, iterates until a condition. Entry: `app/programs/EQWEB00.cbl:88`.
- `PROCESS-LINE` checks a condition, dispatches on an operation, iterates until a condition. Entry: `app/programs/EQWEB00.cbl:114`.
- `DONE` returns a result. Entry: `app/programs/EQWEB00.cbl:282`.

# Data & side effects

- database read `CICS` at `app/programs/EQWEB00.cbl:3`.
- CICS web I/O at `app/programs/EQWEB00.cbl:36`.
- CICS web I/O at `app/programs/EQWEB00.cbl:255`.
- CICS web I/O at `app/programs/EQWEB00.cbl:276`.

# Dependencies

- Uses [EQCOMM.cpy](../copybooks/EQCOMM.cpy.md).
- Uses [EQSQLCA.cpy](../copybooks/EQSQLCA.cpy.md).
- Uses [EQACT00.cbl](EQACT00.cbl.md).
- Uses [EQHND00.cbl](EQHND00.cbl.md).
- Uses [EQOPS00.cbl](EQOPS00.cbl.md).

# Errors

- `MOVE 'No request data.' TO EQ-ERROR` at `app/programs/EQWEB00.cbl:43`.
- `MOVE 'Missing action.' TO EQ-ERROR` at `app/programs/EQWEB00.cbl:50`.
- `MOVE 'Missing actor.' TO EQ-ERROR` at `app/programs/EQWEB00.cbl:56`.
- `MOVE 'Unknown action.' TO EQ-ERROR` at `app/programs/EQWEB00.cbl:79`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Web Interaction](../../../modules/web-interaction.md).

# Evidence

- `app/programs/EQWEB00.cbl:1` — file start.
- `git_blob: dfbfa4569a4f5fcd66561c5cb345189e5b06bde2` — source content hash.
