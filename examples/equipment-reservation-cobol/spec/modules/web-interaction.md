---
type: Module
title: Web Interaction
description: Browser interaction for employee and custodian equipment actions.
spec_id: MOD-web-interaction
layer: L1
provenance: supplied
generator: agent
---

# Purpose

Web Interaction is the browser-facing Module in Web Access. `[inferred]` It coordinates protected
requests and delegates application work after Actor Access permits an action.

# Responsibilities

- `[inferred]` Expose employee browser interactions for search, reservation, and own-reservation
  views.
- `[inferred]` Expose custodian browser interactions for equipment, maintenance, cancellation,
  pickup, return, and history.
- `[inferred]` Ask Actor Access for actor context and an access decision before a protected action.
- `[inferred]` Delegate scheduling actions to Scheduling Operations.
- `[inferred]` Delegate pickup, return, and history actions to Equipment Use Management.
- `[inferred]` Return application results through the browser boundary.
- `[inferred]` It does not own access policy or domain data.

# Public surface

| Planned contract | Owner | Consumer | Purpose |
|---|---|---|---|
| `[inferred]` Employee browser interaction | Web Interaction | Employee browser interaction | Accept employee actions and return results. |
| `[inferred]` Custodian browser interaction | Web Interaction | Custodian browser interaction | Accept custodian actions and return results. |

# Internal structure

- `[inferred]` Employee interaction behavior coordinates employee requests and results.
- `[inferred]` Custodian interaction behavior coordinates custodian requests and results.
- `[inferred]` Result behavior converts application results for the browser boundary.

# Dependencies

- `[inferred]` Uses [Actor Access](actor-access.md) for actor context and access decisions.
- `[inferred]` Uses [Scheduling Operations](scheduling-operations.md) for scheduling actions.
- `[inferred]` Uses [Equipment Use Management](equipment-use-management.md) for handoff actions.
- `[inferred]` No Module uses Web Interaction.

# Files

_L0 source-file documentation is outside this design scope._

# Related

- [Web Access](../components/web-access.md)

# Decomposition

_L1 is the terminal layer of this design bundle._

# Evidence

_L0 evidence is outside this design scope._
