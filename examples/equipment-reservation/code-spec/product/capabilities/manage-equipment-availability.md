---
type: "Capability"
title: "Manage equipment availability"
description: "A custodian adds equipment, records maintenance, and cancels invalid reservations."
spec_id: "CAP-manage-equipment-availability"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] A custodian adds equipment, records maintenance, and cancels invalid reservations. The intent is inferred from the implemented action.

# Behavior

- A custodian adds named equipment. Source: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`.
- Maintenance blocks its period and invalidates overlapping confirmed reservations. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.
- A custodian can cancel a reservation only after maintenance invalidated it. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- Maintenance makes an equipment item unavailable during its period. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`.
- Maintenance invalidates an overlapping confirmed reservation even after pickup. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.
- Cancelled and completed reservations keep their state when later maintenance is recorded. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`.

# Acceptance

- Given a custodian enters a nonblank name, when that custodian adds equipment, then a new equipment ID is returned. Source: `equipment_reservation/equipment_scheduling/equipment_catalog.py:29`. Execution status: see bundle record.
- Given maintenance overlaps a confirmed reservation, when a custodian records the period, then the reservation becomes invalid. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:12`. Execution status: see bundle record.
- Given maintenance invalidated a reservation, when a custodian cancels it, then the reservation becomes cancelled. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`. Execution status: see bundle record.
- Given a reservation is already cancelled or completed, when later maintenance overlaps it, then its state stays unchanged. Source: `equipment_reservation/equipment_scheduling/schedule_management.py:13`. Execution status: see bundle record.

# Realized by

- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Manage Maintenance](../../system/workflows/manage-maintenance.md).
- [Maintenance Period](../../system/data/maintenance-period.md).
- [Equipment](../../system/data/equipment.md).
- [Cancel invalid reservation](../../system/workflows/cancel-invalid-reservation.md).

# Related

- [Product Overview](../overview.md).

# Evidence

- [Custodian Equipment](../../system/interfaces/custodian-equipment.md).
- [Manage Maintenance](../../system/workflows/manage-maintenance.md).
- [Maintenance Period](../../system/data/maintenance-period.md).
- [Equipment](../../system/data/equipment.md).
- Source: [equipment_reservation/equipment_scheduling/schedule_management.py](../../files/equipment_reservation/equipment_scheduling/schedule_management.py.md) at `equipment_reservation/equipment_scheduling/schedule_management.py:12`.
- [Cancel invalid reservation](../../system/workflows/cancel-invalid-reservation.md).
