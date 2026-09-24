---
name: code2specspec
description: Generate a source-derived SpecSpec L0-L4 bundle from an existing codebase. Audit reachable behavior and optionally compare it with a supplied spec, reporting implementation and intent gaps.
---

# Code to SpecSpec

Generate a SpecSpec bundle that describes an existing codebase. Read
[source evidence](references/source-evidence.md) and the
[behavior audit](references/behavior-audit.md). Use the source root and output path the user
supplies. Otherwise, use the current project root and `code-spec/`. Inspect the destination before
writing; preserve unrelated files and stable IDs in an existing bundle. Record source scope,
exclusions, revision state, and unresolved questions. Accept an existing spec as an optional
comparison target, not as code evidence.

## Required sequence

Read and follow these sibling skills in order. Invoke their workflows sequentially; each layer
must use the same source snapshot and the completed lower layers.

1. [L0](../code2specspec-l0/SKILL.md): Inventory source and create Source File evidence.
2. [L1](../code2specspec-l1/SKILL.md): Derive Module ownership and link L0.
3. [L2](../code2specspec-l2/SKILL.md): Derive Components and link L1.
4. [L3](../code2specspec-l3/SKILL.md): Derive system concepts and link L2.
5. [L4](../code2specspec-l4/SKILL.md): Derive product outcomes and link L3.
6. Apply the behavior audit. Save `code2specspec-gap-report.md` beside the concept directories.
   If an existing spec is a comparison target, read it now and cover every material Behavior and
   Acceptance criterion plus its product and system intent. Classify each difference instead of
   copying unsupported claims into the source-derived bundle.
7. [Accuracy review](../code2specspec-review/SKILL.md): Verify source accuracy and audit coverage.

Do not run layers in parallel. Update reciprocal links at each step. Keep the source inventory
and evidence record available to later layers. Ask for a user decision only when missing input
can materially change the product boundary or an architecture claim. Mark other interpretations
`[inferred]` and continue. A codebase can show behavior without proving its intended product
goals, deployment state, or success targets. If the user asks for complete product intent and no
authoritative source exists, ask one focused question after the code inventory. Otherwise record
the unknowns in the gap report.

Correct clear documentation and link errors found by the reviewer. Recheck affected source
claims after a correction. If the target runtime is unavailable, finish the source-backed bundle
and report the review as `BLOCKED`; do not imply that source inspection proves execution. Stop
when source access or a material user decision prevents an accurate result. On resume, inspect the existing bundle
and start at the first invalid or incomplete layer; do not regenerate valid documents without a
reason. If the host supports a separate reviewer and the user permits agent delegation, use one.
Otherwise perform a separate self-review and disclose that it was not independent.

## Completion

Report the bundle path, source snapshot, coverage and exclusions, revision-pinning status,
verification commands and results, accuracy verdict, gap-report path, open confirmations, and any
limits on upstream conformance. Complete a source-backed bundle when L0-L4 exist, direct and
reciprocal links resolve, the source inventory and available expected outcomes are covered, and
the accuracy review has no unresolved material documentation finding. A runtime-blocked review
can leave the bundle as a draft. Report implementation gaps and blocked verification without
claiming that the source meets the supplied design.
