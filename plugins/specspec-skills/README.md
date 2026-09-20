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

The plugin stops at L1. Generate SpecSpec L0 documents from implemented code, not from the design
documents.

The plugin includes an L3-L1 ontology validator at
`scripts/validate_specspec_design.py`.
