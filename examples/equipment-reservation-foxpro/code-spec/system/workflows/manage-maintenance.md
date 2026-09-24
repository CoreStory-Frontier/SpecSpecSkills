---
type: "Workflow"
title: "Manage Maintenance"
description: "A custodian records maintenance and overlaps become invalid."
spec_id: "WF-manage-maintenance"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A custodian records maintenance and overlaps become invalid.

# Steps

1. A user submits the action through [the interface](../../files/app/programs/EQWEB.PRG.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT.PRG.md).
3. The domain logic handles the action through [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQSHED.PRG:1`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md); source `app/programs/EQSHED.PRG:1`.
