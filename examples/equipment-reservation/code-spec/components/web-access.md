---
type: "Component"
title: "Web Access"
description: "Web Access subsystem of the equipment reservation application."
spec_id: "CMP-web-access"
layer: "L2"
provenance: "observed"
generator: "agent"
---

# Purpose

[inferred] The source groups Web Interaction, Actor Access into the Web Access subsystem.

# Responsibilities

- Accept user actions, coordinate authorization, and show results. Evidence: [Web Interaction](../modules/web-interaction.md).
- Resolve demo actors and enforce employee or custodian action policy. Evidence: [Actor Access](../modules/actor-access.md).

# Interfaces

- Uses or exposes [Employee Equipment](../system/interfaces/employee-equipment.md).
- Uses or exposes [Custodian Equipment](../system/interfaces/custodian-equipment.md).

# Dependencies

- Uses [Equipment Handoff](equipment-handoff.md) through the linked Module calls.
- Uses [Equipment Scheduling](equipment-scheduling.md) through the linked Module calls.

# Modules

- [Web Interaction](../modules/web-interaction.md).
- [Actor Access](../modules/actor-access.md).

# Runtime notes

- Python 3.13, Flask 3.1, and SQLite. Evidence: [equipment_reservation/web_access/web_interaction.py](../files/equipment_reservation/web_access/web_interaction.py.md).

# Related

- [Technical Overview](../system/technical-overview.md).
- [Employee Equipment](../system/interfaces/employee-equipment.md).
- [Custodian Equipment](../system/interfaces/custodian-equipment.md).
- [Equipment Access](../system/authorization/equipment-access.md).
- [Reserve Equipment](../system/workflows/reserve-equipment.md).
- [Manage Maintenance](../system/workflows/manage-maintenance.md).
- [Record Equipment Pickup](../system/workflows/record-equipment-pickup.md).
- [Record Equipment Return](../system/workflows/record-equipment-return.md).
- [Application Runtime](../system/deployment/application-runtime.md).

# Decomposition

- [Web Interaction](../modules/web-interaction.md).
- [Actor Access](../modules/actor-access.md).

# Evidence

- [Web Interaction](../modules/web-interaction.md).
- [Actor Access](../modules/actor-access.md).
