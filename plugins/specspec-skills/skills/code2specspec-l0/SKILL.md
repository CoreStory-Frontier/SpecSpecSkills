---
name: code2specspec-l0
description: Document actual source files as SpecSpec L0 Source File concepts from an existing codebase. Use for code inventory, symbols, dependencies, and line-anchored evidence.
---

# Code to SpecSpec L0

Create or update L0 documents from the current code. Read
[source evidence](../code2specspec/references/source-evidence.md) and the
[L0 concept reference](../implement-spec/references/l0-concepts.md). Apply its inventory, metadata,
section, and evidence rules to an existing codebase. The reference's implementation-test gate does
not apply to this documentation task.

## Workflow

1. Identify the source root and output bundle. Inspect project instructions. Record the source
   snapshot, inventory, exclusions, and reason for each exclusion before writing.
2. Create one `files/<source_path>.md` Source File concept per included file. Use actual symbols,
   imports, behavior, data effects, configuration keys, and tests. Verify each path and line anchor
   against the file. Parse declarations with the source language's syntax. For COBOL, distinguish
   paragraph labels from control statements and record copybook fields. Describe generated or
   non-code files according to their real role. Summarize each behavioral unit's branch, data,
   side effect, and error paths; a list of names alone is incomplete.
3. Create `files/index.md` with a link to every L0 document. Check that source paths and IDs are
   unique. Check the inventory against L0 documents in both directions. Check duplicate symbol
   names within each compilation unit or namespace. Report collisions with both source anchors;
   do not assume a compiler result when the target compiler is unavailable.
4. If L1 exists, link each L0 file to its owning Module and update that Module's `Files`,
   `Decomposition`, and `Evidence` with the same direct links. If ownership is unclear, record the
   gap. Do not invent a generic Module.
5. Verify hashes and revision fields. Use actual committed metadata only when the documented bytes
   match that revision. Mark other files `revision_status: uncommitted` and omit unknown Git fields.

Report source coverage, exclusions, revision status, and unresolved ownership. Do not claim that
L0 alone proves product intent or that tests pass unless you ran them.
