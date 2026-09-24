---
type: "Product Overview"
title: "Equipment Reservation"
description: "Code-derived view of the equipment reservation application."
spec_id: "PROD-overview"
layer: "L4"
provenance: "inferred"
generator: "agent"
---

# Summary

[inferred] The source contains scheduling and handoff operations. [inferred] The product aims to let employees find and reserve equipment and custodians manage handoff. The FoxPro browser presents status and counts but omits many result details.

# Users

- Employees and custodians. Evidence: [app/programs/EQACT.PRG](../files/app/programs/EQACT.PRG.md).

# Capabilities

- [Find equipment](capabilities/find-equipment.md): An employee sees equipment availability for a requested period.
- [Reserve equipment](capabilities/reserve-equipment.md): An employee reserves available equipment without an overlapping confirmed booking.
- [View reservations](capabilities/view-reservations.md): An employee sees owned reservations.
- [Manage equipment availability](capabilities/manage-equipment-availability.md): A custodian adds equipment, records maintenance, and cancels invalid reservations.
- [Track equipment use](capabilities/track-equipment-use.md): A custodian records pickup and return and inspects use history.
- [Control employee access](capabilities/control-employee-access.md): The application applies role rules before protected operations.

# Goals

[inferred] Support equipment scheduling and handoff. No independent product brief was supplied for this reverse pass.

# Non-goals

None supplied.

# Success metrics

None supplied.

# Open questions

[NEEDS CONFIRMATION] Confirm product goals, non-goals, and success measures with the product owner.
COBOL and FoxPro behavior has source evidence only; target-runtime tests were not run here.

# Evidence

- [Technical Overview](../system/technical-overview.md).
- [Find equipment](capabilities/find-equipment.md).
- [Reserve equipment](capabilities/reserve-equipment.md).
- [View reservations](capabilities/view-reservations.md).
- [Manage equipment availability](capabilities/manage-equipment-availability.md).
- [Track equipment use](capabilities/track-equipment-use.md).
- [Control employee access](capabilities/control-employee-access.md).
