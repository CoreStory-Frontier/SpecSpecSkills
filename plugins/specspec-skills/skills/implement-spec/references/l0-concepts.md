# L0 source evidence

Read this reference after the implementation tests pass and before writing L0.
The upstream [Source File definition](https://github.com/corestory-frontier/specspec/blob/main/concept-types/source-file.md)
defines L0. This skill adds an explicit working-tree mode when no matching Git revision exists.

## Inventory and paths

Declare the source root and enumerate files from the filesystem, including untracked files.
Do not rely on `git ls-files` alone for a new application. Exclude dependency installations, build
outputs, caches, secrets, and the generated specification itself. Record each exclusion and its
reason in the implementation record. Keep authored source, tests, configuration, schemas, and
build manifests in scope. Explain treatment of generated lockfiles and other generated inputs.
Do not exclude difficult source files to obtain a coverage pass.

Create one document at `files/<source_path>.md` for every included file. Paths are relative to the
declared source root. Create `files/index.md` without frontmatter and link every L0 document.
Use `FILE-` plus the source path with separators normalized to hyphens as the stable ID.
Check for normalization collisions and assign documented stable suffixes when necessary.

## Metadata and revision truth

Use `type: Source File`, `layer: L0`, `provenance: observed`, `title`, `description`, `spec_id`,
`source_path`, `language`, `role`, and `generator: agent`. Roles include `source`, `config`, `test`,
`schema`, `infra`, and `doc`. Record the actual file content hash, using `git hash-object` for
`git_blob` without writing Git objects.

For a committed snapshot:

- Resolve `source_ref` to a real revision containing every included file.
- Use the commit that last changed each file at that revision for `git_commit`.
- Verify that the documented bytes and blob match the file in that revision.
- Only claim a revision-pinned bundle when all included files meet these conditions.

For new or modified working files with no matching revision:

- Mark `revision_status: uncommitted` as an explicit extension.
- Omit unknown `source_ref` and `git_commit`. Never use fabricated hashes or an unrelated HEAD.
- Record hashes, source root, coverage, and test results in the implementation record.
- State that these are working-tree L0 documents, not a fully conformant upstream code-spec.
- Do not commit only to satisfy metadata unless the user authorized a commit. If authorized,
  commit only the intended implementation, then refresh revision fields from that commit.

Preserve L4-L1 provenance. Adding evidence does not turn supplied goals into observed facts.
Full upstream conformance also requires bundle metadata and coverage rules from the upstream
[bundle format](https://github.com/corestory-frontier/specspec/blob/main/conventions/bundle-format.md)
and [conformance rules](https://github.com/corestory-frontier/specspec/blob/main/conformance.md).
Read those rules and run the matching validator before claiming full upstream conformance.

## Sections

| Heading | Content | When required |
|---|---|---|
| `# Purpose` | Why this file exists. | Always |
| `# Responsibilities` | Each concern owned by the file. | Always |
| `# Symbols` | Every named declaration and behavioral unit, including private symbols. | Always |
| `# Control flow` | Entry flow, branches, loops, and state transitions. | Behavioral files |
| `# Data & side effects` | Data changes and network, filesystem, or environment effects. | If present |
| `# Dependencies` | Internal imports with L0 links, external packages, and reverse import links. | Always |
| `# Errors` | Raised, handled, and propagated errors. | If present |
| `# Configuration` | Configuration keys and sources, without secret values. | If present |
| `# Tests` | Links to test-file concepts that cover this file. | If present |
| `# Related` | Links to the containing L1 Modules. | Always |
| `# Evidence` | Real source path and line anchors. | Always |
| `# Notes` | Marked inference, supplied context, or uncertainty. | If present |

Describe symbols using the language's vocabulary. Include signatures, shapes, behavior, effects,
and errors as applicable. Each symbol has a verified `path:line` anchor. Config-only files can
describe named keys; state when no symbols exist. Do not paste the source as its documentation.
Group symbols by purpose for large files while retaining one document per file.

## Extend the implementation copy to L0

For each L1 Module, replace the design-only text under `Files`, `Decomposition`, and `Evidence`
with the same direct L0 link set. Add reciprocal Module links under each Source File's `Related`.
Keep every L2-to-L1 and higher relationship intact. Put implementation detail in the Module's
public surface and internal structure only where observed code supports it; label new evidence
clearly and preserve supplied responsibilities.

Map tests and configuration to the responsible Module. If an included file has no justified owner,
pause for a boundary decision rather than inventing a generic Module.

## Evidence checks

- Compare the included-file inventory with L0 `source_path` values: no omissions or duplicates.
- Check unique IDs, required sections, and applicable conditional sections.
- Resolve all relative links and check exact reciprocal L1-L0 relationship sets.
- Check every anchor against the final file and the described symbol or behavior.
- Verify each blob against the tested bytes; test results must refer to this same snapshot.
- Check forward and reverse import links, including changed or deleted imports.
- Trace every L4 Capability down to real source evidence and every L0 file back to a justified
  Module and product outcome, including supporting test and configuration responsibilities.

Regenerate affected evidence after any code change. A link check alone does not prove a symbol
description is accurate or a requirement is implemented.
