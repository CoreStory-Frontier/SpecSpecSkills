---
type: "Source File"
title: "RUNTESTS.jcl"
description: "JCL infra file at jcl/RUNTESTS.jcl."
spec_id: "FILE-jcl-runtests-jcl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "jcl/RUNTESTS.jcl"
language: "JCL"
role: "infra"
git_blob: "35eaaef96238a7658e799103e241fdf7351f1852"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] RUNTESTS.jcl supports the Web Interaction responsibility. The source starts: `//EQTEST   JOB (1),'RUN EQ TESTS',CLASS=A,MSGCLASS=X`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `jcl/RUNTESTS.jcl:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `EQTEST` — //EQTEST   JOB (1),'RUN EQ TESTS',CLASS=A,MSGCLASS=X Evidence: `jcl/RUNTESTS.jcl:1`.
- `RUNTEST` — //RUNTEST  EXEC PGM=EQTEST00,REGION=0M Evidence: `jcl/RUNTESTS.jcl:2`.
- `STEPLIB` — //STEPLIB  DD DSN=EQ.RESERVATION.LOAD,DISP=SHR Evidence: `jcl/RUNTESTS.jcl:3`.
- `SYSOUT` — //SYSOUT   DD SYSOUT=* Evidence: `jcl/RUNTESTS.jcl:5`.
- `SYSTERM` — //SYSTERM  DD SYSOUT=* Evidence: `jcl/RUNTESTS.jcl:6`.
- `SYSUDUMP` — //SYSUDUMP DD SYSOUT=* Evidence: `jcl/RUNTESTS.jcl:7`.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `jcl/RUNTESTS.jcl:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `jcl/RUNTESTS.jcl:1` — file start.
- `git_blob: 35eaaef96238a7658e799103e241fdf7351f1852` — source content hash.
