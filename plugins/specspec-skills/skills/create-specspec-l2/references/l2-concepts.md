# L2 concept reference

Use this reference only with the `create-specspec-l2` skill.

## Common frontmatter

Each L2 concept uses these fields:

```yaml
---
type: Component
title: <clear component name>
description: <one-sentence component role>
spec_id: CMP-<component-slug>
layer: L2
provenance: supplied
generator: agent
---
```

Do not add `source_ref`, Git fields, source paths, code anchors, or L1 and L0 metadata.

## Stable IDs and paths

| Type | ID | Path |
|---|---|---|
| Component | `CMP-<slug>` | `components/<slug>.md` |

Use a unique lowercase kebab-case slug. Preserve an existing `spec_id` when the Component keeps
the same identity.

## Component

A Component is a coherent architectural subsystem. It has a clear role and groups related L1
Modules during later decomposition. Examples include an application service, background worker,
command-line application, or data-access subsystem.

Component names describe architectural roles. Do not use a Capability, Workflow, user action,
screen, endpoint, Data Entity, table, or external system as a Component boundary by default.

### Boundary selection

Keep responsibilities in one Component when they share one role, lifecycle, and change boundary.
Consider separate Components when the L3 design or the user requires different:

- Runtime or deployment units.
- Scaling, availability, isolation, or security boundaries.
- Process lifecycles or execution models.
- Data ownership.
- Responsibility and change boundaries.

Do not split a system only because presentation, business logic, and storage are common technical
layers. Do not combine unrelated responsibilities only to reduce the Component count.

A small application can have one Component. Record this only when one boundary covers all L3
responsibilities without a false unifying purpose.

### Required sections

#### `# Purpose`

State the Component's role in one to three sentences. Describe the architectural outcome, not a
list of files or future Modules.

#### `# Responsibilities`

List what the Component owns. State important exclusions. Each listed responsibility must trace
to an L3 concept or have a provenance marker.

For a Data Entity, name the primary owning Component. If ownership is shared, state the supplied
rule and each owner's part.

#### `# Interfaces`

Link to each L3 Interface that the Component exposes or uses. State the direction for each link.
Write `None supplied.` when no L3 Interface applies.

Do not invent endpoints, methods, protocols, events, or message formats.

#### `# Dependencies`

List internal Components that this Component uses. Link to each internal Component and state the
dependency direction. List supplied external systems, platforms, libraries, or managed services
separately.

Do not convert an external system into an internal Component. Do not invent vendor products or
libraries. Write `None supplied.` when no dependency is known.

#### `# Modules`

Write `_To be populated during L1 decomposition._`. Do not propose Module names in this skill.

#### `# Runtime notes`

State supplied process, lifecycle, concurrency, scaling, and state behavior. Mark model-derived
runtime design as `[inferred]`. Write `None supplied.` when no runtime detail is known.

Do not describe deployed infrastructure as current fact.

#### `# Related`

Link to every L3 concept that the Component realizes. Include Data Entities, Interfaces,
Decisions, Workflows, Authorization, Deployment, Observability, and the Technical Overview when
they apply.

These are navigation links up to L3. They are not lower-layer evidence.

#### `# Decomposition`

Write `_To be populated during L1 decomposition._`. Add no links.

#### `# Evidence`

Write `_Lower-layer evidence will be added during L1 decomposition._`. Add no links.
