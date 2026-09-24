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

- The system confirms a reservation only when the equipment exists and the period is valid. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:65`.
- An overlapping confirmed reservation or maintenance period rejects a new reservation. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:36`.
- A successful reservation stores the actor, equipment, period, and confirmed state. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- A reservation with an end that is not after its start is rejected. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.

# Acceptance

- Given an existing equipment item and a valid free period, when an employee reserves it, then a confirmed reservation is returned. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:65`. Execution status: see bundle record.
- Given an overlapping confirmed reservation or maintenance period, when an employee reserves the same item, then the request is rejected. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:36`. Execution status: see bundle record.
- Given a successful reservation, when its record is read, then the record contains the actor, item, period, and confirmed state. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`. Execution status: see bundle record.
- Given the end is not after the start, when an employee requests a reservation, then the request is rejected. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`. Execution status: see bundle record.

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
- Source: [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md) at `equipment_reservation/equipment_scheduling/schedule_management.py:65`.
