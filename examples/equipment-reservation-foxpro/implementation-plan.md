# Equipment Reservation Visual FoxPro 9 implementation plan

Status: source-complete and runtime-blocked. The user approved Visual FoxPro 9 as the stack. This
machine has no VFP9 runtime or compiler, so no browser journey or test can execute here.

## Inputs and destinations

- Input: `spec/`, copied from the approved Equipment Reservation design.
- Application: `app/programs/`.
- Data setup: `app/setup.prg` and `data/`.
- Browser shell: `web/`.
- Tests: `app/tests/EQTEST.PRG`.
- Implementation record: `implementation-record.md`.
- Implementation bundle: `implemented-spec/`, created only after runtime verification passes.

## Approved stack

- Microsoft Visual FoxPro 9.0 SP2.
- Free DBF tables with CDX indexes.
- Native VFP SQL and Rushmore-compatible predicates.
- Programmatic forms and browser shell.
- No third-party dependency.

## Approved identity substitute

`actors.dbf` contains four fixed actors:

- `ALICE` and `BOB` have the employee role.
- `CASEY` has the custodian role.
- `DREW` has both roles.

This local table substitutes for the external workforce provider for this reference only.

## Approved behavior decisions

1. Periods are half-open. A booking that ends at 11:00 does not conflict with one that starts at
   11:00.
2. Only confirmed Reservations block availability. Invalid, cancelled, and completed Reservations
   remain in history.
3. Maintenance invalidates overlapping confirmed Reservations, including picked-up ones. It leaves
   cancelled and completed Reservations unchanged.
4. Return is permitted after invalidation or cancellation. It records the return and preserves that
   Reservation state. A return changes a still-confirmed Reservation to completed.

## Module mapping

| Component | VFP programs |
|---|---|
| Web Access | `EQWEB.PRG`, `EQACT.PRG`, plus `web/index.html` and `web/app.js` |
| Equipment Scheduling | `EQCAT.PRG`, `EQSHED.PRG`, `EQOPS.PRG` |
| Equipment Handoff | `EQHAND.PRG` |

`EQOPS.PRG` is the public scheduling coordinator. `EQHAND.PRG` is the public handoff coordinator.
`EQWEB.PRG` calls those coordinators after `EQACT.PRG` permits the action.

## Phase plan

| Phase | Outcome | Depends on | Status | Completion date | Evidence |
|---|---|---|---|---|---|
| P0 | Approved design and stack baseline | User request | complete | 2026-09-21 | architecture-review.md; ontology validator PASS |
| P1 | Source-complete browser journey | P0 | blocked | — | VFP modules, tables, browser shell, and tests written; runtime blocked by missing VFP9 |
| P2 | Maintenance and cancellation | P1 | blocked | — | Source complete; runtime blocked |
| P3 | Pickup, return, and history | P2 | blocked | — | Source complete; runtime blocked |
| P4 | Complete criterion verification | P3 | blocked | — | No VFP9 runtime |
| P5 | Code-derived L0 | P4 | blocked | — | Runtime verification must pass first |
| P6 | Independent L0-L4 review | P5 | blocked | — | Runtime verification must pass first |

### P1 — First browser journey

Acceptance:

- The browser page starts and can submit an action.
- A custodian adds two distinct Equipment items.
- An employee searches a free period, reserves one item, and sees that Reservation.
- An overlapping booking and an invalid period are rejected.
- Another employee sees no Reservation data from the first employee.
- Missing or unknown actors are denied.
- A dual-role actor can use both role sets.

Verification: start `EQWEB.PRG` in VFP9 and run `EQTEST.PRG`. This machine cannot run either check.

### P2 — Maintenance and cancellation

Acceptance:

- Maintenance blocks overlapping searches and reservations.
- Invalid periods are rejected.
- Later maintenance invalidates only overlapping confirmed Reservations.
- Cancelled and completed states remain unchanged.
- A custodian can cancel an invalid Reservation.
- Employees cannot record maintenance or cancel invalid Reservations.

### P3 — Pickup, return, and history

Acceptance:

- Pickup is recorded once for a confirmed Reservation.
- Return is recorded only after pickup and only once.
- Return preserves invalid and cancelled states and completes a confirmed Reservation.
- History contains Reservations, pickups, and returns for one Equipment item only.
- Employees cannot record pickup, return, or custodian history.

### P4 — Complete criterion verification

Acceptance:

- Every Behavior bullet and Acceptance criterion has a passing marked test.
- The full suite and fresh startup check pass.
- The three Components and six Modules retain their ownership and dependency directions.

Blocker: no Visual FoxPro 9 runtime or compiler exists on this machine.

### P5 — Derive L0

Acceptance: create one L0 document per source file after P4 passes.

### P6 — Independent review

Acceptance: a separate reviewer inspects code, tests, both bundles, and all L0-L4 links after P4 and
P5 pass.

## Plan maintenance

A phase completes only after its acceptance checks pass in Visual FoxPro 9. A blocked phase records
the exact missing tool. No phase is marked complete from source inspection alone.
