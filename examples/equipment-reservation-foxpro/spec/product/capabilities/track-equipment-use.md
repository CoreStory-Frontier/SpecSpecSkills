---
type: Capability
title: Track Equipment Use
description: Custodians record equipment pickup, return, and use history.
spec_id: CAP-track-equipment-use
layer: L4
provenance: supplied
generator: agent
---

# Purpose

Custodians track each equipment handoff and keep a traceable equipment-use history.

# Behavior

- A custodian records when an employee picks up reserved equipment.
- A custodian records when the employee returns the equipment.
- The product keeps the reservation, pickup, and return history for each equipment item.

# Acceptance

- Given an employee receives reserved equipment, when a custodian records pickup, then the equipment history shows the pickup.
- Given an employee returns equipment, when a custodian records return, then the equipment history shows the return.
- Given an equipment item has a reservation, pickup, and return, when a custodian requests its history, then the history shows all three records for that item.

# Realized by

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Equipment use](../../system/data/equipment-use.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Record equipment pickup workflow](../../system/workflows/record-equipment-pickup.md)
- [Record equipment return workflow](../../system/workflows/record-equipment-return.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)

# Related

- [Product overview](../overview.md)

# Evidence

- [Technical overview](../../system/technical-overview.md)
- [Equipment](../../system/data/equipment.md)
- [Reservation](../../system/data/reservation.md)
- [Equipment use](../../system/data/equipment-use.md)
- [Custodian equipment interface](../../system/interfaces/custodian-equipment.md)
- [Record equipment pickup workflow](../../system/workflows/record-equipment-pickup.md)
- [Record equipment return workflow](../../system/workflows/record-equipment-return.md)
- [Equipment access policy](../../system/authorization/equipment-access.md)
- [Browser interaction decision](../../system/decisions/0001-browser-interaction.md)
- [Modular monolith decision](../../system/decisions/0002-modular-monolith.md)
- [Application runtime](../../system/deployment/application-runtime.md)
- [Equipment operations](../../system/observability/equipment-operations.md)
