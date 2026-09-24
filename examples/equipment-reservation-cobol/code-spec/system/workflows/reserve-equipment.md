---
type: "Workflow"
title: "Reserve Equipment"
description: "An employee requests and receives a reservation result."
spec_id: "WF-reserve-equipment"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

An employee requests and receives a reservation result.

# Steps

1. A user submits the action through [the interface](../../files/app/programs/EQWEB00.cbl.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT00.cbl.md).
3. The domain logic handles the action through [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQSCH00.cbl:1`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md); source `app/programs/EQSCH00.cbl:1`.
