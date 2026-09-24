---
type: "Capability"
title: "View reservations"
description: "An employee sees owned reservations."
spec_id: "CAP-view-reservations"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] An employee sees owned reservations. The intent is inferred from the implemented action.

# Behavior

- An employee requests only that actor's reservations. Source: `app/programs/EQSCH00.cbl:34`.
- The returned records retain their current reservation state. Source: `app/programs/EQSCH00.cbl:53`.
- The result is empty when the employee has no reservations. Source: `app/programs/EQSCH00.cbl:34`.
- A missing or unauthorized actor receives no reservation data. Source: `app/programs/EQACT00.cbl:3`.

# Acceptance

- Given an employee has reservations, when that employee requests MINE, then only that actor's records are returned. Source: `app/programs/EQSCH00.cbl:34`. Execution status: see bundle record.
- Given an employee has no reservations, when that employee requests MINE, then the result is empty. Source: `app/programs/EQSCH00.cbl:53`. Execution status: see bundle record.
- Given no actor context or a disallowed role, when a person requests reservations, then no reservation data is returned. Source: `app/programs/EQSCH00.cbl:51`. Execution status: see bundle record.

# Realized by

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Reservation](../../system/data/reservation.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Reservation](../../system/data/reservation.md).
- Source: [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) at `app/programs/EQSCH00.cbl:34`.
