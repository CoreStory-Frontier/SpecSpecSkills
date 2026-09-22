---
type: Module
title: Equipment Use Management
description: Equipment pickup, return, and use history.
spec_id: MOD-equipment-use-management
layer: L1
provenance: supplied
generator: agent
---

# Purpose

Equipment Use Management owns Equipment Use records in Equipment Handoff. `[inferred]` It owns
pickup, return, and use-history behavior.

# Responsibilities

- `[inferred]` Own Equipment Use records.
- `[inferred]` Validate pickup and return eligibility with scheduling context.
- `[inferred]` Record one pickup for an eligible Reservation.
- `[inferred]` Record return only after pickup.
- Ask Scheduling Operations to complete a confirmed Reservation after return; preserve invalid or cancelled states.
- `[inferred]` Provide Reservation, pickup, and return history for an Equipment item.
- `[inferred]` Produce candidate handoff-history signals.
- `[inferred]` It does not create Reservations or Maintenance Periods.

# Public surface

| Planned contract | Owner | Consumer | Purpose |
|---|---|---|---|
| `[inferred]` Equipment handoff contract | Equipment Use Management | Web Interaction | Record pickup, record return, and provide use history. |

# Internal structure

- `[inferred]` Eligibility behavior checks Reservation and Equipment context before a handoff.
- `[inferred]` Handoff lifecycle behavior records pickup and return.
- `[inferred]` History behavior reads Equipment Use records for an Equipment item.
- `[inferred]` Signal behavior describes candidate handoff-history outcomes.

# Dependencies

- `[inferred]` Uses [Scheduling Operations](scheduling-operations.md) for Equipment and Reservation
  context and for Reservation completion.
- `[inferred]` [Web Interaction](web-interaction.md) uses Equipment Use Management.

# Files

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md)

# Related

- [Equipment Handoff](../components/equipment-handoff.md)

# Decomposition

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md)

# Evidence

- [equipment_reservation/equipment_handoff/equipment_use_management.py](../files/equipment_reservation/equipment_handoff/equipment_use_management.py.md)
