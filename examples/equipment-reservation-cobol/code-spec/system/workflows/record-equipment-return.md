---
type: "Workflow"
title: "Record Equipment Return"
description: "A custodian records return and completes an eligible reservation."
spec_id: "WF-record-equipment-return"
layer: "L3"
provenance: "observed"
generator: "agent"
---

# Purpose

A custodian records return and completes an eligible reservation.

# Steps

1. A user submits the action through [the interface](../../files/app/programs/EQWEB00.cbl.md).
2. The application checks actor access through [actor access](../../files/app/programs/EQACT00.cbl.md).
3. The domain logic handles the action through [app/programs/EQHND00.cbl](../../files/app/programs/EQHND00.cbl.md) and returns a result.

# Outcomes

- The source returns a success or rejection result. Evidence: `app/programs/EQHND00.cbl:1`.

# Related

- [Track equipment use](../../product/capabilities/track-equipment-use.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [app/programs/EQHND00.cbl](../../files/app/programs/EQHND00.cbl.md); source `app/programs/EQHND00.cbl:1`.
