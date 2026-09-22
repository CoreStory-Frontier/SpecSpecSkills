# Equipment Reservation — COBOL / CICS / DB2 reference

This is a source-complete reference implementation of the approved Equipment Reservation
SpecSpec design. It targets IBM Enterprise COBOL 6.3, CICS Transaction Server 5.6 or later,
and DB2 for z/OS 12. The same six Modules and three Components from the approved design are
used.

This workstation does not have a mainframe runtime. Therefore:

- The COBOL source is present.
- The DB2 schema is present.
- The browser shell is present.
- The CICS and JCL resource definitions are present.
- The 50 criterion tests are present with markers.
- The tests cannot be executed here.
- No L0 bundle is generated.

## Layout

- `spec/` — approved L4-L1 design copied from the Python reference.
- `app/programs/` — six COBOL programs, one per Module.
- `app/copybooks/` — shared COBOL record and SQL definitions.
- `app/tests/` — `EQTEST00.cbl`, one paragraph per Behavior and Acceptance criterion.
- `db/` — DB2 schema and reset SQL.
- `web/` — static browser shell.
- `jcl/` — build, run, and CICS resource definitions.
- `implementation-plan.md` — phased plan and blocker.
- `implementation-record.md` — stack, decisions, 50 criterion rows, and 251 lower-layer rules.
- `architecture-review.md` — design review result.

## Module mapping

| Component | Programs |
|---|---|
| Web Access | `EQWEB00`, `EQACT00` |
| Equipment Scheduling | `EQCAT00`, `EQSCH00`, `EQOPS00` |
| Equipment Handoff | `EQHND00` |

`web/index.html` is the browser shell. It posts plain-text form fields to `/eqrs`.
`EQWEB00` receives those fields, calls `EQACT00`, then calls `EQOPS00` or `EQHND00`.

## Build and run on z/OS

1. Apply `db/schema.sql`.
2. Compile and link the six COBOL programs with the DB2 precompiler.
3. Bind the generated DBRMs into a DB2 plan.
4. Install `EQWEB00` as a CICS transaction.
5. Define the CICS transaction and URI map from `jcl/CICSRES.txt`.
6. Serve `web/` through a browser-facing gateway that maps `/eqrs` to `EQWEB00`.

`jcl/BUILD.jcl` and `jcl/RUNTESTS.jcl` are representative jobs. A site must adapt dataset
names, libraries, and compiler options.

## Verification

On a mainframe runtime:

```text
Run EQTEST00.
```

The test driver contains one paragraph per criterion. It resets DB2 data, seeds the required
state, and calls the Module programs directly.

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
