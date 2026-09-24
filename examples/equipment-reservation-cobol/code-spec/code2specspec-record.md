# Code-derived bundle record

- Source root: `examples/equipment-reservation-cobol`.
- Specification root: `examples/equipment-reservation-cobol/code-spec`.
- Git source revision: `b49ac9d318000495dffc599116320a75fd08fd91`.
- Included files: 20.
- Runtime: Enterprise COBOL, CICS, and DB2 for z/OS.
- Source documents are revision-pinned only where each L0 file records `source_ref` and `git_commit`.
- L4 product purpose is inferred from code; a source repository cannot confirm business intent.

## Exclusions

- `spec/` — Existing design bundle reserved for later comparison.
- `code-spec/` — Output of this reverse documentation pass.
- `implementation-plan.md, implementation-record.md, architecture-review.md, criterion-ids.txt` — Project process records, not application inputs.

## Runtime verification

- Target runtime is unavailable on this workstation. Source inspection does not prove executable behavior.
- Criterion marker check against the existing `spec/`: 50/50 markers found. No COBOL test executed.
