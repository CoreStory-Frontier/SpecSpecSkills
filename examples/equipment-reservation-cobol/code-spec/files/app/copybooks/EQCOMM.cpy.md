---
type: "Source File"
title: "EQCOMM.cpy"
description: "COBOL copybook source file at app/copybooks/EQCOMM.cpy."
spec_id: "FILE-app-copybooks-eqcomm-cpy"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "app/copybooks/EQCOMM.cpy"
language: "COBOL copybook"
role: "source"
git_blob: "8fdfeee7acbbba9346c7a6a937e06abd4f62770b"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] EQCOMM.cpy supports the Scheduling Operations responsibility. The source starts: `******************************************************************`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `app/copybooks/EQCOMM.cpy:1`.
- Its direct owning Module is [Scheduling Operations](../../../modules/scheduling-operations.md).

# Symbols

- `EQ-COMMAREA` — 01 EQ-COMMAREA. Evidence: `app/copybooks/EQCOMM.cpy:7`.
- `EQ-OP` — 05 EQ-OP                 PIC X(12). Evidence: `app/copybooks/EQCOMM.cpy:8`.
- `EQ-ACTOR-ID` — 05 EQ-ACTOR-ID           PIC X(12). Evidence: `app/copybooks/EQCOMM.cpy:9`.
- `EQ-EQUIP-ID` — 05 EQ-EQUIP-ID           PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:10`.
- `EQ-RSRV-ID` — 05 EQ-RSRV-ID            PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:11`.
- `EQ-USE-ID` — 05 EQ-USE-ID             PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:12`.
- `EQ-START-TS` — 05 EQ-START-TS           PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:13`.
- `EQ-END-TS` — 05 EQ-END-TS              PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:14`.
- `EQ-PICKUP-TS` — 05 EQ-PICKUP-TS           PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:15`.
- `EQ-RETURN-TS` — 05 EQ-RETURN-TS           PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:16`.
- `EQ-NAME` — 05 EQ-NAME                PIC X(40). Evidence: `app/copybooks/EQCOMM.cpy:17`.
- `EQ-DESCRIPTION` — 05 EQ-DESCRIPTION         PIC X(120). Evidence: `app/copybooks/EQCOMM.cpy:18`.
- `EQ-REASON` — 05 EQ-REASON              PIC X(80). Evidence: `app/copybooks/EQCOMM.cpy:19`.
- `EQ-EMPLOYEE-ROLE` — 05 EQ-EMPLOYEE-ROLE       PIC X. Evidence: `app/copybooks/EQCOMM.cpy:21`.
- `EQ-EMPLOYEE-YES` — 88 EQ-EMPLOYEE-YES    VALUE 'Y'. Evidence: `app/copybooks/EQCOMM.cpy:22`.
- `EQ-CUSTODIAN-ROLE` — 05 EQ-CUSTODIAN-ROLE      PIC X. Evidence: `app/copybooks/EQCOMM.cpy:23`.
- `EQ-CUSTODIAN-YES` — 88 EQ-CUSTODIAN-YES   VALUE 'Y'. Evidence: `app/copybooks/EQCOMM.cpy:24`.
- `EQ-AUTHORIZED` — 05 EQ-AUTHORIZED         PIC X. Evidence: `app/copybooks/EQCOMM.cpy:25`.
- `EQ-AUTHORIZED-YES` — 88 EQ-AUTHORIZED-YES  VALUE 'Y'. Evidence: `app/copybooks/EQCOMM.cpy:26`.
- `EQ-AVAILABLE` — 05 EQ-AVAILABLE          PIC X. Evidence: `app/copybooks/EQCOMM.cpy:27`.
- `EQ-AVAILABLE-YES` — 88 EQ-AVAILABLE-YES   VALUE 'Y'. Evidence: `app/copybooks/EQCOMM.cpy:28`.
- `EQ-STATE` — 05 EQ-STATE              PIC X(10). Evidence: `app/copybooks/EQCOMM.cpy:29`.
- `EQ-STATUS` — 05 EQ-STATUS             PIC X(2). Evidence: `app/copybooks/EQCOMM.cpy:30`.
- `EQ-STATUS-OK` — 88 EQ-STATUS-OK       VALUE 'OK'. Evidence: `app/copybooks/EQCOMM.cpy:31`.
- `EQ-STATUS-ERROR` — 88 EQ-STATUS-ERROR    VALUE 'ER'. Evidence: `app/copybooks/EQCOMM.cpy:32`.
- `EQ-MESSAGE` — 05 EQ-MESSAGE            PIC X(160). Evidence: `app/copybooks/EQCOMM.cpy:33`.
- `EQ-ERROR` — 05 EQ-ERROR              PIC X(160). Evidence: `app/copybooks/EQCOMM.cpy:34`.
- `EQ-EQUIP-COUNT` — 05 EQ-EQUIP-COUNT        PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:36`.
- `EQ-EQUIP-ROWS` — 05 EQ-EQUIP-ROWS         OCCURS 50 TIMES. Evidence: `app/copybooks/EQCOMM.cpy:37`.
- `EQ-EQ-ID` — 10 EQ-EQ-ID           PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:38`.
- `EQ-EQ-NAME` — 10 EQ-EQ-NAME         PIC X(40). Evidence: `app/copybooks/EQCOMM.cpy:39`.
- `EQ-EQ-DESC` — 10 EQ-EQ-DESC         PIC X(120). Evidence: `app/copybooks/EQCOMM.cpy:40`.
- `EQ-EQ-AVAILABLE` — 10 EQ-EQ-AVAILABLE    PIC X. Evidence: `app/copybooks/EQCOMM.cpy:41`.
- `EQ-RSRV-COUNT` — 05 EQ-RSRV-COUNT         PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:43`.
- `EQ-RSRV-ROWS` — 05 EQ-RSRV-ROWS          OCCURS 50 TIMES. Evidence: `app/copybooks/EQCOMM.cpy:44`.
- `EQ-RV-ID` — 10 EQ-RV-ID           PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:45`.
- `EQ-RV-EQUIP-ID` — 10 EQ-RV-EQUIP-ID     PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:46`.
- `EQ-RV-ACTOR-ID` — 10 EQ-RV-ACTOR-ID     PIC X(12). Evidence: `app/copybooks/EQCOMM.cpy:47`.
- `EQ-RV-START-TS` — 10 EQ-RV-START-TS     PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:48`.
- `EQ-RV-END-TS` — 10 EQ-RV-END-TS      PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:49`.
- `EQ-RV-STATE` — 10 EQ-RV-STATE        PIC X(10). Evidence: `app/copybooks/EQCOMM.cpy:50`.
- `EQ-USE-COUNT` — 05 EQ-USE-COUNT           PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:52`.
- `EQ-USE-ROWS` — 05 EQ-USE-ROWS           OCCURS 50 TIMES. Evidence: `app/copybooks/EQCOMM.cpy:53`.
- `EQ-USE-ID-ROW` — 10 EQ-USE-ID-ROW      PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:54`.
- `EQ-USE-RSRV-ID` — 10 EQ-USE-RSRV-ID     PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:55`.
- `EQ-USE-EQUIP-ID` — 10 EQ-USE-EQUIP-ID    PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:56`.
- `EQ-USE-ACTOR-ID` — 10 EQ-USE-ACTOR-ID    PIC X(12). Evidence: `app/copybooks/EQCOMM.cpy:57`.
- `EQ-USE-PICKUP-TS` — 10 EQ-USE-PICKUP-TS   PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:58`.
- `EQ-USE-RETURN-TS` — 10 EQ-USE-RETURN-TS   PIC X(26). Evidence: `app/copybooks/EQCOMM.cpy:59`.
- `EQ-INVALID-COUNT` — 05 EQ-INVALID-COUNT       PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:61`.
- `EQ-INVALID-ROWS` — 05 EQ-INVALID-ROWS        OCCURS 50 TIMES. Evidence: `app/copybooks/EQCOMM.cpy:62`.
- `EQ-INVALID-RSRV-ID` — 10 EQ-INVALID-RSRV-ID PIC S9(9) COMP-5. Evidence: `app/copybooks/EQCOMM.cpy:63`.

# Control flow

- Entry and behavior follow the declarations above. The first executable region starts at `app/copybooks/EQCOMM.cpy:7`. Read the cited source for branch detail.

# Dependencies

- Used by [EQWEB00.cbl](../programs/EQWEB00.cbl.md).
- Used by [EQACT00.cbl](../programs/EQACT00.cbl.md).
- Used by [EQCAT00.cbl](../programs/EQCAT00.cbl.md).
- Used by [EQSCH00.cbl](../programs/EQSCH00.cbl.md).
- Used by [EQOPS00.cbl](../programs/EQOPS00.cbl.md).
- Used by [EQHND00.cbl](../programs/EQHND00.cbl.md).
- Used by [EQTEST00.cbl](../tests/EQTEST00.cbl.md).

# Errors

- Error handling or error outputs occur in the source. Evidence: `app/copybooks/EQCOMM.cpy:32`.

# Tests

- [EQTEST00.cbl](../tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Scheduling Operations](../../../modules/scheduling-operations.md).

# Evidence

- `app/copybooks/EQCOMM.cpy:1` — file start.
- `git_blob: 8fdfeee7acbbba9346c7a6a937e06abd4f62770b` — source content hash.
