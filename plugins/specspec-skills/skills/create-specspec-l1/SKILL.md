---
name: create-specspec-l1
description: Create or revise SpecSpec L1 Module documents from a complete set of L2 Component documents and their L3 context. Use for top-down module design that stops before L0 source-file documentation. Do not use this skill without L2 inputs or to describe implemented code.
---

# Create SpecSpec L1

Convert an approved SpecSpec L2 design into a clear L1 module design. Ask the user technical
questions before you write files. Create the smallest complete set of cohesive Modules.

## Inputs and scope

Require one or more files under `components/` with `type: Component`. Read every Component and
all L3 concepts linked from their `# Related` sections before you ask questions.

Stop and report missing, broken, or contradictory L2 content. Do not silently change Component
boundaries or system meaning.

Create or revise files under `modules/`. Update the L2 links that point down to the new L1 files.
Do not create L0 documents, source code, source-file plans, or root-bundle files. Do not change L3
or L4 content.

## Workflow

1. Read every Component, its linked L3 context, and `references/l1-concepts.md` from this skill.
2. Build a private list of Component responsibilities, interfaces, data ownership, workflows,
   dependencies, constraints, and unresolved questions.
3. Ask the user clarifying questions before you create or change files.
4. Wait for the user's answers. If the user tells you to continue without answers, mark each
   important assumption as `[NEEDS CONFIRMATION]`.
5. Define the Module boundaries and map every Component responsibility to at least one Module.
6. Define each Module's owner, public surface, and dependency direction.
7. Check cohesion, responsibility coverage, dependency cycles, and shared ownership.
8. Write `modules/index.md` and the Module files.
9. Update each Component's `# Modules`, `# Decomposition`, and `# Evidence` sections with the same
   direct L1 links.
10. Add reciprocal Component links to each Module's `# Related` section.
11. Start an independent review agent. Give it the L2 inputs, linked L3 context, the user's
    answers, and all changed files. Ask it to test completeness, correctness, traceability,
    boundaries, and clarity.
12. Correct each valid finding. Run the review again after a material correction.
13. Mark the task complete only when no material review finding remains.

If the host has no agent feature, do a separate review pass. State in the final response that the
review was not independent.

## Clarifying questions

Ask only questions that can change the Module design. Use one short numbered list. Cover these
subjects when the L2 and L3 files do not answer them:

- Required package, directory, or library boundaries.
- Responsibility groups within each Component.
- Planned public contracts between Modules.
- Dependency direction and prohibited dependencies.
- Shared behavior, shared data types, and their ownership.
- Selected language, framework, packaging, or build constraints that affect boundaries.
- Test, configuration, migration, or operational concerns that need separate Modules.
- Explicit Module exclusions.

Do not ask the user to name source files or code symbols. Offer a small number of suitable Module
options when a choice is necessary. Mark an accepted option as supplied.

Do not create or change files in the same response as the questions. Wait for the user.

## Provenance

The L2 and L3 files and the user's answers are authoritative.

- Set concept-level `provenance: supplied`.
- State supplied facts without an inline marker.
- Mark model-proposed boundaries, responsibilities, public contracts, internal structure, and
  dependencies as `[inferred]`.
- Mark uncertain or high-impact assumptions as `[NEEDS CONFIRMATION]`.
- Preserve inline provenance from L2 and L3. Do not convert an `[inferred]` claim into a supplied
  L1 claim unless the user confirms it.
- Preserve the marker on every restatement of an inferred claim. This rule applies to summaries,
  responsibilities, public surfaces, internal structure, dependencies, and navigation text.
- Use supplied facts only in frontmatter `title` and `description` fields. Put inferred detail in
  the body with an `[inferred]` marker.
- Never use `provenance: observed`.
- Do not invent directories, files, symbols, implementations, deployed infrastructure,
  libraries, protocols, or performance guarantees.

This is a proposed design. Do not claim that code implements it.

## L1 concept selection

L1 has one concept type: Module.

Create a Module only for a cohesive package or directory responsibility inside a Component. Read
the selection rules, identifier format, path, frontmatter, and required sections in
`references/l1-concepts.md` before you create or revise a Module.

Do not create an empty Module to complete a directory tree. Do not create a Module for one future
file, one function, one endpoint, one database table, or one user action by default.

## Ownership and boundaries

Assign each Component responsibility to at least one Module. Name one owning Module when several
Modules use the same contract or data shape.

