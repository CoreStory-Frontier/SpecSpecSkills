# Code2SpecSpec accuracy review — COBOL

## Summary

Self-review of the code-derived bundle against the COBOL example at Git revision
`b49ac9d318000495dffc599116320a75fd08fd91`. The review is not independent.

## Findings

### C2S-001 — Duplicate COBOL paragraph labels

- Severity: High
- Specification location: `files/app/programs/EQSCH00.cbl.md` — `Symbols`
- Source: `app/programs/EQSCH00.cbl:85` and `app/programs/EQSCH00.cbl:108` define `READ-CONTEXT` twice;
  lines 105 and 128 define `CONTEXT-DONE` twice.
- Impact: A compiler may reject the program or bind paragraph references unexpectedly. The
  target compiler is unavailable, so execution cannot settle the result here.
- Correction criteria: Give each distinct paragraph a unique name or remove the duplicate,
  compile on the target toolchain, and refresh L0 anchors and hashes.

## Coverage

- L0: 20 of 20 included authored files have Source File documents. Process records and the
  existing design are excluded with reasons in `code2specspec-record.md`.
- All L0 blobs match the source files at the recorded Git revision.
- L0 through L4 links resolve and direct parent-child links are reciprocal.
- The existing design's 50 criterion markers are present in `EQTEST00.cbl`. Marker presence does
  not prove a test passed.

## Checks run

- Criterion coverage checker against `spec/`: 50/50 markers found.
- Local inventory, hash, link, reciprocal-link, and anchor checks: passed.
- Enterprise COBOL, CICS, and DB2 tests: not run; target runtime is unavailable.

## Open confirmations

- Confirm inferred product intent and production deployment details.
- Resolve the duplicate paragraph labels and run the target build and tests.

## Verdict

BLOCKED for runtime accuracy. The source-backed documents remain usable as a draft. Full upstream
bundle conformance was not assessed.
