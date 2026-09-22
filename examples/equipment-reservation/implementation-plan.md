# Equipment Reservation implementation plan

Status: approved on 2026-09-21. P0–P6 are complete.
The application is runnable and all 90 tests pass. All paths below are relative to this example directory.

## Inputs and destinations

- Input: `spec/`, containing 38 Markdown files, six Capabilities, three Components, and six Modules.
- Application: `app/` (new directory).
- Implementation record and acceptance table: `implementation-record.md`.
- Implementation bundle: `implemented-spec/`, copied from the approved design before adding L0.
- Existing skill and plugin edits in the repository are outside the application output.

## Approved stack

- Python 3.13, Flask 3.1, Jinja 3.1, and server-rendered HTML with CSS.
- SQLite through Python's standard library; serialized write transactions for conflict checks.
- uv with a project-local environment and locked dependency versions.
- pytest 9 for domain and HTTP integration tests; Playwright 1.x with Chromium for browser tests.
- Verified local run command from `app/`: `uv run flask --app equipment_reservation.web_access.web_interaction run --host 127.0.0.1 --port 5000`.
- Simple server-rendered pages reduce setup and keep the six Module boundaries visible. SQLite
  fits a local reference application; write concurrency is limited compared with a server database.
- Locked versions: Python 3.13.13, Flask 3.1.3, Jinja 3.1.6, pytest 9.1.1, Playwright 1.63.0.

## Module mapping

| Component | Python packages |
|---|---|
| Web Access | `web_access.web_interaction`, `web_access.actor_access` |
| Equipment Scheduling | `equipment_scheduling.equipment_catalog`, `equipment_scheduling.schedule_management`, `equipment_scheduling.scheduling_operations` |
| Equipment Handoff | `equipment_handoff.equipment_use_management` |

Templates and browser assets belong to Web Interaction. Tests and configuration have the same
Module owners as their behavior. Internal calls remain independent of HTTP.

## Approved identity substitute

Use a local demo identity adapter with fixed synthetic employees, a custodian, and a dual-role
user. A visible demo selector chooses an identity; server-side authorization still checks every
protected action. Unknown identities and absent actor context are denied.

This substitutes for the external workforce identity source only for this reference trial.
It does not prove a real workforce provider integration or production authentication. Explicit
approval was recorded on 2026-09-21. The application does not add employee identity administration.

## Approved behavior decisions

1. Use half-open periods: a booking ending at 11:00 does not conflict with one starting at 11:00.
   Normalize stored times to UTC; label browser input with its time zone.
2. Only confirmed Reservations block booking availability. Invalid, cancelled, and completed
   Reservations remain in history but do not block a new booking. Maintenance still blocks its
   entire period.
3. New maintenance invalidates overlapping confirmed Reservations, including picked-up ones.
   It leaves cancelled and completed Reservations unchanged. Return remains permitted after
   invalidation or cancellation; it records return and preserves that Reservation state.
   A return changes a still-confirmed Reservation to completed.

The user approved these decisions on 2026-09-21. Affected design statements now reflect them.

## Phase plan

The user approved all phases. Implementation evidence is recorded as phases run. A phase completes only when every criterion below passes. The implementation record
will hold exact commands, test results, and source coverage. Update this plan at every transition.

| Phase | Outcome | Depends on | Status | Completion date | Evidence |
|---|---|---|---|---|---|
| P0 | Approved, consistent implementation baseline | User decisions | complete | 2026-09-21 | Decisions applied; semantic reconciliation and ontology validation pass; source inventory in implementation-record.md |
| P1 | Runnable equipment reservation journey | P0 | complete | 2026-09-21 | Nine HTTP tests and Chromium journey pass; persistence and access checked |
| P2 | Maintenance and cancellation | P1 | complete | 2026-09-21 | 12 tests pass, including browser maintenance and cancellation |
| P3 | Pickup, return, and history | P2 | complete | 2026-09-21 | 16 tests pass; browser history and cancelled return verified |
| P4 | Complete acceptance and regression verification | P3 | complete | 2026-09-21 | 90 tests pass; compileall, locked setup and IPv4 startup pass; implementation-record.md |
| P5 | Code-derived L0 and complete implementation bundle | P4 | complete | 2026-09-21 | 12 L0 documents, 52 bundle documents; evidence.py --check passes |
| P6 | Independent L0-L4 review and handoff | P5 | complete | 2026-09-21 | [Independent review](implementation-review.md): PASS; no open findings |

