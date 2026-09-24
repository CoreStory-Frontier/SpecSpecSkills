# Code to SpecSpec gap report: COBOL

Source snapshot: `b49ac9d318000495dffc599116320a75fd08fd91`. This is a focused comparison with the supplied `spec/` design. Source paths were inspected; the CICS/DB2 target build and tests were unavailable. No runtime result is verified.

| ID | Expected outcome and origin | Observed source path and test scope | Status | Impact and correction target |
|---|---|---|---|---|
| C-001 | The supplied design assumes runnable scheduling operations. | `EQSCH00.cbl` declares `READ-CONTEXT` at lines 85 and 108 and `CONTEXT-DONE` at lines 105 and 128. The target compiler was unavailable. | `unknown` runtime; source collision confirmed | Scheduling may fail to compile or resolve the intended paragraph. Code: give each paragraph a unique label or remove the duplicate, then build on the target. |
| C-002 | The supplied `track-equipment-use` Capability shows reservation, pickup, and return history. | Browser HISTORY writes reservation IDs, states, and use IDs (`app/programs/EQWEB00.cbl:235-250`), but does not write pickup or return times. The target test did not run. | `partial` | A browser user cannot see handoff times. Code: include both timestamps and test the response. |

Criterion markers in the COBOL test driver show planned coverage, not passed tests. The supplied goals, non-goals, ADR rationale, external workforce identity Interface, and Observability concepts remain intent that source alone cannot establish.
