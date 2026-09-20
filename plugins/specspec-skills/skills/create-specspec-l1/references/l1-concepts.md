# L1 concept reference

Use this reference only with the `create-specspec-l1` skill.

## Common frontmatter

Each L1 concept uses these fields:

```yaml
---
type: Module
title: <clear module name>
description: <one-sentence module purpose>
spec_id: MOD-<module-slug>
layer: L1
provenance: supplied
generator: agent
---
```

Do not add `source_ref`, Git fields, source paths, code anchors, or L0 metadata.

## Stable IDs and paths

| Type | ID | Path |
|---|---|---|
| Module | `MOD-<slug>` | `modules/<slug>.md` |

Use a unique lowercase kebab-case slug. Preserve an existing `spec_id` when the Module keeps the
same identity.

## Module

A Module is a cohesive package or directory responsibility inside a Component. It defines a
stable responsibility boundary for later implementation.

Module names describe technical responsibilities. Do not use a file, function, class, endpoint,
database table, screen, user action, or external system as a Module boundary by default.

### Boundary selection

Keep responsibilities in one Module when they share one purpose, public contract, and change
boundary. Consider separate Modules when the L2 design or the user requires different:

- Responsibility or data ownership.
- Public contracts or consumers.
- Dependency direction.
- Security or isolation rules within a Component.
- Packaging or framework boundaries.

Avoid low-cohesion Modules. If a proposed purpose needs an unrelated "and" list, split the Module
or mark the boundary `[NEEDS CONFIRMATION]`.

Do not create a generic shared Module without a specific owned contract. Shared behavior and data
types must have a named owner.

### Required sections

#### `# Purpose`

State the Module's role in one to three sentences. Describe one responsibility boundary. Do not
list planned files.

#### `# Responsibilities`

List what the Module owns and what it explicitly does not own. Each responsibility must trace to
a Component or linked L3 concept, or it must have a provenance marker.

#### `# Public surface`

Describe the planned operations, data shapes, or events that other Modules use. Name the consumer
and the contract owner. Use conceptual names unless the user supplies exact implementation names.

Write `None.` only for a leaf Module that no other Module uses. Do not invent code symbols,
signatures, endpoints, protocols, or file paths.

#### `# Internal structure`

Describe internal responsibility groups and their relationships. Do not propose source files,
classes, functions, or directory trees.

Write `Not specified at L1.` when more detail would require L0 design.

#### `# Dependencies`

List the Modules that this Module uses. Link to each Module and state why it uses it. Also list
Modules that use this Module when they are known.

Do not duplicate a Component dependency as a Module dependency unless a specific Module owns the
interaction. Write `None.` when the Module has no Module dependency.

#### `# Files`

Write `_L0 source-file documentation is outside this design scope._`. Add no links or filenames.

#### `# Related`

Link to every Component that contains this Module. These are navigation links up to L2.

#### `# Decomposition`

Write `_L1 is the terminal layer of this design bundle._`. Add no links.

#### `# Evidence`

Write `_L0 evidence is outside this design scope._`. Add no links, anchors, or source claims.
