# L4 concept reference

Use this reference only with the `create-specspec-l4` skill.

## Common frontmatter

Each L4 concept uses these fields:

```yaml
---
type: <L4 concept type>
title: <clear title>
description: <one-sentence description>
spec_id: <stable type-specific ID>
layer: L4
provenance: supplied
generator: agent
---
```

Do not add `source_ref`, Git fields, source paths, or code anchors.

## Stable IDs and paths

| Type | ID | Path |
|---|---|---|
| Product Overview | `PROD-overview` | `product/overview.md` |
| Capability | `CAP-<slug>` | `product/capabilities/<slug>.md` |

Use unique lowercase kebab-case slugs for Capabilities.

## Product Overview

Always create one Product Overview. It defines the product boundary and links to every
Capability.

Use these frontmatter values:

- `type: Product Overview`
- `spec_id: PROD-overview`

Required sections:

- `# Summary` — Describe the product and its value in one short paragraph.
- `# Users` — List the user roles. Mark inferred roles.
- `# Capabilities` — Link to every Capability file. Add one short description for each link.
- `# Goals` — State the supplied product outcomes.
- `# Non-goals` — State explicit exclusions. Mark inferred exclusions.
- `# Success metrics` — State supplied measures. Do not invent numeric targets.
- `# Open questions` — List unresolved assumptions. Write `None.` when there are no open
  questions.
- `# Evidence` — Write `_Lower-layer evidence will be added during L3 decomposition._`. Add no
  links.

## Capability

A Capability represents one user-visible outcome. It is not a screen, endpoint, database action,
technical component, or generic create, read, update, and delete operation.

Choose the smallest set that covers the supplied product value. Split a Capability when its user,
outcome, rules, or failure behavior is different. Do not add a Capability only because similar
products have it.

Use these frontmatter values:

- `type: Capability`
- `spec_id: CAP-<capability-slug>`

Required sections:

- `# Purpose` — State the user value in one or two sentences.
- `# Behavior` — Describe the behavior, rules, and important failure cases.
- `# Acceptance` — Write observable Given/When/Then criteria. Cover each supplied rule with at
  least one criterion. The `Then` clause must state a result that a user can observe. Do not use
  a circular result that only repeats the rule. Do not claim that code implements the criteria.
- `# Realized by` — Write `_To be populated during L3 decomposition._`. Add no links.
- `# Related` — Link to `../overview.md`.
- `# Evidence` — Write `_Lower-layer evidence will be added during L3 decomposition._`. Add no
  links.
