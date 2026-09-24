---
type: "Capability"
title: "Track equipment use"
description: "A custodian records pickup and return and inspects use history."
spec_id: "CAP-track-equipment-use"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] A custodian records pickup and return and inspects use history. The intent is inferred from the implemented action.

# Behavior

- Pickup creates one use record for a confirmed reservation. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.
- Return requires an existing pickup, a later time, and no previous return. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.
- Use history keeps pickup and return records linked to equipment. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:1`.

# Acceptance

- Given a confirmed reservation with no pickup, when a custodian records pickup, then one use record is created. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`. Execution status: see bundle record.
- Given an unreturned use record and a later return time, when a custodian records return, then that record gains a return time. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:12`. Execution status: see bundle record.
- Given an equipment item with reservation and use records, when a custodian requests history, then the result contains both kinds of record. Source: `equipment_reservation/equipment_handoff/equipment_use_management.py:1`. Execution status: see bundle record.

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
- Source: [equipment_reservation/equipment_handoff/equipment_use_management.py](../../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md) at `equipment_reservation/equipment_handoff/equipment_use_management.py:12`.
