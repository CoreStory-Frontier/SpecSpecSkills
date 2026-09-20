---
name: create-specspec-l3
description: Create or revise SpecSpec L3 system documents from a complete set of L4 Product Overview and Capability files. Use for top-down system design before L2, L1, or L0 decomposition. Do not use this skill without L4 inputs or to document implemented code.
---

# Create SpecSpec L3

Convert an approved SpecSpec L4 design into a clear L3 system design. Ask the user technical
questions before you write files. Create only the L3 concepts that the design needs.

## Inputs and scope

Require these L4 inputs:

- One `product/overview.md` file with `type: Product Overview`.
- One or more files under `product/capabilities/` with `type: Capability`.

Read every L4 file before you ask questions. Stop and report missing or contradictory L4 content.
Do not silently repair L4 product meaning.

Create or revise files under `system/`. Update the L4 links that point down to the new L3 files.
Do not create L2, L1, L0, source-code, or root-bundle files.

## Workflow

1. Read the Product Overview, every Capability, and `references/l3-concepts.md` from this skill.
2. Build a private list of users, outcomes, rules, data, system boundaries, and open questions.
3. Ask the user clarifying questions before you create or change files.
4. Wait for the user's answers. If the user tells you to continue without answers, mark each
   important assumption as `[NEEDS CONFIRMATION]`.
5. Select the applicable L3 concept types. Use the selection rules in the reference file.
6. Map every Capability to at least one L3 concept.
7. Write `system/index.md` and the selected L3 files.
8. Update each Capability's `# Realized by` and `# Evidence` sections with relative L3 links.
9. Update the Product Overview evidence when a system-level link helps navigation.
10. Start an independent review agent. Give it the L4 inputs, the user's answers, and all changed
    files. Ask it to test completeness, correctness, traceability, and clarity.
11. Correct each valid finding. Run the review again after a material correction.
12. Mark the task complete only when no material review finding remains.

If the host has no agent feature, do a separate review pass. State in the final response that the
review was not independent.

## Clarifying questions

Ask only questions that can change the system design. Use one short numbered list. Cover these
subjects when the L4 files do not answer them:

- The system boundary and external systems.
- The main business records and their lifecycle.
- The required interaction channels or interface protocols.
- Roles, permissions, and access rules.
- Important workflow rules and failure outcomes.
- Required technical choices or constraints.
- Deployment, availability, and operational constraints.
- Required metrics, health checks, and alerts.

Do not ask the user to design every technical detail. Offer a small number of suitable options
when a choice is necessary. Mark an accepted option as supplied.

Do not create or change files in the same response as the questions. Wait for the user.

## Provenance

The L4 files and the user's answers are authoritative.

- Set concept-level `provenance: supplied`.
- State supplied facts without an inline marker.
- Mark additions from general technical knowledge as `[inferred]`.
- Mark uncertain or high-impact assumptions as `[NEEDS CONFIRMATION]`.
- Preserve inline provenance from L4. Do not convert an `[inferred]` L4 claim into a supplied L3
  claim unless the user confirms it.
- Preserve the marker on every restatement of an inferred claim. This rule applies to workflows,
  interface contracts, results, schemas, guarantees, and summaries.
- Treat a supplied business rule and its enforcement design as separate claims. Mark an
  unsupplied enforcement response as `[inferred]`.
- Use supplied facts only in frontmatter `title` and `description` fields. Put inferred detail in
  the body with an `[inferred]` marker.
- Mark model-added user-interface actions as `[inferred]`, even when the interface channel is
  supplied.
- Never use `provenance: observed`.
- Do not invent implementation facts, deployed infrastructure, integrations, protocols, security
  guarantees, thresholds, or service levels.

This is a proposed design. Do not claim that code implements it.

## L3 concept selection

Always create one Technical Overview.

Create other concepts only when the input supports them:

- Data Entity
- Interface
- Decision
- Workflow
- Authorization
- Deployment
- Observability

Read the matching section in `references/l3-concepts.md` before you create each concept type.
Do not create an empty concept to complete the directory tree.

## Planning links

Each L3 file must contain these planning links:

- `# Related` links up to every Capability that the concept supports.
- `# Decomposition` contains `_To be populated during L2 decomposition._` and no links.
- `# Evidence` contains `_Lower-layer evidence will be added during L2 decomposition._` and no
  links.

Each Capability must link down to all L3 concepts that realize it:

- Put the links under `# Realized by`.
- Repeat the same links under `# Evidence`.
- Remove the old L3 placeholder from each section after links exist.

Use relative Markdown links. Do not add links to files that do not exist.

## Navigation

Write `system/index.md` without frontmatter. Add one section for each concept type that exists.
Link to every L3 file and add a short description.

Do not add empty sections for concept types that do not exist.

## Existing files

When you revise an existing L3 set:

- Preserve stable `spec_id` values.
- Preserve supplied content unless the user asks for a change.
- Mark a conflict with supplied content as `[NEEDS CONFIRMATION]`.
- Keep ADR numbers stable. Add a new ADR when a decision changes.
- Remove a concept only when the L4 design no longer supports it.
- Remove or update every link to a removed or renamed concept.

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

- Completeness: Every L4 Capability maps to sufficient L3 concepts.
- Correctness: L3 content does not contradict L4 or the user's answers.
- Type choice: Each concept has the correct L3 type and required sections.
- Boundaries: Concepts do not duplicate responsibility or mix unrelated concerns.
- Workflow logic: A precondition does not make a later failure path impossible. Workflows with
  different triggers or outcomes are separate. A required check occurs before the protected
  action.
- Policy boundaries: Authorization contains access rules. Business validation stays in entities,
  interfaces, and workflows.
- System boundary: The Technical Overview includes every explicit L4 non-goal and exclusion.
- Traceability: L4-to-L3 and L3-to-L4 links are complete and reciprocal.
- Provenance: Inferred and uncertain claims have the correct markers.
- Scope: Files contain no L2-or-lower objects, source paths, anchors, hashes, or `source_ref`.
- Clarity: Terms are consistent. The prose follows the writing rules.

## Final checks

After the review passes, verify these conditions:

- Every Capability links to at least one L3 concept.
- Every L3 concept links to at least one Capability.
- The Technical Overview links to every L3 concept or its index entry.
- All relative links resolve in both directions.
- All files use `layer: L3` and `provenance: supplied`.
- Each model-added claim has `[inferred]` or `[NEEDS CONFIRMATION]`.
- A final provenance sweep compares each L3 claim with its L4 source and user answer.
- No lower-layer link or implementation claim exists.
- No material review finding remains open.

Report the files that you created or changed. List all `[NEEDS CONFIRMATION]` items. State that the
review passed and whether it was independent.