- Keep responsibilities together when they have one purpose and change together.
- Split responsibilities when they have different public contracts or dependency directions.
- Put shared contracts in an owning Module. Other Modules depend on that owner.
- Record each internal Module dependency in the depending Module.
- Record Modules used by other Components as shared only when the user supplies that boundary.
- Do not use a generic `utils`, `common`, or `misc` Module to hide unrelated responsibilities.

A Module can support several Component responsibilities. Do not create one Module for each L3
concept.

## Planning links

Each Component must link down to all Modules that it contains:

- Put descriptive links under `# Modules`.
- Put the same direct links under `# Decomposition`.
- Repeat the same direct links under `# Evidence`.
- Remove the old L1 placeholders from all three sections after links exist.

Each Module must link up to every Component that contains it under `# Related`. These links must
be reciprocal with the Component's three L1 link sections.

L1 is the terminal layer of this design bundle. Each Module must contain:

- `# Files` with `_L0 source-file documentation is outside this design scope._` and no links.
- `# Decomposition` with `_L1 is the terminal layer of this design bundle._` and no links.
- `# Evidence` with `_L0 evidence is outside this design scope._` and no links.

Use relative Markdown links. Do not link to files that do not exist.

## Navigation

Write `modules/index.md` without frontmatter. Link to every Module and add a short description.

```markdown
# Modules (L1)

* [<Module>](<slug>.md) - <short description>.
```

## Existing files

When you revise an existing L1 set:

- Preserve stable `spec_id` values.
- Preserve supplied content unless the user asks for a change.
- Mark a conflict with supplied content as `[NEEDS CONFIRMATION]`.
- Change a boundary only when the L2 design or the user's answer supports the change.
- Remove a Module only when no Component responsibility needs it.
- Remove or update every link to a removed or renamed Module.

## Writing rules

Use ASD-STE100 principles.

- Use simple words and active voice.
- Use one main idea in each sentence.
- Keep sentences short. Use 20 words or fewer when practical.
- Use the same term for the same concept.
- Define product-specific terms before you use them.
- Use lists or tables for dense information.
- Do not use idioms, marketing language, or vague modifiers.
- Use descriptive present tense. Do not use `shall`.

## Review agent brief

The review agent must not edit files. It must report each finding with a severity, file path, and
reason. Ask it to test these areas:

- Completeness: Every Component responsibility maps to sufficient Modules.
- Correctness: L1 content does not contradict L2, L3, or the user's answers.
- Boundaries: Each Module is cohesive. Responsibilities do not have unexplained gaps or overlaps.
- Public surface: Each cross-Module interaction has a clear owning Module and planned contract.
- Dependencies: Module dependencies have clear direction. Cycles are absent or explicitly
  supplied and justified.
- Traceability: L2-to-L1 and L1-to-L2 links are complete and reciprocal.
- Provenance: Inferred and uncertain claims have the correct markers on every restatement.
- Structure: Module files have the required sections, identifiers, paths, and terminal-layer
  statements.
- Scope: Files contain no L0 concepts, file plans, source paths, code symbols, anchors, hashes,
  `source_ref` values, or claims about implemented code.
- Clarity: Terms are consistent. The prose follows the writing rules.

## Final checks

After the review passes, verify these conditions:

- Every Component links to at least one Module under `# Modules`, `# Decomposition`, and
  `# Evidence`.
- Each Component has the same Module set in all three sections.
- Every Module links to at least one Component under `# Related`.
- The reciprocal L2 and L1 links contain the same relationships.
- Every Component responsibility has an owning or supporting Module.
- Every cross-Module contract has one stated owner.
- All Module dependency links resolve and state their direction.
- Every dependency cycle is removed or is supplied and justified.
- All files use `type: Module`, `layer: L1`, and `provenance: supplied`.
- Each model-added claim has `[inferred]` or `[NEEDS CONFIRMATION]`.
- A final provenance sweep compares each L1 claim with its L2 or L3 source and the user's answers.
- Each Module has the three required terminal-layer statements and no L0 links.
- No source-file, code-symbol, or implementation claim exists.
- No material review finding remains open.

Run the bundled design ontology validator. Resolve the plugin root by moving two directories up
from this skill directory. Run
`python3 <plugin-root>/scripts/validate_specspec_design.py <bundle-root>`. Report the files that
you created or changed. List all `[NEEDS CONFIRMATION]` items. State that the review passed and
whether it was independent.
