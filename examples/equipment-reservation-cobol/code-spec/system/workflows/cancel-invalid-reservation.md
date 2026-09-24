---
type: Workflow
title: Cancel invalid reservation
description: A custodian cancels a reservation invalidated by maintenance.
spec_id: WF-cancel-invalid-reservation
layer: L3
provenance: observed
generator: agent
---

# Purpose

A custodian cancels an invalid reservation only when maintenance overlaps it.

# Steps

1. The custodian submits a cancel action through [the interface](../../files/app/programs/EQWEB00.cbl.md).
2. The application checks the custodian role through [actor access](../../files/app/programs/EQACT00.cbl.md).
3. [Schedule Management](../../files/app/programs/EQSCH00.cbl.md) checks the reservation state and maintenance overlap.
4. The system changes a qualifying reservation to cancelled or returns an error.

# Outcomes

- A qualifying reservation becomes cancelled. Other states are preserved. Source: `app/programs/EQSCH00.cbl:32`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) at `app/programs/EQSCH00.cbl:32`.
