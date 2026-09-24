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

- A custodian adds named equipment. Source: `app/programs/EQCAT00.cbl:21`.
- Maintenance blocks its period and invalidates overlapping confirmed reservations. Source: `app/programs/EQSCH00.cbl:3`.
- A custodian can cancel a reservation only after maintenance invalidated it. Source: `app/programs/EQSCH00.cbl:32`.
- Maintenance makes an equipment item unavailable during its period. Source: `app/programs/EQSCH00.cbl:3`.
- Maintenance invalidates an overlapping confirmed reservation even after pickup. Source: `app/programs/EQSCH00.cbl:53`.
- Cancelled and completed reservations keep their state when later maintenance is recorded. Source: `app/programs/EQSCH00.cbl:53`.

# Acceptance

- Given a custodian enters a nonblank name, when that custodian adds equipment, then a new equipment ID is returned. Source: `app/programs/EQCAT00.cbl:21`. Execution status: see bundle record.
- Given maintenance overlaps a confirmed reservation, when a custodian records the period, then the reservation becomes invalid. Source: `app/programs/EQSCH00.cbl:3`. Execution status: see bundle record.
- Given maintenance invalidated a reservation, when a custodian cancels it, then the reservation becomes cancelled. Source: `app/programs/EQSCH00.cbl:32`. Execution status: see bundle record.
- Given a reservation is already cancelled or completed, when later maintenance overlaps it, then its state stays unchanged. Source: `app/programs/EQSCH00.cbl:53`. Execution status: see bundle record.

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
- Source: [app/programs/EQSCH00.cbl](../../files/app/programs/EQSCH00.cbl.md) at `app/programs/EQSCH00.cbl:3`.
- [Cancel invalid reservation](../../system/workflows/cancel-invalid-reservation.md).
