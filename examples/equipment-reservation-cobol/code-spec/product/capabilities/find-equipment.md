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

- An employee searches a requested time period and receives equipment with availability status. Source: `app/programs/EQSCH00.cbl:22`.
- Maintenance and confirmed reservations make an overlapping period unavailable. Source: `app/programs/EQSCH00.cbl:3`.
- An adjacent period remains available because the comparison uses exclusive end bounds. Source: `app/programs/EQSCH00.cbl:55`.
- Each equipment record has its own identifier. Source: `app/programs/EQCAT00.cbl:3`.
- Invalid, cancelled, and completed reservations do not block availability. Source: `app/programs/EQSCH00.cbl:53`.

# Acceptance

- Given a valid period, when an employee searches, then each equipment result states whether it is available. Source: `app/programs/EQSCH00.cbl:22`. Execution status: see bundle record.
- Given maintenance or a confirmed reservation overlaps the period, when an employee searches, then that equipment is unavailable. Source: `app/programs/EQSCH00.cbl:3`. Execution status: see bundle record.
- Given a new period starts at the end of an earlier one, when an employee searches, then that earlier period does not block it. Source: `app/programs/EQSCH00.cbl:55`. Execution status: see bundle record.
- Given only invalid, cancelled, or completed reservations overlap a period, when an employee searches, then those records do not make the item unavailable. Source: `app/programs/EQSCH00.cbl:51`. Execution status: see bundle record.

# Realized by

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Employee Equipment](../../system/interfaces/employee-equipment.md).
- [Equipment](../../system/data/equipment.md).
- Source: [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) at `app/programs/EQSCH00.cbl:1`.
