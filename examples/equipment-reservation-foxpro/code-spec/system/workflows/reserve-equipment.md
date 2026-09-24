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

1. A user submits the action through [the interface](../../files/app/programs/EQWEB.PRG.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT.PRG.md).
3. The domain logic handles the action through [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQSHED.PRG:1`.

# Related

- [Reserve equipment](../../product/capabilities/reserve-equipment.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md); source `app/programs/EQSHED.PRG:1`.