### P0 — Approve and reconcile the baseline

Acceptance:

- User approval records the stack, phase plan, destinations, identity substitute, and behavior decisions.
- Approved behavior changes agree across affected L4-L1 documents; SSR-003 and SSR-004 are closed.
- Design validation and semantic review pass on that approved baseline.
- All 21 L4 criteria and mandatory lower-layer rules have phase and verification mappings in
  `implementation-record.md`. Pending results remain explicit.

Verification: decision record, updated specification review, ontology validator, and coverage audit.
No application dependency installation or coding precedes approval.

### P1 — Deliver the first runnable version

Scope: Web Interaction, Actor Access, Equipment Catalog, Schedule Management, and Scheduling Operations.

Acceptance:

- The documented command starts the browser application on localhost.
- A custodian adds two assets with distinct identities; records survive application restart.
- An employee finds a free item, reserves it, and sees that Reservation in their own list.
- An overlapping booking and a period whose end is not after its start are rejected without a new record.
- Another employee cannot see the first employee's Reservations. An empty list is shown when appropriate.
- Missing or unknown identity returns no protected data. Employees cannot add equipment.
- Dual-role actors can perform both implemented employee and custodian functions.
- Adjacent-period and time-zone tests match the approved P0 rule.

Verification: domain tests, HTTP tests, browser journey, restart check, and negative access tests.
Sources: F1–F2, R1–R2, R4, V1–V3, M1, and the implemented subset of A1–A4 below.
Report this runnable milestone and continue to P2 under the approved plan.

### P2 — Manage maintenance and invalid Reservations

Scope: maintenance periods, availability filtering, invalidation, and cancellation.

Acceptance:

- Maintenance blocks overlapping searches and new reservations.
- Invalid maintenance periods are rejected without stored changes.
- Later maintenance invalidates eligible overlapping Reservations under the approved state rules.
- Non-overlapping, cancelled, and completed records retain the states approved in P0.
- A custodian can cancel an invalid Reservation; an eligible-looking but non-invalid request is rejected.
- Availability after state changes follows the approved blocking-state rule.
- Employees cannot record maintenance or cancel invalid Reservations.

Verification: domain and HTTP tests of overlap, boundaries, states, invalid periods, and roles;
browser maintenance and cancellation journey; P1 regression checks.
Sources: F3, R3, M2–M4; maintenance and cancellation Workflows, Data Entity rules, and A1–A4.

### P3 — Record pickup, return, and history

Scope: Equipment Use Management and its scheduling contracts.

Acceptance:

- A custodian records pickup for an eligible Reservation; history shows that pickup.
- Ineligible or duplicate pickup creates no second Equipment Use record.
- Return after pickup records the return and applies the approved Reservation state transition.
- Return without pickup, duplicate return, and a return time before pickup are rejected.
- Return after maintenance invalidation or cancellation follows the approved P0 rule.
- Item history contains its Reservation, pickup, and return records without mixing other assets.
- Employees cannot record pickup or return or read custodian history.

Verification: domain and HTTP tests, browser handoff journey, and P1–P2 regression checks.
Sources: H1–H3; Equipment Use entity, pickup and return Workflows, and A1–A4.

### P4 — Prove complete acceptance coverage

Acceptance:

- Every L4 acceptance criterion and mandatory L3-L1 rule has passing verification evidence.
- Concurrent conflicting valid requests confirm exactly one Reservation and reject the other.
- Concurrent maintenance, pickup, and return operations preserve the approved data invariants.
- Every protected operation passes the employee, custodian, dual-role, and absent-identity access tests.
- Candidate reservation, availability, invalidation, and handoff signals contain the specified context.
- The full suite, applicable static/build checks, browser journeys, and fresh startup check pass.
- Setup documentation reproduces the local application and discloses the approved identity substitute.
- The three Components and six Modules retain their approved ownership and dependency directions.

