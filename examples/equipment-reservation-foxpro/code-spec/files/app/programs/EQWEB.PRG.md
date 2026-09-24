---
type: "Source File"
title: "EQWEB.PRG"
description: "Visual FoxPro source file at app/programs/EQWEB.PRG."
spec_id: "FILE-app-programs-eqweb-prg"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/programs/EQWEB.PRG"
language: "Visual FoxPro"
role: "source"
git_blob: "0313be34b41b55d833317f3d3853c3afe9d791a0"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQWEB.PRG supports the Web Interaction responsibility. The source starts: `* Web Interaction Module.`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/programs/EQWEB.PRG:1`.
- Its direct owning Module is [Web Interaction](../../../modules/web-interaction.md).

# Symbols

- `EqBrowserForm` — DEFINE CLASS EqBrowserForm AS Form Evidence: `app/programs/EQWEB.PRG:12`.
- `Init` — PROCEDURE Init Evidence: `app/programs/EQWEB.PRG:25`.
- `Browser_BeforeNavigate2` — PROCEDURE Browser_BeforeNavigate2 Evidence: `app/programs/EQWEB.PRG:31`.
- `HandleAction` — PROCEDURE HandleAction(tcAction, tcActor, tnEquipId, tnRsvId, tnUseId, ttStart, ttEnd, tcName, tcDes Evidence: `app/programs/EQWEB.PRG:52`.
- `ShowResult` — PROCEDURE ShowResult(tcHtml) Evidence: `app/programs/EQWEB.PRG:72`.
- `Destroy` — PROCEDURE Destroy Evidence: `app/programs/EQWEB.PRG:76`.
- `ExecuteHandoff` — FUNCTION ExecuteHandoff(tcAction, tcActor, tnRsvId, tnUseId, ttStart, ttEnd) Evidence: `app/programs/EQWEB.PRG:81`.
- `GetParam` — FUNCTION GetParam(tcUrl, tcName) Evidence: `app/programs/EQWEB.PRG:95`.
- `URLDecode` — FUNCTION URLDecode(tcValue) Evidence: `app/programs/EQWEB.PRG:110`.
- `HtmlResult` — FUNCTION HtmlResult(llSuccess, tcMessage, tuResult) Evidence: `app/programs/EQWEB.PRG:119`.

# Control flow

- `DEFINE CLASS EqBrowserForm AS Form` defines a contract or declaration. Entry: `app/programs/EQWEB.PRG:12`.
- `PROCEDURE Init` defines a contract or declaration. Entry: `app/programs/EQWEB.PRG:25`.
- `PROCEDURE Browser_BeforeNavigate2` checks a condition. Entry: `app/programs/EQWEB.PRG:31`.
- `PROCEDURE HandleAction` checks a condition, dispatches on a case. Entry: `app/programs/EQWEB.PRG:52`.
- `PROCEDURE ShowResult` defines a contract or declaration. Entry: `app/programs/EQWEB.PRG:72`.
- `PROCEDURE Destroy` defines a contract or declaration. Entry: `app/programs/EQWEB.PRG:76`.
- `FUNCTION ExecuteHandoff` dispatches on a case, returns a result. Entry: `app/programs/EQWEB.PRG:81`.
- `FUNCTION GetParam` checks a condition, returns a result. Entry: `app/programs/EQWEB.PRG:95`.
- `FUNCTION URLDecode` returns a result. Entry: `app/programs/EQWEB.PRG:110`.
- `FUNCTION HtmlResult` checks a condition, returns a result. Entry: `app/programs/EQWEB.PRG:119`.

# Data & side effects

- The file reads or changes data, output, or logs. See `app/programs/EQWEB.PRG:63`.

# Dependencies

- Uses [EQACT.PRG](EQACT.PRG.md).
- Uses [EQCAT.PRG](EQCAT.PRG.md).
- Uses [EQDB.PRG](EQDB.PRG.md).
- Uses [EQHAND.PRG](EQHAND.PRG.md).
- Uses [EQOPS.PRG](EQOPS.PRG.md).
- Uses [EQSHED.PRG](EQSHED.PRG.md).
- Used by [EQBUILD.PRG](../../build/EQBUILD.PRG.md).

# Errors

- Error handling or error outputs occur in the source. Evidence: `app/programs/EQWEB.PRG:67`.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `app/programs/EQWEB.PRG:1`. Secret values are omitted.

# Tests

- [EQTEST.PRG](../tests/EQTEST.PRG.md) documents test source; test execution status is in the bundle record.

# Related

- [Web Interaction](../../../modules/web-interaction.md).

# Evidence

- `app/programs/EQWEB.PRG:1` — file start.
- `git_blob: 0313be34b41b55d833317f3d3853c3afe9d791a0` — source content hash.
