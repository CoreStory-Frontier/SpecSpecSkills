# Independent implementation review

Give this brief to a separate reviewer after code, tests, and L0 are ready. The reviewer must not
edit files. Supply the approved L4-L1 baseline, implementation bundle, source root, source packet,
approved stack and integration decisions, maintained phase plan, acceptance record, and test results.

Read all concept documents and all included source files. Use the adjacent `l0-concepts.md`,
`criterion-traceability.md`, and the sibling layer references under
`../../create-specspec-l1/references/` through `../../create-specspec-l4/references/` for their
schemas. The implementation copy extends L1 to L0: require real downward links instead of the
design skill's terminal statements.

## Checks

1. Criterion coverage: run the bundled coverage check. Every Behavior bullet and every
   Acceptance criterion in every L4 Capability must have a test marker. A missing marker is a
   finding. Read each marked test and confirm that it asserts the criterion. Check that the
   recorded test node ID exists and that it names the test that carries the marker.
2. Product fidelity: every criterion has concrete behavior and executed verification. Run the
   tests yourself, or read the test output when tools are unavailable. Report skipped tests,
   flaky results, and weak assertions. Check negative paths, state changes, ownership, and access
   control. A passing test cannot excuse an incorrect expected result.
3. Architecture fidelity: code respects supplied Component ownership, Module contracts, dependency
   direction, data rules, workflows, and approved runtime choices.
4. Reference scope: local substitutes and limits are disclosed and approved. They do not silently
   weaken acceptance criteria or claim coverage of untested real integrations.
5. Reproducibility: setup and startup commands work. Rerun the build and tests when tools permit.
   Report unrun checks honestly. Check for skipped tests, flaky results, and missing assertions.
6. L0 fidelity: file coverage is complete; public and private symbols are described; anchors,
   hashes, dependencies, reverse edges, and conditional sections match the final source.
7. Cross-layer consistency: every L4 Capability reaches implementation evidence; every L0 file
   has justified ownership. Navigation, IDs, and reciprocal relationships agree at every boundary.
8. Provenance: supplied intent is preserved, observed claims match code, and inferred claims
   remain marked. Git metadata describes the actual tested revision or explicitly uncommitted
   files. Do not confuse working-tree semantic consistency with upstream conformance.
9. Phase evidence: completed phases have passing criteria and current evidence. Changes reopen
   affected phases. The review phase remains in progress until this review passes; then its
   verdict is recorded before the workflow is marked complete.

Read the relevant source even when a structural validator passes. The bundled design validator
does not cover L0 and rejects extended L1. Its passing result on the input baseline is not a
validation result for the implementation bundle.

## Report

Return:

- Scope read, files or checks unavailable, and tested snapshot identity.
- Findings with stable IDs, severity, exact file and section or line, evidence, impact, and
  observable closure criteria. State whether each needs a user decision.
- Criterion coverage: total criteria, covered count, missing IDs, and the coverage-check output.
- Executed verification: the test command, the observed result, and the test node ID for each
  criterion. State each criterion with no passing test. A test marker alone is not a pass.
- L0 coverage, link, anchor, and revision status.
- A `PASS`, `FAIL`, or `BLOCKED` verdict.

Use Critical for unsafe or contradictory implementation, High for missing outcomes, missing
criterion tests, or missing controls, Medium for incomplete behavior or evidence, and Low for local
clarity defects. Preserve finding
IDs on re-review. PASS requires no unresolved findings and no required verification left unrun.
BLOCKED means required evidence or tools are unavailable. A self-review cannot replace this pass.
