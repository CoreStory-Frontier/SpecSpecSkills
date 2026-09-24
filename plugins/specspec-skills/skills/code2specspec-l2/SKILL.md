---
name: code2specspec-l2
description: Derive SpecSpec L2 Component documents from an existing codebase and lower-layer evidence. Use when documenting actual subsystem boundaries and ownership.
---

# Code to SpecSpec L2

Derive Components from observed runtime, responsibility, and dependency boundaries. Read
[source evidence](../code2specspec/references/source-evidence.md) and the
[L2 concept reference](../create-specspec-l2/references/l2-concepts.md) for type, ID, path, and
section rules. Use real L1 links in place of design-stage placeholders.

## Inputs and work

Require the source root and L0-L1 documents. Read code where a Component claim needs verification.
Existing L3 documents are context, not a prerequisite for a standalone pass.

1. Group Modules into Components only where the code shows a coherent subsystem, runtime unit,
   ownership boundary, or change boundary. A small application can have one Component.
2. Write `components/<slug>.md` and `components/index.md`. Describe observed responsibilities,
   interfaces, dependencies, and runtime behavior. Cite supporting Modules and source evidence.
   State the actual cross-Component calls and dependency direction. Do not leave an instruction to
   inspect lower layers in place of a dependency description. Mark interpreted architectural
   purpose `[inferred]`.
3. Link each Component to its direct Modules under `Modules`, `Decomposition`, and `Evidence`.
   Keep those sets equal. Add reciprocal links to each Module's `Related` section.
4. If L3 exists, link the L3 concepts each Component realizes under `Related`, and add reciprocal
   L3 downward links. Preserve existing stable IDs where the concept identity has not changed.

Check that every Module has justified Component ownership, each dependency reflects code, and all
links resolve. Report unowned Modules and uncertain boundaries.