Verification: full automated suite, browser tests, architecture inspection, signal checks, and
criterion-by-criterion audit. All source groups below must pass, including cross-cutting A1–A4.
The demo identity tests prove the approved local adapter only, not a real workforce integration.

### P5 — Derive and verify L0

Acceptance:

- `implemented-spec/` contains the approved L4-L1 design and one L0 document per included source file.
- The source inventory includes tests and authored configuration, with explicit exclusions.
- L0 describes private and public symbols, effects, errors, dependencies, and reverse dependencies.
- Links, anchors, hashes, IDs, and L1-L0 relationships match the final tested source.
- The original design remains available; only the implementation copy replaces L1 terminal statements.
- Uncommitted files use honest working-tree metadata. Pending Git pinning is explicitly reported.

Verification: inventory comparison, hash and anchor checks, link and relationship checks, and
source-to-document inspection using the skill's L0 reference. Reopen P4 if source changes.

### P6 — Independent review and handoff

Acceptance:

- A separate agent reviews code, tests, source coverage, and all L0-L4 documents.
- Every Capability reaches real code evidence; every included source file has justified ownership.
- No review finding, blocked required check, or unresolved specification decision remains.
- Any fix has fresh tests and regenerated L0 evidence, followed by independent re-review.
- All phase statuses and acceptance results reflect the final files.
- Handoff states run/test commands, output paths, reference limits, and Git pinning status.

Verification: the independent implementation review report and final phase/acceptance audit.
If independent review is unavailable, P6 becomes blocked, not complete.

## Source acceptance mapping

IDs below refer to bullets in each Capability's `Acceptance` section, in source order.
These IDs remain stable in the implementation record; copy the full source criteria there before coding.

