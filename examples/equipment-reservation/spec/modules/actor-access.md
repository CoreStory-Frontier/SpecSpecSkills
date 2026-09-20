---
type: Module
title: Actor Access
description: Actor context and equipment access checks.
spec_id: MOD-actor-access
layer: L1
provenance: supplied
generator: agent
---

# Purpose

Actor Access is the access-control Module in Web Access. `[inferred]` It obtains external actor
context and evaluates the Equipment Access policy.

# Responsibilities

- `[inferred]` Obtain actor identity and roles from the external workforce identity source.
- `[inferred]` Evaluate employee and custodian access before protected actions.
- `[inferred]` Enforce the rule that employees can view only their own Reservations.
- `[inferred]` Support users who have both employee and custodian roles.
- `[inferred]` Return a denied result when actor context is absent or the policy denies access.
- `[inferred]` It does not manage employee identities or validate scheduling rules.

# Public surface

| Planned contract | Owner | Consumer | Purpose |
|---|---|---|---|
| `[inferred]` Actor context contract | Actor Access | Web Interaction | Supply actor identity and assigned roles. |
| `[inferred]` Equipment access decision | Actor Access | Web Interaction | Permit or deny one protected action. |

# Internal structure

- `[inferred]` Actor-context behavior isolates the workforce identity interaction.
- `[inferred]` Policy behavior evaluates roles, resources, actions, and ownership conditions.

# Dependencies

- Module dependencies: None.
- `[inferred]` [Web Interaction](web-interaction.md) uses Actor Access.
- The workforce identity source is an external dependency.

# Files

_L0 source-file documentation is outside this design scope._

# Related

- [Web Access](../components/web-access.md)

# Decomposition

_L1 is the terminal layer of this design bundle._

# Evidence

_L0 evidence is outside this design scope._
