---
type: "Capability"
title: "Find equipment"
description: "An employee sees equipment availability for a requested period."
spec_id: "CAP-find-equipment"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] An employee sees equipment availability for a requested period. The intent is inferred from the implemented action.

# Behavior

- An employee searches a requested time period and receives equipment with availability status. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:45`.
- Maintenance and confirmed reservations make an overlapping period unavailable. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.
- An adjacent period remains available because the comparison uses exclusive end bounds. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:38`.
- Each equipment record has its own identifier. Source: `equipment_reservation/equipment_scheduling/equipment_catalog.py:1`.
- Invalid, cancelled, and completed reservations do not block availability. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.

# Acceptance

- Given a valid period, when an employee searches, then each equipment result states whether it is available. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:45`. Execution status: see bundle record.
- Given maintenance or a confirmed reservation overlaps the period, when an employee searches, then that equipment is unavailable. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`. Execution status: see bundle record.
- Given a new period starts at the end of an earlier one, when an employee searches, then that earlier period does not block it. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:38`. Execution status: see bundle record.
- Given only invalid, cancelled, or completed reservations overlap a period, when an employee searches, then those records do not make the item unavailable. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`. Execution status: see bundle record.

# Realized by

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).
- Source: [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md) at `equipment_reservation/equipment_scheduling/schedule_management.py:1`.
