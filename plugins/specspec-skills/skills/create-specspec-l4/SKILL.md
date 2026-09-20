---
name: create-specspec-l4
description: Create or revise SpecSpec L4 Product Overview and Capability files from a short software application description. Use for top-down product specification before L3, L2, or L1 decomposition. Do not use this skill to document code or create lower layers.
---

# Create SpecSpec L4

Create a clear SpecSpec L4 design from a short application description. Write the files after the
user answers your questions. Do not return only an outline unless the user asks for one.

## Scope

Create these files in the target SpecSpec bundle:

```text
product/
├── index.md
├── overview.md
└── capabilities/
    └── <capability-slug>.md
```

Use the destination that the user supplies. Otherwise, use an existing SpecSpec bundle in the
workspace. If no bundle exists, use `spec/product/`.

Do not create root-bundle files, source code, or files for L3, L2, L1, or L0.

## Workflow

1. Read the application description, any existing L4 files, and `references/l4-concepts.md` from
   this skill.
2. Ask the user clarifying questions before you create or change files.
3. Wait for the user's answers. If the user tells you to continue without answers, record each
   important assumption as `[NEEDS CONFIRMATION]`.
4. Define the Product Overview and the smallest complete set of Capabilities.
5. Write or update the L4 files.
6. Start an independent review agent. Give it the original description, the user's answers, and
   the generated files. Ask it to test completeness, correctness, and clarity.
7. Correct each valid review finding. If you make a material correction, run the independent
   review again.
8. Mark the task as complete only when the review has no unresolved material findings.

If the host has no agent feature, do a separate review pass. State in the final response that the
review was not independent.

## Clarifying questions

Ask only questions that can change the L4 design. Use a short numbered list. Cover these subjects
when the description does not answer them:

- The product name and primary purpose.
- The intended users or user roles.
- The main outcomes that each user needs.
- Important rules, limits, and failure cases.
- Explicit goals and non-goals.
- Measures of success.

Do not start file generation in the same response as the questions. Wait for the user.

## Source and provenance

The user's description and answers are authoritative.

- Set concept-level `provenance: supplied`.
- State supplied facts without an inline marker.
- Mark additions from general domain knowledge as `[inferred]`.
- Mark uncertain or high-impact assumptions as `[NEEDS CONFIRMATION]`.
- Repeat each confirmation item under `# Open questions` in the Product Overview.
- Never use `provenance: observed`.

Use domain knowledge to identify possible users, edge cases, and capabilities. Do not treat general
knowledge as evidence about this product.

Do not invent named integrations, legal duties, security guarantees, implementation choices,
service levels, or numeric targets.

## L4 concept selection

Always create one Product Overview. Create the smallest complete set of Capabilities that covers
the supplied product value.

Read the matching sections in `references/l4-concepts.md` before you create or revise either L4
concept type. Use its selection rules, identifiers, paths, frontmatter, and required sections.

## Navigation

Write `product/index.md` without frontmatter. Link to the overview and every capability.

```markdown
# Product

* [Product overview](overview.md) - <short description>.

## Capabilities

* [<Capability>](capabilities/<slug>.md) - <short description>.
```

## Existing files

When you revise existing L4 files:

- Preserve stable `spec_id` values.
- Preserve supplied content unless the user asks for a change.
- Mark a conflict with supplied content as `[NEEDS CONFIRMATION]`.
- Change the capability set only when the new information changes the product boundary.

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

Ask the review agent to report findings with a severity, file path, and reason. The review agent
must test these areas:

- Completeness: The files cover every supplied user, outcome, rule, constraint, and non-goal.
- Correctness: The files do not contradict the input. Inferred content has the correct marker.
- Testability: Each supplied rule has an acceptance criterion with an observable result.
- Structure: The files have the required sections, identifiers, filenames, and reciprocal L4
  links.
- Scope: The files contain no L3-or-lower objects, links, source paths, anchors, hashes, or
  `source_ref` values.
- Clarity: Each capability expresses one user outcome. The prose follows the writing rules.

The review agent must not edit files. It must return findings to the creating agent.

## Final checks

After the review passes, verify these conditions:

- The Product Overview and `product/index.md` list every capability once.
- Every capability links to `../overview.md`.
- All relative links resolve.
- No claim uses `observed` provenance.
- Each model-added claim has `[inferred]` or `[NEEDS CONFIRMATION]`.
- Capability IDs and filenames use the same unique slug.
- No material review finding remains open.

Report the files that you changed. List all `[NEEDS CONFIRMATION]` items. State that the review
passed and whether it was independent.
