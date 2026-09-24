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

[inferred] An employee seeks owned reservation details. `MyReservations` selects the records, but the browser message shows only their count.

# Behavior

- `MyReservations` selects records for the actor. Source: `app/programs/EQSHED.PRG:189`.
- The browser sends the collection to `HtmlResult`, which prints only `Items: <count>`. Source: `app/programs/EQWEB.PRG:119`.

# Acceptance

- Given owned reservations, when the employee requests MINE through the browser, then the message shows only the item count. Source: `app/programs/EQWEB.PRG:119`. Display of reservation details is a gap.

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
- Source: [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) at `app/programs/EQSHED.PRG:192`.
