---
type: "Workflow"
title: "Record Equipment Pickup"
description: "A custodian records pickup for a confirmed reservation."
spec_id: "WF-record-equipment-pickup"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A custodian records pickup for a confirmed reservation.

# Steps

1. A user submits the action through [the interface](../../files/app/programs/EQWEB.PRG.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT.PRG.md).
3. The domain logic handles the action through [app/programs/EQHAND.PRG](../../files/app/programs/EQHAND.PRG.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQHAND.PRG:1`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [app/programs/EQHAND.PRG](../../files/app/programs/EQHAND.PRG.md); source `app/programs/EQHAND.PRG:1`.
