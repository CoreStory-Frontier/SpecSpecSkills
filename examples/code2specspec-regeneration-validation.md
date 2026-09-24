# Focused regeneration check

Date: 2026-09-23. Source snapshot: `b49ac9d318000495dffc599116320a75fd08fd91`.

I generated fresh L0-L4 scaffolds for the Python, COBOL, and Visual FoxPro examples under `/private/tmp/code2specspec-validation/`. I then applied the revised entry-to-output audit to the FoxPro and COBOL paths in scope. The scaffold generator is a helper from the earlier pass, not an invocation of the `code2specspec` skill. Its raw output still made generic claims and reduced detail in some documents. The audit required manual correction. This is a focused self-test of the instructions, not an independent end-to-end proof that a new agent will follow them.

| Gap | Fresh source check | Result in the corrected bundle |
|---|---|---|
| FoxPro item output | `EQWEB.PRG:119-125` prints item count, not item fields. | [Find equipment](equipment-reservation-foxpro/code-spec/product/capabilities/find-equipment.md) and [FoxPro gaps](equipment-reservation-foxpro/code-spec/code2specspec-gap-report.md) state the display limit. |
| FoxPro reservation output | `MyReservations` returns rows; `HtmlResult` prints their count. | [View reservations](equipment-reservation-foxpro/code-spec/product/capabilities/view-reservations.md) states the display limit. |
| FoxPro history | `EQWEB.PRG:58` calls `Execute`; `EQOPS.PRG:43-47` calls `EquipmentHistory`. Tests call `HandoffHistory` directly, so they do not verify browser HISTORY. | [Track equipment use](equipment-reservation-foxpro/code-spec/product/capabilities/track-equipment-use.md) and the gap report say browser HISTORY omits use records and detail. |
| COBOL duplicate labels | `EQSCH00.cbl:85,108` declares `READ-CONTEXT` twice; lines 105,128 declare `CONTEXT-DONE` twice. | [L0 source file](equipment-reservation-cobol/code-spec/files/app/programs/EQSCH00.cbl.md) and [COBOL gaps](equipment-reservation-cobol/code-spec/code2specspec-gap-report.md) record the collision. Compiler outcome remains unknown. |
| COBOL history response | `EQWEB00.cbl:235-250` writes reservation IDs, states, and use IDs, but no pickup or return times. | [Track equipment use](equipment-reservation-cobol/code-spec/product/capabilities/track-equipment-use.md) and the gap report state the response limit. |

The self-test exposed two skill checks worth making explicit. The behavior audit now requires a test to name the entry point it exercises; a direct function test cannot prove browser output. The reviewer now checks duplicate declarations and labels even when compilation is unavailable.

Checks: plugin validation passed; all relative Markdown links in the FoxPro and COBOL `code-spec/` bundles resolve; `git diff --check` passed. The skill creator's `quick_validate.py` could not run because PyYAML is absent in the available Python environments. No Visual FoxPro or CICS/DB2 runtime test ran. The code gaps remain; this work records them in the generated specification.