| IDs | Source | Phases |
|---|---|---|
| F1–F3 | [Find Equipment](spec/product/capabilities/find-equipment.md#acceptance), bullets 1–3 | P1: F1–F2; P2: F3; P4: all |
| R1–R4 | [Reserve Equipment](spec/product/capabilities/reserve-equipment.md#acceptance), bullets 1–4 | P1: R1, R2, R4; P2: R3; P4: all |
| V1–V3 | [View Reservations](spec/product/capabilities/view-reservations.md#acceptance), bullets 1–3 | P1, P4 |
| M1–M4 | [Manage Equipment Availability](spec/product/capabilities/manage-equipment-availability.md#acceptance), bullets 1–4 | P1: M1; P2: M2–M4; P4: all |
| H1–H3 | [Track Equipment Use](spec/product/capabilities/track-equipment-use.md#acceptance), bullets 1–3 | P3, P4 |
| A1–A4 | [Control Employee Access](spec/product/capabilities/control-employee-access.md#acceptance), bullets 1–4 | P1–P3: each implemented operation; P4: full matrix |

Lower-layer coverage is assigned as follows. P0 expands these groups into individual mandatory
rules in the acceptance record; P4 verifies none were omitted.

| Source group | Rules covered | Phases |
|---|---|---|
| Equipment and Reservation entities | Identity, fields, relationships, lifecycle, periods, conflicts, concurrency | P1–P4 |
| Maintenance Period entity | Period validity, relationships, blocking, invalidation | P2, P4 |
| Equipment Use entity | Record identity, relationships, one pickup, ordered return, history | P3, P4 |
| Employee and Workforce Identity Interfaces; Authorization | Inputs, results, errors, ownership filtering, actor context, role union, denial | P1–P4 |
| Custodian Interface | Asset, maintenance, cancellation, handoff, history contracts and failures | P1–P4 |
| Five Workflows | Ordered validation and access checks, state changes, alternate and failure paths | P1–P4 |
| Observability | All four candidate signal contracts | P4 |
| Technical Overview, Decisions, Deployment | Product exclusions, browser interaction, one runtime, external identity boundary | P0, P1, P4 |
| Three Components and six Modules | Responsibilities, exclusions, ownership, public contracts, dependency direction | P1–P4; evidence in P5–P6 |

## Plan maintenance

On each transition, update status, completion date, evidence, remaining work, and next phase.
Use proposed, pending, in_progress, blocked, or complete. Reopen affected phases after changes
and invalidate stale evidence. Record material changes for approval without deleting old results.

Current next step: user handoff. All approved phases are complete. No commit, push, deployment, or Git revision pinning was performed.

## Change history

- 2026-09-21: Re-ran planning with the revised skill. Replaced increments with P0–P6, explicit
  acceptance criteria, source mapping, verification methods, status, dependencies, and evidence fields.
  At that time, stack, identity substitute, and behavior proposals awaited approval.
- 2026-09-21: User approved P0–P6, stack, destinations, demo identity, and behavior decisions.
  P0 closed after the decisions were applied and the baseline validator passed.
- 2026-09-21: P1 started and completed with 10 passing tests and a runnable browser journey.
  P2 then completed with 12 passing tests. P3 completed with 16 passing tests.
- 2026-09-21: P4 started, added full role, state, concurrency, signal, and rollback checks, and
  completed with 90 passing tests, compileall, locked setup, and fresh IPv4 startup evidence.
- 2026-09-21: P5 started and completed with 12 L0 documents. Source hashes, line anchors,
  ownership, and links were checked. P6 started with an independent reviewer.
- 2026-09-21: P5 reopened for evidence-only corrections: HTML action units, artifact formatting,
  catalog side effects, file-specific control flow, and Actor Access enforcement explanation.
  No application source changed. Regeneration and checks passed; P5 closed again.

- 2026-09-21: P6 completed after independent PASS. All 90 tests passed independently; all
  21 L4 criteria and cross-layer evidence were checked. IR-001 (missing M1 test link) was fixed
  and rechecked. The verdict is in implementation-review.md. No open findings remain.

## SpecSpec Architecture Review

### Summary

The structural validator passes. The implementation-readiness review found two Medium ambiguities.
All four layers, navigation, ownership, and Module dependency directions were inspected.
The original description and confirmed choices in the conversation supplied the review context.

### Findings

#### SSR-003 — Time overlap lacks boundary semantics

- Severity: Medium
- Category: Data
- Location: `spec/system/data/reservation.md` — Invariants
- Related locations: `spec/system/data/maintenance-period.md` — Invariants
- Evidence: Both require overlap checks but do not define equality at a period boundary.
- Impact: Adjacent bookings can be accepted or rejected by different implementations.
- Correction criteria: State the approved interval and time-zone rules consistently.
- User decision required: Yes
- Owning layer: L3

#### SSR-004 — State rules are incomplete for maintenance and return

- Severity: Medium
- Category: Consistency
- Location: `spec/system/workflows/manage-maintenance.md` — Steps
- Related locations: `spec/system/workflows/record-equipment-return.md` — Steps;
  `spec/product/capabilities/find-equipment.md` — Behavior;
  `spec/system/data/reservation.md` — Lifecycle
- Evidence: Maintenance invalidates every overlapping Reservation without a state condition.
  Return completes its Reservation without a state condition. Availability says any Reservation
  blocks overlap, while the invariant limits conflicts between confirmed Reservations.
- Impact: Historical states can be overwritten, and cancelled bookings can block availability.
- Correction criteria: Define blocking states, maintenance transition eligibility, and return
  behavior after invalidation or cancellation. Apply the decision across affected layers.
- User decision required: Yes
- Owning layer: Cross-layer

### Open confirmations

No open confirmations. SSR-003 and SSR-004 describe the original findings, now closed by user approval and applied changes.
Stack, destinations, and the identity substitute were approved on 2026-09-21.

### Validator result

`python3 plugins/specspec-skills/scripts/validate_specspec_design.py examples/equipment-reservation/spec`

Result: `OK — L3-L1 ontology is consistent.`

### Verdict

PASS — SSR-003 and SSR-004 are closed by the approved rules applied across affected layers.
