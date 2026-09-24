---
name: code2specspec-l1
description: Derive SpecSpec L1 Module documents from an existing codebase and L0 source evidence. Use when documenting actual package responsibilities and module dependencies.
---

# Code to SpecSpec L1

Derive Module boundaries from the code's cohesive responsibilities. Read
[source evidence](../code2specspec/references/source-evidence.md) and the
[L1 concept reference](../create-specspec-l1/references/l1-concepts.md) for type, ID, path, and
section rules. Replace its design-only L0 placeholders with observed file links.

## Inputs and work

Require a source root and complete L0 inventory. Read the relevant code and L0 documents. Existing
L2 documents are useful context but are not required for a standalone L1 pass.

1. Group files by actual package, responsibility, public surface, and dependency direction. A
   directory is not automatically one Module. A single file is not automatically a Module.
2. Write `modules/<slug>.md` for each justified Module and `modules/index.md` for navigation.
   Describe actual public symbols and consumers. Cite L0 links and source anchors for important
   claims. Name concrete dependencies and their direction; do not replace a Module contract with
   "see L0." Mark interpreted purpose or boundary `[inferred]`. Give shared support files one
   explicit owner and explain why that Module owns their contract.
3. Put every owned L0 file under `Files`, `Decomposition`, and `Evidence`; keep those sets equal.
   Add reciprocal Module links under each Source File's `Related`. Record files with unclear
   ownership as gaps, without hiding them in an invented shared Module.
4. If L2 exists, link each Module to its owning Component under `Related` and update reciprocal
   Component links. Preserve stable IDs when updating an existing bundle.

Check file coverage, links, actual dependencies, ownership, and section completeness. Report
unowned files and uncertain Module boundaries.
