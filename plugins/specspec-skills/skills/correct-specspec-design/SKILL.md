---
name: correct-specspec-design
description: Correct a SpecSpec L4-L1 design from a review-specspec-design findings report. Use to resolve confirmed structural, traceability, provenance, consistency, or architecture findings while preserving supplied intent.
---

# Correct SpecSpec Design

Correct verified findings in a SpecSpec L4-L1 design. Preserve supplied product intent. Make the
smallest complete change that closes each finding.

## Required inputs

Require these inputs:

- The SpecSpec bundle root.
- A findings report from `review-specspec-design`.

If no report exists, run the sibling `../review-specspec-design/SKILL.md` skill first. Give it the
source packet when one exists. Do not infer findings from a short problem statement when a
complete review can identify affected layers.

Read the full report and every cited document before you edit files.

## Classify findings

Classify each finding before correction.

### Direct correction

Correct these defects directly when the intended result is unambiguous:

- Broken or stale links.
- Missing reciprocal links.
- Wrong terminal statements.
- Duplicate navigation entries.
- Obsolete placeholders.
- Missing provenance markers on unchanged model-added claims.
- Local term or section inconsistencies.

Use direct correction for an identifier, type, or layer only when the report and document prove
one unambiguous value. Treat an ambiguous concept identity or type as a layer correction. Update
all references in the same correction when an identifier or path changes.

### Layer correction

Use the sibling layer skill when a finding changes meaning, responsibility, or boundaries:

- L4: `../create-specspec-l4/SKILL.md`
- L3: `../create-specspec-l3/SKILL.md`
- L2: `../create-specspec-l2/SKILL.md`
- L1: `../create-specspec-l1/SKILL.md`

Read and follow the selected skill and its concept reference. Supply the review evidence as input.
Do not replace its provenance, writing, question, or independent-review rules.

### User decision

Ask the user before a correction does one or more of these actions:

- Changes supplied product intent, scope, or a non-goal.
- Changes a user role or permission.
- Selects data ownership when the design supplies no owner.
- Selects a major technology, integration, runtime, or dependency direction.
- Resolves contradictory supplied facts.

Ask one short numbered list for all open decisions. Do not edit decision-dependent content until
the user answers. Mark unresolved items as open.

## Owning layer

Use this ownership model:

| Subject | Owning layer |
|---|---|
| Product purpose, user outcome, business rule, scope | L4 |
| System behavior, data, interface, workflow, authorization, runtime, decision | L3 |
| Deployable responsibility, service boundary, component ownership | L2 |
| Package responsibility, public surface, internal dependency | L1 |
| Direct links and traceability between two layers | Both linked layers |

Correct a rule in its owning layer first. Then update each affected lower layer. Do not change a
lower layer only to hide a higher-layer conflict.

## Workflow

1. Make a resolution table with each finding ID, class, owning layer, affected files, and decision
   status.
2. Ask the user for all required decisions. Wait for the answers.
3. Correct unambiguous direct defects.
4. Correct semantic defects from the highest affected layer to the lowest.
5. When a higher layer changes, reapply the affected layer skills in this order: L4, L3, L2, L1.
6. Update both ends of every changed cross-layer relationship in one change.
7. Run the bundled ontology validator. Resolve the plugin root by moving two directories up from
   this skill directory. Run:

   ```shell
   python3 <plugin-root>/scripts/validate_specspec_design.py <bundle-root>
   ```

8. Run the sibling `review-specspec-design` skill on the corrected bundle. Give it the source
   packet and prior report. When the host supports agents, start a separate review agent. Give it
   the reviewer skill, the source packet, the prior report, and the bundle. If the host has no
   agent feature, do a separate self-review and state that it was not independent.
9. Repeat correction and review for valid material findings. Stop after three correction cycles.
10. Report resolved and unresolved findings.

If three cycles do not produce a pass, stop. Report the remaining findings and their blockers. Do
not state that the correction is complete.

## Preservation rules

- Preserve stable `spec_id` values unless the concept identity changes.
- Preserve supplied facts unless the user changes them.
- Preserve valid content outside the affected finding.
- Preserve `[inferred]` and `[NEEDS CONFIRMATION]` on every restatement.
- Mark new model-added content as `[inferred]`.
- Mark uncertain or high-impact assumptions as `[NEEDS CONFIRMATION]`.
- Never use `provenance: observed`.
- Remove a concept only when no valid higher-layer need supports it.
- Remove or update every reference to a removed or renamed concept.
- Do not create L0 documents, source code, code symbols, or implementation claims.

## Writing rules

Use ASD-STE100 principles.

- Use simple words and active voice.
- Use one main idea in each sentence.
- Keep sentences short. Use 20 words or fewer when practical.
- Use one term for one concept.
- Do not use vague modifiers.

## Completion report

Report these items:

- The final review verdict.
- The validator result.
- A table with finding ID, action, changed files, and status.
- All changed files.
- All unresolved findings and `[NEEDS CONFIRMATION]` items.
- The number of correction cycles.

Resolve every valid finding. A finding can remain only when the user explicitly accepts or defers
it. Record that decision in the resolution table. Mark the task complete only when the final
review gives a `PASS` and no unaccepted finding remains.
