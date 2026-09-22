# Equipment Reservation COBOL implementation plan

Status: source-complete and runtime-blocked. The user approved COBOL for mainframe. This machine
has no z/OS, CICS, DB2, or Enterprise COBOL toolchain. Runtime verification is blocked until a
mainframe environment is available.

## Inputs and destinations

- Input: `spec/`, copied from the approved Equipment Reservation design.
- Application: `app/`.
- Schema: `db/schema.sql`.
- Browser shell: `web/`.
- Build and run jobs: `jcl/`.
- Tests: `app/tests/EQTEST00.cbl`.
- Implementation record: `implementation-record.md`.
- Implementation bundle: `implemented-spec/`, created only after runtime verification passes.

## Approved stack

- IBM Enterprise COBOL 6.3 for z/OS.
- CICS Transaction Server 5.6 or later for the browser-facing transaction.
- DB2 for z/OS 12 for all persistent application data.
- JCL for build, bind, install, and test jobs.
- A static browser shell in `web/`; CICS returns plain-text key/value responses.

The static shell keeps the browser boundary small. COBOL owns authorization, scheduling, handoff,
and storage. This is a reference implementation, not a production deployment design.

## Approved identity substitute

The same local demo identity rule applies. `EQP_ACTR` holds four fixed actors:

- `ALICE` and `BOB` have the employee role.
- `CASEY` has the custodian role.
- `DREW` has both roles.

The browser sends the selected actor ID. `EQACT00` reads the fixed role table and authorizes each
protected operation. This substitute does not prove integration with a real workforce provider.

## Approved behavior decisions

1. Periods are half-open. A booking that ends at 11:00 does not conflict with one that starts at
   11:00.
2. Only confirmed Reservations block booking availability. Invalid, cancelled, and completed
   Reservations remain in history.
3. Maintenance invalidates overlapping confirmed Reservations, including picked-up ones. It leaves
   cancelled and completed Reservations unchanged.
4. Return is permitted after invalidation or cancellation. It records the return and preserves that
   Reservation state. A return changes a still-confirmed Reservation to completed.

## Module mapping

| Component | COBOL programs |
|---|---|
| Web Access | `EQWEB00`, `EQACT00`, plus `web/index.html` and `web/app.js` |
| Equipment Scheduling | `EQCAT00`, `EQSCH00`, `EQOPS00` |
| Equipment Handoff | `EQHND00` |

`EQOPS00` is the public scheduling coordinator. `EQHND00` is the public handoff coordinator.
`EQWEB00` calls those coordinators after `EQACT00` permits the action.

## Phase plan

| Phase | Outcome | Depends on | Status | Completion date | Evidence |
|---|---|---|---|---|---|
| P0 | Approved design and stack baseline | User request | complete | 2026-09-21 | architecture-review.md; ontology validator PASS |
| P1 | Source-complete browser journey | P0 | blocked | — | COBOL, DB2 schema, browser shell, CICS entry, and tests written; runtime blocked by missing z/OS toolchain |
| P2 | Maintenance and cancellation | P1 | pending | — | Not run |
| P3 | Pickup, return, and history | P2 | pending | — | Not run |
| P4 | Complete criterion verification | P3 | blocked | — | No mainframe runtime or DB2 on this machine |
| P5 | Code-derived L0 | P4 | blocked | — | Runtime verification must pass first |
| P6 | Independent L0-L4 review | P5 | blocked | — | Runtime verification must pass first |

### P1 — First browser journey

Scope: browser shell, Actor Access, Equipment Catalog, Schedule Management, Scheduling Operations,
and the CICS web adapter.

Acceptance:

- The static browser page starts in a browser and can submit an action.
- A custodian adds two distinct Equipment items.
- An employee searches a free period, reserves one item, and sees that Reservation in their own
  list.
- An overlapping booking and an invalid period are rejected.
- Another employee sees no Reservation data from the first employee.
- Missing or unknown actors are denied.
- A dual-role actor can use both role sets.

Verification: run the CICS transaction and `EQTEST00` on z/OS. This machine cannot run either
check, so P1 remains blocked at runtime verification even after the source is complete.

### P2 — Maintenance and cancellation

Scope: maintenance periods, availability filtering, invalidation, and cancellation.

Acceptance:

- Maintenance blocks overlapping searches and reservations.
- Invalid periods are rejected without stored changes.
- Later maintenance invalidates only overlapping confirmed Reservations.
- Cancelled and completed states remain unchanged.
- A custodian can cancel an invalid Reservation; ineligible cancellation is rejected.
- Employees cannot record maintenance or cancel invalid Reservations.

Verification: `EQTEST00` paragraphs for ME criteria and regression checks on z/OS.

### P3 — Pickup, return, and history

Scope: Equipment Use Management and its scheduling contract.

Acceptance:

- Pickup is recorded once for an eligible confirmed Reservation.
- Return is recorded only after pickup and only once.
- Return preserves invalid and cancelled states and completes a confirmed Reservation.
- History contains Reservations, pickups, and returns for one Equipment item only.
- Employees cannot record pickup, return, or custodian history.

Verification: `EQTEST00` paragraphs for TU criteria and regression checks on z/OS.

### P4 — Complete criterion verification

Acceptance:

- Every Behavior bullet and every Acceptance criterion has a passing marked test.
- Concurrent conflicting requests confirm one Reservation and reject the other.
- The full suite, DB2 bind, CICS install, and fresh startup check pass.
- The three Components and six Modules retain their ownership and dependency directions.

Blocker: no z/OS, CICS, DB2, or Enterprise COBOL runtime exists on this machine.

### P5 — Derive L0

Acceptance: create one L0 document per source file after P4 passes. The runtime blocker prevents
honest L0 generation now.

### P6 — Independent review

Acceptance: a separate reviewer inspects code, tests, both bundles, and all L0-L4 links after P4
and P5 pass. The runtime blocker prevents this phase now.

## Source criterion mapping

The criterion IDs are generated by `criterion-ids.txt` and checked by
`plugins/specspec-skills/scripts/check_criterion_coverage.py`. Every ID must have a marked
paragraph in `EQTEST00.cbl`.

## Plan maintenance

A phase completes only after its acceptance checks pass on a mainframe runtime. A blocked phase
records the exact missing tool. No phase is marked complete from source inspection alone.
