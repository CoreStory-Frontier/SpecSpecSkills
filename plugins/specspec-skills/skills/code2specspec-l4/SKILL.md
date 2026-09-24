---
name: code2specspec-l4
description: Infer SpecSpec L4 Product Overview and Capabilities from an existing codebase with source-backed behavior and clear uncertainty about product intent.
---

# Code to SpecSpec L4

Describe the user outcomes supported by the existing code. Read
[source evidence](../code2specspec/references/source-evidence.md), the
[behavior audit](../code2specspec/references/behavior-audit.md), and the
[L4 concept reference](../create-specspec-l4/references/l4-concepts.md) for type, ID, path, and
section rules. Replace design-stage lower-layer placeholders with verified L3 links.

## Inputs and work

Require the source root and L0-L3 documents. Read project briefs and user statements if supplied.
Inspect actual interfaces, workflows, test assertions, and accessible behavior before writing.
Use a supplied reference spec only after an independent source-derived pass when comparison is
requested.

1. Create `product/overview.md`, Capability documents at `product/capabilities/<slug>.md`, and
   `product/index.md`. A Capability describes one user-visible outcome, not a technical layer.
2. State only behavior supported by code, tests, or supplied product material. For each Behavior
   and Given/When/Then Acceptance statement, cite the L3 path and underlying source or test.
   Mark product purpose inferred from code `[inferred]`. Mark proposed or unverified acceptance
   criteria `[NEEDS CONFIRMATION]`; do not present them as implemented behavior. Make the `Then`
   result observable and specific. Cover success, rejection, access, ownership, and state changes
   shown by the source. A generic statement that an action "returns a result" is insufficient.
   Verify that the user-facing entry path reaches the behavior and presents the claimed result.
   A function that computes a result does not prove the user can see it. An unused function does
   not prove a Capability. State test execution separately from source inspection.
3. Under `Realized by` and `Evidence`, link each Capability to supporting L3 concepts. Add
   reciprocal L3 `Related` links. Link the Product Overview to all Capabilities and their
   lower-layer evidence. Keep non-goals, success metrics, and user roles explicit only when
   evidence supports them; otherwise say `None supplied.` or record an open question.

Check every claimed outcome against the entry-to-output path and relevant test assertion. For a
supplied spec, audit each criterion against code and record partial, missing, or contradicted
outcomes in the gap report. Report product intent that code cannot establish and any user-visible
behavior that lacks an acceptance statement. Do not add a desired but unimplemented outcome as
observed behavior to make the concept counts match a reference spec.
