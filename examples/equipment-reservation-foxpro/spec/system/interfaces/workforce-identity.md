---
type: Interface
title: Workforce Identity Interface
description: External workforce identity and role context for equipment actions.
spec_id: IFC-workforce-identity
layer: L3
provenance: supplied
generator: agent
---

# Purpose

The Workforce Identity Interface supplies actor identity and employee or custodian roles. The
Equipment Reservation product does not manage employee identities.

# Contract

| Operation | Input | Output | Outcome |
|---|---|---|---|
| `[inferred]` Get actor context | Current browser interaction context | Actor identity and roles | Supplies the context used for an access decision. |

# Schema

| Shape | Fields |
|---|---|
| Actor context | `[inferred]` External actor identity and a set of employee or custodian roles. |

# Errors

- `[inferred]` When actor context is unavailable, the product does not perform a protected action.
- `[inferred]` When no assigned role permits an action, the product does not perform the action.

# Guarantees

- The external source, not Equipment Reservation, manages employee identities.
- A user can have both employee and custodian roles.
- The interface does not select an identity provider, token format, or authentication method.

# Examples

| Scenario | Result |
|---|---|
| `[inferred]` The external source supplies both roles for one actor. | Access checks consider both role assignments. |

# Related

- [Control employee access](../../product/capabilities/control-employee-access.md)

# Decomposition

- [Web Access](../../components/web-access.md)

# Evidence

- [Web Access](../../components/web-access.md)
