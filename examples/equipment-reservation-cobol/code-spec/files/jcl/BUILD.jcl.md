---
type: "Source File"
title: "BUILD.jcl"
description: "JCL infra file at jcl/BUILD.jcl."
spec_id: "FILE-jcl-build-jcl"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "jcl/BUILD.jcl"
language: "JCL"
role: "infra"
git_blob: "06bb01fbef9a469e0ea828c1ab6ad95dd67a0c51"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] BUILD.jcl supports the Web Interaction responsibility. The source starts: `//EQBUILD  JOB (1),'BUILD EQ RESERVATION',CLASS=A,MSGCLASS=X`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `jcl/BUILD.jcl:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `EQBUILD` — //EQBUILD  JOB (1),'BUILD EQ RESERVATION',CLASS=A,MSGCLASS=X Evidence: `jcl/BUILD.jcl:1`.
- `COMPILE` — //COMPILE  EXEC PGM=IGYCRCTL,REGION=0M Evidence: `jcl/BUILD.jcl:2`.
- `STEPLIB` — //STEPLIB  DD DSN=IBM.COBOL.V63.SIGYCOMP,DISP=SHR Evidence: `jcl/BUILD.jcl:3`.
- `SYSLIB` — //SYSLIB   DD DSN=EQ.RESERVATION.COPY,DISP=SHR Evidence: `jcl/BUILD.jcl:4`.
- `SYSIN` — //SYSIN    DD DSN=EQ.RESERVATION.CBL(EQWEB00),DISP=SHR Evidence: `jcl/BUILD.jcl:6`.
- `SYSLIN` — //SYSLIN   DD DSN=&&OBJ,DISP=(NEW,PASS),UNIT=SYSALLDA Evidence: `jcl/BUILD.jcl:7`.
- `SYSPRINT` — //SYSPRINT DD SYSOUT=* Evidence: `jcl/BUILD.jcl:8`.
- `SYSTERM` — //SYSTERM  DD SYSOUT=* Evidence: `jcl/BUILD.jcl:9`.
- `SYSUDUMP` — //SYSUDUMP DD SYSOUT=* Evidence: `jcl/BUILD.jcl:10`.
- `BIND` — //BIND     EXEC PGM=DSNHCP,REGION=0M Evidence: `jcl/BUILD.jcl:16`.
- `STEPLIB` — //STEPLIB  DD DSN=SYS.DB2.V12.SDSNLOAD,DISP=SHR Evidence: `jcl/BUILD.jcl:17`.
- `DBRMLIB` — //DBRMLIB  DD DSN=EQ.RESERVATION.DBRM,DISP=SHR Evidence: `jcl/BUILD.jcl:18`.
- `SYSPRINT` — //SYSPRINT DD SYSOUT=* Evidence: `jcl/BUILD.jcl:19`.
- `SYSPUNCH` — //SYSPUNCH DD DSN=EQ.RESERVATION.SYSPUNCH,DISP=(NEW,CATLG), Evidence: `jcl/BUILD.jcl:20`.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `jcl/BUILD.jcl:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `jcl/BUILD.jcl:1` — file start.
- `git_blob: 06bb01fbef9a469e0ea828c1ab6ad95dd67a0c51` — source content hash.
