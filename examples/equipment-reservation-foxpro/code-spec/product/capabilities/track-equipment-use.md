---
type: "Capability"
title: "Track equipment use"
description: "A custodian records pickup and return; browser history currently omits use records."
spec_id: "CAP-track-equipment-use"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] A custodian records pickup and return. Browser history currently omits use records. The intended history outcome needs confirmation.

# Behavior

- Pickup creates one use record for a confirmed reservation. Source: `app/programs/EQHAND.PRG:2`.
- Return requires an existing pickup, a later time, and no previous return. Source: `app/programs/EQHAND.PRG:2`.
- The browser HISTORY action calls EquipmentHistory, which returns reservation rows. HandoffHistory has use rows but is not on this browser path. Source: `app/programs/EQOPS.PRG:47` and `app/programs/EQHAND.PRG:92`.

# Acceptance

- Given a confirmed reservation, when `Pickup` runs, then it creates a use record. Source: `app/programs/EQHAND.PRG:4`. Runtime not verified.
- Given an unreturned use, when `ReturnEquipment` runs with a later time, then it records return. Source: `app/programs/EQHAND.PRG:48`. Runtime not verified.
- Given browser HISTORY, when the request is dispatched, then it uses `EquipmentHistory` and omits use records. Source: `app/programs/EQOPS.PRG:43`. [NEEDS CONFIRMATION] This does not meet the existing spec's full use-history outcome.

# Realized by

- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Record Equipment Pickup](../../system/workflows/record-equipment-pickup.md).
- [Record Equipment Return](../../system/workflows/record-equipment-return.md).
- [Equipment Use](../../system/data/equipment-use.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Record Equipment Pickup](../../system/workflows/record-equipment-pickup.md).
- [Record Equipment Return](../../system/workflows/record-equipment-return.md).
- [Equipment Use](../../system/data/equipment-use.md).
- Source: [app/programs/EQHAND.PRG](../../files/app/programs/EQHAND.PRG.md) at `app/programs/EQHAND.PRG:2`.
