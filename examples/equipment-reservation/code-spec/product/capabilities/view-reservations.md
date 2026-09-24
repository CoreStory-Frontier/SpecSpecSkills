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

- An employee requests only that actor's reservations. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:73`.
- The returned records retain their current reservation state. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- The result is empty when the employee has no reservations. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- A missing or unauthorized actor receives no reservation data. Source: `equipment_reservation/web_access/actor_access.py:17`.

# Acceptance

- Given an employee has reservations, when that employee requests MINE, then only that actor's records are returned. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:73`. Execution status: see bundle record.
- Given an employee has no reservations, when that employee requests MINE, then the result is empty. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`. Execution status: see bundle record.
- Given no actor context or a disallowed role, when a person requests reservations, then no reservation data is returned. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`. Execution status: see bundle record.

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
- Source: [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md) at `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
