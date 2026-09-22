# Equipment Reservation — Visual FoxPro 9 reference

This is a source-complete reference implementation of the approved Equipment Reservation
SpecSpec design. It targets Microsoft Visual FoxPro 9.0 SP2. The same six Modules and three
Components from the approved design are used.

This workstation does not have Visual FoxPro 9. Therefore:

- The VFP source is present.
- The DBF schema and setup script are present.
- The browser shell is present.
- The 50 criterion tests are present with markers.
- The tests cannot be executed here.
- No L0 bundle is generated.

## Layout

- `spec/` — approved L4-L1 design copied from the Python reference.
- `app/programs/` — six VFP programs, one per Module, plus the shared DB helper.
- `app/tests/` — `EQTEST.PRG`, one procedure per Behavior and Acceptance criterion.
- `data/` — DBF tables created by `app/setup.prg`.
- `web/` — browser shell loaded by `EQWEB.PRG`.
- `build/` — VFP project build script.
- `implementation-plan.md` — phased plan and blocker.
- `implementation-record.md` — stack, decisions, criterion rows, and lower-layer rules.

## Module mapping

| Component | Programs |
|---|---|
| Web Access | `EQWEB.PRG`, `EQACT.PRG` |
| Equipment Scheduling | `EQCAT.PRG`, `EQSHED.PRG`, `EQOPS.PRG` |
| Equipment Handoff | `EQHAND.PRG` |

`EQDB.PRG` is a shared data helper. It does not own a business Module; it provides table paths
and ID generation inside the Scheduling Component boundary.

## Build and run in Visual FoxPro 9

From this directory:

```foxpro
DO app\setup.prg
DO app\programs\EQWEB.PRG
```

The setup script creates `actors.dbf`, `equipment.dbf`, `reservations.dbf`, `maintenance.dbf`,
and `equipuse.dbf`.

To build the project:

```foxpro
DO build\EQBUILD.PRG
```

`EQWEB.PRG` opens a FoxPro form with an embedded browser control. The browser posts actions to
`http://localhost/eq`; the form intercepts that request and calls the domain Modules.

## Verification

In Visual FoxPro 9:

```foxpro
DO app\tests\EQTEST.PRG
? RunAllCriterionTests()
```

On this workstation, run only:

```shell
python3 ../../plugins/specspec-skills/scripts/check_criterion_coverage.py \
  --bundle spec \
  --tests app/tests \
  --aliases criterion-ids.txt
```

Result on 2026-09-21:

```text
Criteria: 50 (29 behavior, 21 acceptance)
Covered: 50/50
```

No test is executed locally.
