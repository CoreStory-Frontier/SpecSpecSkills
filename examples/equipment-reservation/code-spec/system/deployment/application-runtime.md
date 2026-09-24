---
type: "Deployment"
title: "Application Runtime"
description: "Python 3.13, Flask 3.1, and SQLite is the documented target runtime."
spec_id: "DEPLOY-application-runtime"
layer: "L3"
provenance: "inferred"
generator: "agent"
---

# Purpose

[inferred] Python 3.13, Flask 3.1, and SQLite is the documented target runtime.

# Topology

- Target runtime is described in [README.md](../../files/README.md.md). Runtime execution is verified separately.

# Environments

No production environment is established by the repository.

# Configuration

- See [equipment_reservation/web_access/web_interaction.py](../../files/equipment_reservation/web_access/web_interaction.py.md) and setup files.

# Related

- [Product Overview](../../product/overview.md).

# Decomposition

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).

# Evidence

- [Web Access](../../components/web-access.md).
- [Equipment Scheduling](../../components/equipment-scheduling.md).
- [Equipment Handoff](../../components/equipment-handoff.md).
- [equipment_reservation/web_access/web_interaction.py](../../files/equipment_reservation/web_access/web_interaction.py.md); source `equipment_reservation/web_access/web_interaction.py:1`.
