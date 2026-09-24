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

- A custodian adds named equipment. Source: `app/programs/EQCAT.PRG:4`.
- Maintenance blocks its period and invalidates overlapping confirmed reservations. Source: `app/programs/EQSHED.PRG:2`.
- A custodian can cancel a reservation only after maintenance invalidated it. Source: `app/programs/EQSHED.PRG:146`.
- Maintenance makes an equipment item unavailable during its period. Source: `app/programs/EQSHED.PRG:2`.
- Maintenance invalidates an overlapping confirmed reservation even after pickup. Source: `app/programs/EQSHED.PRG:14`.
- Cancelled and completed reservations keep their state when later maintenance is recorded. Source: `app/programs/EQSHED.PRG:14`.
- The browser message formatter exposes status and, for collection results, item count. It does not show row fields. Source: `app/programs/EQWEB.PRG:119`.

# Acceptance

- Given a custodian and valid equipment input, when `AddEquipment` runs, then it creates an equipment record. Source: `app/programs/EQCAT.PRG:4`. Runtime not verified.
- Given overlapping maintenance, when `AddMaintenance` runs, then it marks confirmed reservations invalid. Source: `app/programs/EQSHED.PRG:86`. Runtime not verified.
- Given an invalid reservation with overlapping maintenance, when `CancelInvalid` runs, then its state becomes cancelled. Source: `app/programs/EQSHED.PRG:146`. Runtime not verified.
- Given these operation results, when the browser formats them, then it omits equipment IDs and invalidated reservation IDs. Source: `app/programs/EQWEB.PRG:119`. [NEEDS CONFIRMATION] The user cannot inspect those details in the browser.

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
- Source: [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) at `app/programs/EQSHED.PRG:2`.
- [Cancel invalid reservation](../../system/workflows/cancel-invalid-reservation.md).
