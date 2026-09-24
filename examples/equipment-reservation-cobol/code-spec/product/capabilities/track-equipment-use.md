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

- Pickup creates one use record for a confirmed reservation. Source: `app/programs/EQHND00.cbl:3`.
- Return requires an existing pickup, a later time, and no previous return. Source: `app/programs/EQHND00.cbl:3`.
- Use history keeps pickup and return records linked to equipment. Source: `app/programs/EQHND00.cbl:3`.

# Acceptance

- Given a confirmed reservation with no pickup, when a custodian records pickup, then one use record is created. Source: `app/programs/EQHND00.cbl:3`. Execution status: see bundle record.
- Given an unreturned use record and a later return time, when a custodian records return, then that record gains a return time. Source: `app/programs/EQHND00.cbl:3`. Execution status: see bundle record.
- Given reservation and use records, when a custodian requests browser HISTORY, then the response includes reservation IDs, states, and use IDs. It omits pickup and return times. Source: `app/programs/EQWEB00.cbl:235`. Target execution was unavailable.

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
- Source: [app/programs/EQHND00.cbl](../../files/app/programs/EQHND00.cbl.md) at `app/programs/EQHND00.cbl:3`.
