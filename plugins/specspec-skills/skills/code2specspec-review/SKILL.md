---
name: code2specspec-review
description: Review a code-derived SpecSpec L0-L4 bundle against source and an optional reference spec for accuracy, coverage, traceability, and implementation gaps. Read-only.
---

# Review code-derived SpecSpec

Review the specification against the current source. Do not edit code or specification files.
Read [source evidence](../code2specspec/references/source-evidence.md), the
[behavior audit](../code2specspec/references/behavior-audit.md), the
[L0 reference](../implement-spec/references/l0-concepts.md), and the L1-L4 concept references in
the sibling `create-specspec-l*` skills. Apply their types, IDs, paths, and sections. For this
code-derived bundle, require observed L0 links from L1 rather than design-only placeholders.

## Inputs and checks

Require the source root and specification root. Accept a source packet of user statements and
project documents, an optional comparison spec, and the gap report when available. Record the
revision or working-tree state. Read all concept
documents, their linked source, and enough surrounding code and tests to verify each material
claim. Run relevant tests when feasible; report the command and result. A test that you did not
run is not passing evidence.

Check these areas:

1. **L0 coverage:** Compare the declared source inventory with Source File documents. Verify
   exclusions, unique IDs, actual source paths, hashes, revision fields, symbols, dependencies,
   and line anchors. Check for duplicate declarations or labels within the source scope; record
   collisions even when target compilation is unavailable. Check for secrets in generated documents.
2. **L1-L3 accuracy:** Compare responsibilities, public surfaces, dependencies, data rules,
   interfaces, workflows, authorization, runtime, and operational claims with code and tests.
   Distinguish implemented behavior from comments, configuration options, and unused code.
3. **L4 accuracy:** Trace each Behavior and Acceptance statement to implemented behavior or a
   passing relevant test. Treat user outcomes and intent inferred from code as inference. Check
   supplied goals against the source packet. Find user-visible code paths absent from L4. Follow
   interface dispatch through response formatting to each claimed behavior. Report an unreachable
   function or a hidden result when the spec claims users can invoke or see it. Reject generic
   criteria that do not name an observable result.
4. **Graph:** Resolve every relative link. Compare reciprocal links at each layer boundary.
   Trace each Capability to L0 and each included L0 file to a justified higher-layer purpose,
   including tests, configuration, and build files.
5. **Provenance and format:** Check frontmatter, required sections, stable IDs, evidence citations,
   `[inferred]` and `[NEEDS CONFIRMATION]` markers. Do not use the design-only validator on an
   L0-extended bundle; it expects terminal L1 text.
6. **Gap coverage:** Recheck the behavior audit. Read test assertions, not just criterion markers.
   Compare every supplied criterion with the reachable entry-to-output path. Check that product
   goals, non-goals, ADRs, external Interfaces, and Observability claims absent from code are
   recorded as supplied intent or open gaps, not silently omitted or claimed as observed.

If a layer or source file is missing, report what you can verify and mark the missing scope.
When the target runtime is unavailable, complete the source-level review and use `BLOCKED` for
claims that require execution. A source-only bundle remains useful, but it does not prove the
application runs or meets acceptance criteria.
Do not claim full upstream conformance unless the upstream bundle and conformance rules were
checked for this snapshot.

## Report

Return a report with `Summary`, `Findings`, `Coverage`, `Checks run`, `Open confirmations`, and
`Verdict`. Give separate `Source accuracy` and, when a comparison spec exists, `Design alignment`
verdicts. A bundle can be source-accurate while the application fails a supplied criterion. Give each finding a
stable `C2S-###` ID, severity, exact specification location,
source path and line or missing evidence, impact, and observable correction criteria. Preserve
IDs on re-review. Use `Critical` for unsafe or contradictory claims, `High` for wrong or missing
user outcomes and controls, `Medium` for material source or traceability gaps, and `Low` for local
clarity defects. Use `PASS` for source accuracy only when no material documentation finding
remains and required checks ran. A known implementation mismatch can make Design alignment `FAIL`
without making Source accuracy `FAIL`. Use `BLOCKED` when missing source, tools, or decisions
prevent the relevant verdict; otherwise use `FAIL` for an unresolved material defect.
State whether a reviewer was independent.
