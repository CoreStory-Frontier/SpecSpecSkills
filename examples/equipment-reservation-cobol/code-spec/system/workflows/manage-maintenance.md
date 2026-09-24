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

1. A user submits the action through [the interface](../../files/app/programs/EQWEB00.cbl.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT00.cbl.md).
3. The domain logic handles the action through [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQSCH00.cbl:1`.

# Related

- [Manage equipment availability](../../product/capabilities/manage-equipment-availability.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md); source `app/programs/EQSCH00.cbl:1`.
