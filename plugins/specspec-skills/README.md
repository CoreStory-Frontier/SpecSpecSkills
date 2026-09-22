# SpecSpec Skills

Use these skills in order when you need a complete top-down design:

1. `create-specspec` runs the complete workflow.
2. `create-specspec-l4` creates product intent and capabilities.
3. `create-specspec-l3` creates the system design.
4. `create-specspec-l2` creates component boundaries.
5. `create-specspec-l1` creates module boundaries.

Use `review-specspec-design` to inspect a complete L4-L1 design. It reports architecture findings
without changing documents. Use `correct-specspec-design` to resolve a reviewer report and repeat
the review.

You can also start at a lower layer when the required higher-layer documents already exist.

The design workflow stops at L1. Use `implement-spec` with an approved L4-L1 bundle to build a
new reference application. It asks for stack approval, delivers a runnable first version, and
continues until every Capability Behavior bullet and Acceptance criterion passes with a marked test.

It then derives L0 from tested code in a separate implementation bundle and requires an independent
L0-L4 review. It pauses for specification decisions. Working-tree L0 evidence records pending Git
pinning when no matching committed revision exists. Existing application changes are not supported.

The plugin includes an L3-L1 ontology validator at
`scripts/validate_specspec_design.py` and a criterion coverage checker at
`scripts/check_criterion_coverage.py`.

Three reference examples use the same approved design:

- `examples/equipment-reservation/` is a complete Python, Flask, and SQLite reference with
  90 passing tests, code-derived L0, and an independent L0-L4 review.
- `examples/equipment-reservation-cobol/` is a mainframe reference with Enterprise COBOL,
  CICS, DB2, a browser shell, JCL, and 50 marked criterion tests. Runtime verification is
  blocked because this workstation has no z/OS, CICS, DB2, or Enterprise COBOL runtime.
- `examples/equipment-reservation-foxpro/` is a Visual FoxPro 9 reference with DBF tables,
  a browser shell, and 50 marked criterion tests. Runtime verification is blocked because
  this workstation has no VFP9 runtime.
