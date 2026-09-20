---
name: create-specspec
description: Create a complete top-down SpecSpec L4-L1 design from a short software application description. Use when the user wants the full SpecSpec design workflow instead of one layer.
---

# Create SpecSpec Design

Create a complete SpecSpec design from L4 through L1. Start with the application description.
Run each layer skill in order. Do not create L0 documents or source code.

## Inputs and destination

Require a short application description. Use the destination that the user supplies. Otherwise,
use an existing SpecSpec bundle in the workspace. If no bundle exists, use `spec/`.

Record these items during the workflow:

- The original description.
- The bundle root.
- User answers for each layer.
- Files created or changed at each layer.
- All `[NEEDS CONFIRMATION]` items.
- Review findings and corrections.

Keep this record in working context. Do not create a separate status file unless the user asks for
one.

## Required skill order

Read and follow these sibling skills in this exact order:

1. `../create-specspec-l4/SKILL.md`
2. `../create-specspec-l3/SKILL.md`
3. `../create-specspec-l2/SKILL.md`
4. `../create-specspec-l1/SKILL.md`

Do not run layer skills in parallel. Each lower layer depends on approved higher-layer content.
The layer skill owns its concept selection, questions, file structure, provenance rules, and
independent review.

## Workflow

For each layer:

1. Read the layer skill and its referenced concept file.
2. Inspect the required inputs from the higher layer.
3. Ask the layer skill's clarifying questions.
4. Wait for the user's answers.
5. Generate or revise the layer files.
6. Complete the independent review required by the layer skill.
7. Correct valid findings.
8. Verify the layer's final checks and handoff to the next layer.

Do not ask all layer questions at the start. Later questions depend on earlier design choices.

If the user tells you to continue without an answer, follow the active layer skill's rules for
unconfirmed assumptions. Stop when a contradiction or missing choice can cause a material change
to product intent, authorization, data ownership, or architecture.

## Final architecture review

After L1 passes its layer review:

1. Run the bundled ontology validator. Resolve the plugin root by moving two directories up from
   this skill directory. Run:

   ```shell
   python3 <plugin-root>/scripts/validate_specspec_design.py <bundle-root>
   ```

2. Run the sibling `../review-specspec-design/SKILL.md` skill on the full bundle. Give it the
   original description, all user answers, and confirmed decisions as its source packet. When the
   host supports agents, start a separate review agent. Give it the reviewer skill, source packet,
   and bundle. If the host has no agent feature, do a separate self-review and state that it was
   not independent.
3. If the review reports any valid finding, run `../correct-specspec-design/SKILL.md` with the
   review report. This rule also applies to Low findings.
4. Accept completion only after the correction skill returns a passing final review.

Do not duplicate the reviewer or correcter rules in this skill. Follow their current instructions.

## Failure and resume behavior

Stop and report the blocker when:

- A required higher layer is incomplete.
- Supplied facts contradict each other.
- The user must make a material decision.
- An independent layer review has an unresolved material finding.
- The final architecture review does not pass after the correction limit.

Keep valid completed layers. On resume, start at the first incomplete or invalid layer. Do not
regenerate approved files without a reason.

## Writing rules

Use ASD-STE100 principles in questions, documents, and reports.

- Use simple words and active voice.
- Use one main idea in each sentence.
- Keep sentences short. Use 20 words or fewer when practical.
- Use one term for one concept.
- Do not use idioms, marketing language, or vague modifiers.

## Completion report

Report these items:

- The bundle root.
- Files created or changed, grouped by layer.
- All `[NEEDS CONFIRMATION]` items.
- The L3-L1 validator result.
- The final architecture review verdict.
- Whether each layer review and the final review were independent.

Mark the workflow complete only when L4, L3, L2, and L1 exist, the final review passes, and no
unaccepted finding remains.
