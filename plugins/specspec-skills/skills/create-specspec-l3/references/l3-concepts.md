# L3 concept reference

Use this reference only with the `create-specspec-l3` skill.

## Common frontmatter

Each L3 concept uses these fields:

```yaml
---
type: <L3 concept type>
title: <clear title>
description: <one-sentence description>
spec_id: <stable type-specific ID>
layer: L3
provenance: supplied
generator: agent
---
```

Do not add `source_ref`, Git fields, source paths, or code anchors.

## Stable IDs and paths

| Type | ID | Path |
|---|---|---|
| Data Entity | `ENT-<slug>` | `system/data/<slug>.md` |
| Interface | `IFC-<slug>` | `system/interfaces/<slug>.md` |
| Decision | `ADR-NNNN` | `system/decisions/NNNN-<slug>.md` |
| Workflow | `WF-<slug>` | `system/workflows/<slug>.md` |
| Authorization | `AUTHZ-<slug>` | `system/authorization/<slug>.md` |
| Deployment | `DEPLOY-<slug>` | `system/deployment/<slug>.md` |
| Observability | `OBS-<slug>` | `system/observability/<slug>.md` |
| Technical Overview | `TECH-overview` | `system/technical-overview.md` |

Use lowercase kebab-case slugs. Start ADR numbers at `0001`. Do not reuse an ADR number.

## Data Entity

Create a Data Entity for a persistent business object with an identity and lifecycle. Do not create
one for a request payload, display model, report, or temporary calculation.

Required sections:

- `# Purpose`
- `# Schema` — Use a field table. Mark inferred fields.
- `# Relationships`
- `# Lifecycle`
- `# Invariants`
- `# Related`
- `# Decomposition`
- `# Evidence`

Do not invent storage technology, database types, indexes, or field lengths.

## Interface

Create an Interface for a system boundary used by a user or external system. Group related
operations into one stable contract surface.

Required sections:

- `# Purpose`
- `# Contract` — List operations, inputs, outputs, and outcomes.
- `# Schema`
- `# Errors`
- `# Guarantees`
- `# Examples`
- `# Related`
- `# Decomposition`
- `# Evidence`

Use protocol-neutral operations unless the user selects a protocol. Do not invent HTTP methods,
URLs, message topics, or vendor products.

## Decision

Create a Decision only for a significant technical choice that the user made or accepted. Do not
create an ADR for an unresolved option.

Add `status: proposed` to the frontmatter.

Required sections:

- `# Status` — Use `proposed` for a design-stage decision.
- `# Context`
- `# Decision`
- `# Consequences`
- `# Related`
- `# Decomposition`
- `# Evidence`

State both benefits and costs. Mark model-suggested consequences as `[inferred]`.

## Workflow

Create a Workflow for an end-to-end user or system sequence. Use one workflow when several
capabilities form one continuous outcome. Split workflows when triggers or outcomes differ.

Required sections:

- `# Purpose`
- `# Steps` — Use an ordered list. Include alternate and failure paths.
- `# Outcomes`
- `# Related`
- `# Decomposition`
- `# Evidence`

Each step must name an actor and an observable action or result. Do not name code components.

Start with the real trigger. Do not assume that validation already succeeded. A step must not make
a later failure path impossible. For example, write "the member requests an item" before the
system checks availability. Do not write "the member requests an available item."

Put a required validation or authorization check before the action that it protects. Do not state
that a user completes the protected action and then describe the check.

Mark model-added interface actions as `[inferred]`. Examples include opening a view, selecting a
control, or starting an operation when the user did not supply that interaction.

Use one primary trigger and one related outcome set per Workflow. Create a separate Workflow when
another actor starts a separate process or seeks a different outcome. Do not combine a transaction
workflow with monitoring or reporting only to reduce the file count.

## Authorization

Create an Authorization concept when roles or policies control more than one operation. Keep a
simple, local access rule in the relevant Interface or Workflow.

Required sections:

- `# Purpose`
- `# Policy` — Use a role, resource, action, and condition table.
- `# Enforcement` — Describe planned enforcement points without naming code.
- `# Guarantees`
- `# Related`
- `# Decomposition`
- `# Evidence`

Do not infer a role hierarchy, identity provider, token format, or authentication method.

Authorization answers who can perform an action. Do not put availability checks, duplicate checks,
state transitions, or other business validation in the policy table. Put those rules in the
relevant Data Entity, Interface, or Workflow.

A supplied access rule does not supply an enforcement response. Mark a proposed denial, block, or
error response as `[inferred]` unless the user specifies that response.

## Deployment

Create a Deployment concept only when the user supplies a runtime, environment, packaging,
availability, or topology requirement.

Required sections:

- `# Purpose`
- `# Topology`
- `# Environments`
- `# Configuration`
- `# Related`
- `# Decomposition`
- `# Evidence`

Do not invent cloud vendors, regions, replica counts, container platforms, or secret systems.

## Observability

Create an Observability concept when the L4 design has success measures or the user supplies
operational monitoring needs.

Required sections:

- `# Purpose`
- `# Signals` — Use a name, kind, dimensions, and meaning table.
- `# Alerts`
- `# Health`
- `# Related`
- `# Decomposition`
- `# Evidence`

You may derive candidate signals from supplied success measures. Mark each candidate `[inferred]`.
Do not invent thresholds, alert channels, retention periods, or service-level objectives.

Write `None supplied.` under `# Alerts` or `# Health` when those requirements are absent.

## Technical Overview

Always create one Technical Overview. It is the entry point to the proposed system design.

Required sections:

- `# Summary`
- `# Context`
- `# Components` — Write `_To be populated during L2 decomposition._`.
- `# Data`
- `# Interfaces`
- `# Workflows`
- `# Cross-cutting concerns`
- `# Key decisions`
- `# Related`
- `# Decomposition`
- `# Evidence`

Link to every applicable L3 concept. Do not invent a technology stack or component boundary.
State every explicit L4 non-goal and boundary exclusion under `# Context` or `# Cross-cutting
concerns`.
