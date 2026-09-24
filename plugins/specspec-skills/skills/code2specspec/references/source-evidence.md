# Source evidence for code2specspec

Use this reference with every `code2specspec` skill. The existing `create-specspec-l*`
concept references define document types, IDs, paths, and sections. Their design-stage
placeholders and `provenance: supplied` defaults do not apply to code-derived documents.

## Scope and snapshot

Record the source root, specification root, revision or working-tree state, and files inspected.
Include authored application code, tests, schemas, configuration, build files, and relevant
documentation. Exclude vendored dependencies, build output, caches, secrets, and the output
specification. List exclusions and reasons. Read ignored and untracked files where needed; do not
use `git ls-files` as the sole inventory. Do not copy secret values into specifications.
If the user wants an independent comparison with an existing specification, keep that specification
out of the generation source packet. Read it only after the code-derived bundle is complete.

Use the same source snapshot throughout the layers. After a source change, refresh affected L0
evidence and every claim or link built from it. A code change can invalidate a higher-layer claim.

## Claims and provenance

Distinguish three forms of evidence:

- `observed`: Code, configuration, or executed behavior directly supports the claim. Cite a source
  path and line, a passing test, or another lower-layer concept that links to source evidence.
  Source code can show a path exists without proving that it executes in the target runtime. A
  test assertion states an expected result; only a relevant passing test adds execution evidence.
- `supplied`: A user statement or project document states the claim. Name that source. A comment
  can record intent but does not prove runtime behavior.
- `inferred`: The model interprets purpose, boundaries, or user intent from available evidence.
  Mark the specific claim `[inferred]` and cite the evidence behind the interpretation.

Use the frontmatter `provenance` value that best describes the concept. Do not let a concept-level
value hide different claim origins in its body. Mark uncertainty as `[NEEDS CONFIRMATION]`. Do not
turn a passing test into proof of a broader requirement. Do not state that a missing feature is a
product non-goal without explicit evidence.
An existing spec can supply intent for a comparison. It cannot prove that code implements the
intent. Put unsupported requirements in the gap report instead of giving them observed provenance.

## Graph and documents

Use the existing SpecSpec paths and IDs. Keep one stable ID for each concept. Use relative links.
Each higher-layer `Decomposition` and `Evidence` section links to the direct lower-layer concepts
that support it. Each lower-layer `Related` section links back to its direct owners or parents.
Keep these relationships reciprocal. L4 Capabilities use `Realized by` for L3 links. The Product
Overview links to all Capabilities. Index files are navigation only and have no concept frontmatter.

For a code-derived bundle, L1 `Files`, `Decomposition`, and `Evidence` contain matching direct L0
links. Do not use the design-only terminal placeholders. L3 and L2 sections contain real downward
links. An empty section says `None observed.` and explains the evidence gap where it matters.
Do not create a concept only to fill a layer or force a one-to-one mapping between layers.

The bundled `validate_specspec_design.py` expects a design-only L1 terminal. It cannot validate
an L0-extended bundle. Use it only on a separate design-only copy if one exists. Validate the
code-derived bundle manually, including types, IDs, paths, sections, links, ownership, source
coverage, anchors, and claim accuracy. Do not claim full upstream conformance without checking
the upstream bundle and conformance rules against the final snapshot.
