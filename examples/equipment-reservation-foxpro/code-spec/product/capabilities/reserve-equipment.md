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

[inferred] An employee seeks a confirmed reservation. The domain result has a reservation ID, but the browser message does not show it.

# Behavior

- `Reserve` creates a confirmed reservation and returns `rsv_id` in its result object. Source: `app/programs/EQSHED.PRG:33`.
- `HtmlResult` omits `rsv_id` and shows status and message. Source: `app/programs/EQWEB.PRG:119`.

# Acceptance

- Given a successful reserve action, when the browser formats the result, then it shows success without the reservation ID. Source: `app/programs/EQWEB.PRG:119`. The missing ID is recorded as a gap.

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
- Source: [app/programs/EQSHED.PRG](../../files/app/programs/EQSHED.PRG.md) at `app/programs/EQSHED.PRG:33`.
