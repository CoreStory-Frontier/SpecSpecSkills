# Code-derived and existing SpecSpec comparison

The three existing `spec/` directories have identical L4-L1 design documents. Each
`code-spec/` was generated from its example's source, tests, configuration, and README before the
existing design was read. The code-derived bundles add L0. They describe the source at Git revision
`b49ac9d318000495dffc599116320a75fd08fd91`.

| Example | Existing L4-L1 docs | Code-derived L4-L1 docs | Code-derived L0 docs | Runtime result |
|---|---:|---:|---:|---|
| Python | 38 | 35 | 12 | 90 tests passed |
| COBOL | 38 | 34 | 20 | Target runtime unavailable |
| Visual FoxPro | 38 | 34 | 13 | Target runtime unavailable |

## Expected document differences

- The code-derived bundles omit `ADR-0001` and `ADR-0002`. The code shows browser interaction and
  module boundaries, but it does not establish the decision rationale in the existing ADRs.
- The code-derived bundles omit the `workforce-identity` Interface. The examples use local demo
  actors. An external workforce provider is a design intent in the existing spec, not an observed
  integration. See the Python [actor adapter](equipment-reservation/app/equipment_reservation/web_access/actor_access.py)
  and the COBOL and FoxPro README files.
- COBOL and FoxPro code-derived bundles omit `equipment-operations` Observability. Their source
  does not implement the signals described in the design. Python does emit the corresponding log
  events in [schedule management](equipment-reservation/app/equipment_reservation/equipment_scheduling/schedule_management.py).
- The existing Product Overview supplies goals, non-goals, and success measures. The code-derived
  overview marks product purpose as inferred and leaves those decisions open. Source code cannot
  prove a product non-goal or a success target.
- Both sets contain six Capabilities, three Components, and six Modules. The Python and COBOL
  code-derived L4 files cover 29 Behavior bullets and 21 Acceptance criteria. Their wording
  describes observed source paths, so it is not a verbatim copy of the design.

## Source and design mismatches

| Finding | Source evidence | Existing design expectation | Effect |
|---|---|---|---|
| FoxPro browser hides result detail | [EQWEB.PRG](equipment-reservation-foxpro/app/programs/EQWEB.PRG) `HtmlResult` at line 119 formats status and item count only. | Find equipment shows item availability; View reservations shows owned records; equipment actions show useful IDs and states. | The domain functions can compute these values, but the user cannot inspect them through the browser. The code-derived L4 files state this limit. |
| FoxPro browser history omits use records | [EQWEB.PRG](equipment-reservation-foxpro/app/programs/EQWEB.PRG) line 58 sends `HISTORY` to `Execute`; [EQOPS.PRG](equipment-reservation-foxpro/app/programs/EQOPS.PRG) line 43 calls `EquipmentHistory`. `HandoffHistory` in [EQHAND.PRG](equipment-reservation-foxpro/app/programs/EQHAND.PRG) line 92 is not on that path. | [Track equipment use](equipment-reservation-foxpro/spec/product/capabilities/track-equipment-use.md) requires reservation, pickup, and return history. | The browser history action returns reservation history without use records. |
| COBOL history response omits times | [EQWEB00.cbl](equipment-reservation-cobol/app/programs/EQWEB00.cbl) lines 235-250 writes reservation IDs and states plus use IDs. | [Track equipment use](equipment-reservation-cobol/spec/product/capabilities/track-equipment-use.md) says history shows pickup and return. | The source holds pickup and return timestamps, but the browser response does not show them. Target execution remains unverified. |
| COBOL schedule has duplicate paragraph labels | [EQSCH00.cbl](equipment-reservation-cobol/app/programs/EQSCH00.cbl) defines `READ-CONTEXT` at lines 85 and 108 and `CONTEXT-DONE` at lines 105 and 128. | The existing design assumes runnable scheduling behavior. | A compiler may reject the program or resolve paragraph references unexpectedly. A target build is needed to settle it. |

## Changes made to the skills

- `code2specspec-l0` now requires language-aware symbol parsing and behavioral summaries. The
  first pass had mistaken COBOL control statements for paragraph labels.
- `code2specspec-l1` and `code2specspec-l2` now require concrete dependency direction and explicit
  ownership of shared support files. The first pass used vague dependency placeholders.
- `code2specspec-l3` now requires separate Workflows for distinct triggers. The first pass had
  missed cancellation as its own Workflow. It also requires actual entity and Interface shapes.
- `code2specspec-l4` now requires specific observable acceptance results and a full path from
  entry action to displayed result. The first pass used generic "returns a result" criteria.
- `code2specspec-review` now checks output formatting and distinguishes source inspection from
  executed tests. `code2specspec` can finish a source-backed draft with a `BLOCKED` review when
  the target runtime is unavailable.
- The shared source-evidence guide now keeps a comparison target out of the generation input.
- A follow-up revision adds a required entry-to-output behavior audit. The master skill writes a
  gap report after an independent code pass, checks test assertions rather than markers alone,
  and separates source accuracy from alignment with supplied intent. This addresses the FoxPro
  presentation and COBOL response gaps without inventing implemented behavior.

## Verification

- Python: `uv run pytest -q` passed all 90 tests.
- COBOL and FoxPro: the criterion marker checker found 50/50 markers in each test driver. No
  target-runtime tests ran.
- All generated Markdown links resolve. L0 hashes match the included source files. Direct
  parent-child links are reciprocal. Source anchors point within existing files.
- These checks do not establish full upstream bundle conformance. See each `code-spec/review.md`
  for the accuracy verdict and open confirmations.
