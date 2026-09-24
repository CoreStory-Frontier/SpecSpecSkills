---
type: "Capability"
title: "Reserve equipment"
description: "An employee reserves available equipment without an overlapping confirmed booking."
spec_id: "CAP-reserve-equipment"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] An employee reserves available equipment without an overlapping confirmed booking. The intent is inferred from the implemented action.

# Behavior

- The system confirms a reservation only when the equipment exists and the period is valid. Source: `app/programs/EQSCH00.cbl:28`.
- An overlapping confirmed reservation or maintenance period rejects a new reservation. Source: `app/programs/EQSCH00.cbl:161`.
- A successful reservation stores the actor, equipment, period, and confirmed state. Source: `app/programs/EQSCH00.cbl:53`.
- A reservation with an end that is not after its start is rejected. Source: `app/programs/EQSCH00.cbl:43`.

# Acceptance

- Given an existing equipment item and a valid free period, when an employee reserves it, then a confirmed reservation is returned. Source: `app/programs/EQSCH00.cbl:28`. Execution status: see bundle record.
- Given an overlapping confirmed reservation or maintenance period, when an employee reserves the same item, then the request is rejected. Source: `app/programs/EQSCH00.cbl:161`. Execution status: see bundle record.
- Given a successful reservation, when its record is read, then the record contains the actor, item, period, and confirmed state. Source: `app/programs/EQSCH00.cbl:53`. Execution status: see bundle record.
- Given the end is not after the start, when an employee requests a reservation, then the request is rejected. Source: `app/programs/EQSCH00.cbl:51`. Execution status: see bundle record.

# Realized by

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Reserve Equipment](../../system/workflows/reserve-equipment.md).
- [Reservation](../../system/data/reservation.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Reserve Equipment](../../system/workflows/reserve-equipment.md).
- [Reservation](../../system/data/reservation.md).
- Source: [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) at `app/programs/EQSCH00.cbl:28`.
