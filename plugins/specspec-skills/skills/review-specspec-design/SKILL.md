---
name: review-specspec-design
description: Review a complete top-down SpecSpec L4-L1 design for architectural gaps, contradictions, weak boundaries, and broken traceability. Use after generation or before implementation. This skill reports findings and does not edit documents.
---

# Review SpecSpec Design

Review the complete SpecSpec design as a software architect. Find structural errors and semantic
gaps. Report the findings. Do not edit the design.

## Inputs and scope

Require a SpecSpec bundle that contains these directories:

```text
product/
system/
components/
modules/
```

Read all Markdown files in these directories. Include index files in the review. When available,
also accept a source packet with the original description, user answers, and confirmed decisions.
Use it to verify L4 completeness and provenance.

Before the review starts, read these files:

- `references/architecture-review-checklist.md` from this skill.
- `../create-specspec-l4/references/l4-concepts.md`.
- `../create-specspec-l3/references/l3-concepts.md`.
- `../create-specspec-l2/references/l2-concepts.md`.
- `../create-specspec-l1/references/l1-concepts.md`.

Review L4 through L1. Do not require L0 documents or source code. Do not assess whether code
implements the design.

## Workflow

1. Identify the bundle root and inventory all L4-L1 documents.
2. Read all documents before you report a finding.
3. Run the bundled ontology validator. Resolve the plugin root by moving two directories up from
   this skill directory. Run:

   ```shell
   python3 <plugin-root>/scripts/validate_specspec_design.py <bundle-root>
   ```

4. Apply every check in `references/architecture-review-checklist.md`. Use the layer concept
   references for stable type, ID, path, frontmatter, concept selection, and required-section
   rules. Do not apply their temporary planning-placeholder rules to a completed bundle.
5. Trace each L4 capability through L3, L2, and L1.
6. Trace each L1 Module back to a justified L4 capability.
7. Write one finding for each distinct problem.
8. Return the review report. Do not create or change specification files.

If a required layer is missing, report one finding for the missing layer. Then review the layers
that exist. If the validator cannot run, record the reason and continue with the manual review.
If no source packet is available, state that the review cannot verify input completeness or L4
provenance. Do not claim that these areas passed.

## Review rules

- Use supplied product intent as the authority.
- Do not invent a preferred architecture and report its absence as an error.
- Report a missing decision when the design needs a choice but does not contain one.
- Cite the exact file and section for each claim.
- Distinguish an architecture error from a writing improvement.
- Combine duplicate evidence into one finding.
- Report broken links and malformed documents even if the validator also reports them.
- Treat `[NEEDS CONFIRMATION]` as an open decision, not as a confirmed fact.
- Do not accept an `[inferred]` statement as evidence of supplied product intent.
- Do not request L0 content. L1 is the terminal layer for this design bundle.

## Severity

Use these severities:

- `Critical`: The design is unsafe, impossible to implement, or internally contradictory.
- `High`: A major user outcome, control, ownership rule, or layer boundary is missing or wrong.
- `Medium`: Traceability, contract detail, failure behavior, or responsibility coverage is
  incomplete.
- `Low`: The design is usable, but a local ambiguity or clarity defect remains.

Do not increase severity only because a finding affects many files. Use the architectural effect.

## Finding format

Give each finding a stable ID, such as `SSR-001`. For the first review, assign IDs in report order.
For a later review, accept the prior report as an input. Keep an ID when the category, location,
and defect are the same. Give new findings new monotonic IDs. Do not reuse a closed ID for a
different defect. Use this format:

```markdown
## SSR-001 — <short title>

- Severity: <Critical | High | Medium | Low>
- Category: <category>
- Location: `<path>` — `<section>`
- Related locations: <paths and sections, or `None`>
- Evidence: <what the documents state or omit>
- Impact: <why this matters to the architecture>
- Correction criteria: <observable conditions for closure>
- User decision required: <Yes | No>
- Owning layer: <L4 | L3 | L2 | L1 | Cross-layer>
```

Use one of these categories: `Structure`, `Traceability`, `Completeness`, `Consistency`,
`Boundary`, `Ownership`, `Interface`, `Data`, `Workflow`, `Authorization`, `Runtime`,
`Dependency`, `Provenance`, or `Clarity`.

## Report format

Return one report with these sections:

```markdown
# SpecSpec Architecture Review

## Summary
<counts by severity and one short assessment>

## Findings
<findings in severity order, then document order>

## Open confirmations
<all unresolved [NEEDS CONFIRMATION] items, without duplication>

## Validator result
<command result or reason it did not run>

## Verdict
<PASS or FAIL, with one sentence>
```

Use `FAIL` when one or more Critical, High, or Medium findings remain. Use `PASS` when no material
finding remains. Low findings can remain with a `PASS`, but list them.

When there are no findings, write `No findings.` under `## Findings`. Do not invent a finding to
make the report appear useful.

## Writing rules

Use ASD-STE100 principles.

- Use simple words and active voice.
- Use one main idea in each sentence.
- Keep sentences short. Use 20 words or fewer when practical.
- Use the same term for the same concept.
- State evidence before interpretation.
- Do not use vague modifiers or praise.

## Completion

Before completion, verify these conditions:

- Every file was read.
- Every capability has a complete L4-to-L1 path or a finding.
- Every Module has a valid path back to L4 or a finding.
- Every checklist area has a result.
- Each finding has evidence and correction criteria.
- The review did not change any design file.
