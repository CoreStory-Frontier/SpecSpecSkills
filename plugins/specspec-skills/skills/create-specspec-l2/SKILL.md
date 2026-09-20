---
name: create-specspec-l2
description: Create or revise SpecSpec L2 Component documents from a complete set of L3 system documents. Use for top-down architectural decomposition before L1 or L0 design. Do not use this skill without L3 inputs or to document implemented code.
---

# Create SpecSpec L2

Convert an approved SpecSpec L3 design into a clear L2 component design. Ask the user technical
questions before you write files. Create the smallest complete set of architectural Components.

## Inputs and scope

Require one `system/technical-overview.md` file with `type: Technical Overview`. Read every L3
concept under `system/`, including nested directories, before you ask questions.

Stop and report missing or contradictory L3 content. Do not silently change the system meaning.

Create or revise files under `components/`. Update the L3 links that point down to the new L2
files. Do not create L1, L0, source-code, or root-bundle files.

## Workflow

1. Read every L3 concept and `references/l2-concepts.md` from this skill.
2. Build a private list of system responsibilities, interfaces, data ownership, workflows,
   policies, runtime needs, external systems, and unresolved questions.
3. Ask the user clarifying questions before you create or change files.
4. Wait for the user's answers. If the user tells you to continue without answers, mark each
   important assumption as `[NEEDS CONFIRMATION]`.
5. Define the component boundaries and map every L3 concept to at least one Component.
6. Check responsibility, interface, data, and dependency ownership before you write files.
7. Write `components/index.md` and the Component files.
8. Update each L3 concept's `# Decomposition` and `# Evidence` sections with the same direct L2
   links.
9. Update the Technical Overview's `# Components` section with every Component.
10. Add reciprocal L3 links to each Component's `# Related` section.
11. Start an independent review agent. Give it the L3 inputs, the user's answers, and all changed
    files. Ask it to test completeness, correctness, traceability, boundaries, and clarity.
12. Correct each valid finding. Run the review again after a material correction.
13. Mark the task complete only when no material review finding remains.

If the host has no agent feature, do a separate review pass. State in the final response that the
review was not independent.

## Clarifying questions

Ask only questions that can change the component design. Use one short numbered list. Cover these
subjects when the L3 files do not answer them:

- Required runtime or deployment boundaries.
- Ownership of each Data Entity and Interface.
- Which responsibilities must stay together or remain separate.
- Communication between Components and with external systems.
- Process lifecycle, concurrency, scaling, or isolation needs that affect boundaries.
- Selected platforms, frameworks, libraries, or managed services.
- Explicit Component exclusions and dependency restrictions.

Do not ask the user to define L1 Modules. Offer a small number of suitable boundary options when
a choice is necessary. Mark an accepted option as supplied.

Do not create or change files in the same response as the questions. Wait for the user.

## Provenance

The L3 files and the user's answers are authoritative.

- Set concept-level `provenance: supplied`.
- State supplied facts without an inline marker.
- Mark model-proposed boundaries, responsibilities, dependencies, and runtime behavior as
  `[inferred]`.
- Mark uncertain or high-impact assumptions as `[NEEDS CONFIRMATION]`.
- Preserve inline provenance from L3. Do not convert an `[inferred]` L3 claim into a supplied L2
  claim unless the user confirms it.
- Preserve the marker on every restatement of an inferred claim. This rule applies to summaries,
  responsibilities, interfaces, dependencies, ownership, and runtime notes.
- Use supplied facts only in frontmatter `title` and `description` fields. Put inferred detail in
  the body with an `[inferred]` marker.
- Never use `provenance: observed`.
- Do not invent implementation facts, deployed infrastructure, libraries, protocols, security
  guarantees, thresholds, or service levels.

This is a proposed design. Do not claim that code implements it.

## L2 concept selection

L2 has one concept type: Component.

Create a Component only for a coherent architectural subsystem. Read the selection rules,
identifier format, path, frontmatter, and required sections in `references/l2-concepts.md` before
you create or revise a Component.

Do not create an empty Component to complete a directory tree. Do not create a Component for an
external system that is outside the application boundary.

## Ownership and boundaries

Assign each responsibility to a primary Component. State shared work and handoffs explicitly.

- Give each Data Entity one primary owning Component unless the user supplies shared ownership.
- Give each Interface one Component that exposes it. Other Components can use it.
- Map a Workflow to every Component that performs a step.
- Map cross-cutting policies and runtime concerns to every Component they govern.
- Record each internal dependency in the depending Component.
- Record external systems as dependencies, not Components.

Do not create one Component for each L3 document. Several L3 views can describe one Component,
and one Workflow can span several Components.

## Planning links

Each L3 concept must link down to all Components that realize it:

- Put the direct links under `# Decomposition`.
- Repeat the same direct links under `# Evidence`.
- Remove the old L2 placeholder from each section after links exist.

Each Component must link up to all L3 concepts that it realizes under `# Related`. These links
must be reciprocal with the L3 `# Decomposition` and `# Evidence` links.

Each Component must keep these L1 planning placeholders:

- `# Modules` contains `_To be populated during L1 decomposition._`.
- `# Decomposition` contains `_To be populated during L1 decomposition._`.
- `# Evidence` contains `_Lower-layer evidence will be added during L1 decomposition._`.

Use relative Markdown links. Do not link to files that do not exist.

## Navigation

Write `components/index.md` without frontmatter. Link to every Component and add a short
description.

```markdown
# Components (L2)

* [<Component>](<slug>.md) - <short description>.
```

## Existing files

When you revise an existing L2 set:

- Preserve stable `spec_id` values.
- Preserve supplied content unless the user asks for a change.
- Mark a conflict with supplied content as `[NEEDS CONFIRMATION]`.
- Change a boundary only when the L3 design or the user's answer supports the change.
- Remove a Component only when no L3 concept needs it.
- Remove or update every link to a removed or renamed Component.

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

- Completeness: Every L3 concept maps to sufficient L2 Components.
- Correctness: L2 content does not contradict L3 or the user's answers.
- Boundaries: Each Component is cohesive. Responsibilities do not have unexplained gaps or
  overlaps.
- Ownership: Every Data Entity and Interface has explicit primary ownership.
- Dependencies: Internal and external dependencies have clear direction and match the L3 design.
- Traceability: L3-to-L2 and L2-to-L3 links are complete and reciprocal.
- Provenance: Inferred and uncertain claims have the correct markers on every restatement.
- Structure: Component files have the required sections, identifiers, paths, and L1 placeholders.
- Scope: Files contain no L1 or L0 concepts, source paths, anchors, hashes, `source_ref` values,
  or claims about implemented code.
- Clarity: Terms are consistent. The prose follows the writing rules.

## Final checks

After the review passes, verify these conditions:

- Every L3 concept links to at least one Component under both `# Decomposition` and `# Evidence`.
- Every Component links to at least one L3 concept under `# Related`.
- The reciprocal L3 and L2 links contain the same relationships.
- The Technical Overview lists every Component once under `# Components`.
- Every Data Entity has one stated primary owner or a supplied shared-ownership rule.
- Every Interface has one stated exposing Component.
- All internal Component dependency links resolve.
- All files use `type: Component`, `layer: L2`, and `provenance: supplied`.
- Each model-added claim has `[inferred]` or `[NEEDS CONFIRMATION]`.
- A final provenance sweep compares each L2 claim with its L3 source and the user's answers.
- Each Component keeps all three L1 planning placeholders.
- No L1, L0, or implementation claim exists.
- No material review finding remains open.

Report the files that you created or changed. List all `[NEEDS CONFIRMATION]` items. State that the
review passed and whether it was independent.
