---
name: code2specspec-l3
description: Derive SpecSpec L3 system concepts from an existing codebase. Use for observed data, interfaces, workflows, controls, runtime, and architecture evidence.
---

# Code to SpecSpec L3

Describe the system that the code actually implements. Read
[source evidence](../code2specspec/references/source-evidence.md), the
[behavior audit](../code2specspec/references/behavior-audit.md), and the
[L3 concept reference](../create-specspec-l3/references/l3-concepts.md) for concept types, IDs,
paths, and sections. Its design-stage selection limits and placeholders do not suppress observed
runtime or deployment facts.

## Inputs and work

Require the source root and L0-L2 documents. Inspect code, tests, configuration, schema, and
runtime entry points for each system claim. Existing L4 documents are context, not a prerequisite.

1. Create one `system/technical-overview.md`. Select other L3 concepts only when source evidence
   supports them: Data Entity, Interface, Workflow, Authorization, Decision, Deployment, and
   Observability. Do not infer a deployed environment from a development manifest. A Decision
   needs an actual decision record or supplied rationale; an observed implementation choice alone
   does not establish why it was made. Create separate Workflows for distinct triggers and outcomes,
   including cancellation after maintenance. Do not merge a separate action into a nearby Workflow
   only because it shares a Capability.
2. Write concept documents at the standard paths and `system/index.md`. Describe current
   behavior, failure paths, persisted data, access checks, and runtime topology as evidence allows.
   Include actual entity fields and Interface inputs, outputs, and errors. Follow the entry point
   through dispatch, domain logic, and response formatting before claiming an action is
   user-visible. Check which fields the caller receives, not only which fields the domain function
   returns. An unused function is source evidence, not proof that the user can reach it. Mark purpose and design
   rationale inferred from code. Keep unknown operational facts open.
3. Link every L3 concept to the Components that realize it under `Decomposition` and `Evidence`.
   Add reciprocal Component `Related` links. Link L3 concepts to one another and the Technical
   Overview where applicable. If L4 exists, add supported Capability links under `Related` and
   reciprocal Capability `Realized by` links.

Check that each claim has a credible code or test trail, each protected action has its observed
authorization path, and each link resolves. Report undocumented behavior and evidence gaps.
