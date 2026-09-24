---
type: "Source File"
title: "pyproject.toml"
description: "TOML config file at pyproject.toml."
spec_id: "FILE-pyproject-toml"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "pyproject.toml"
language: "TOML"
role: "config"
git_blob: "d70a66028d584ad1944c0e437e13cbde265c6523"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] pyproject.toml supports the Web Interaction responsibility. The source starts: `[project]`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `pyproject.toml:1`.
- Its direct owning Module is [Web Interaction](../modules/web-interaction.md).

# Symbols

- `project` — [project] Evidence: `pyproject.toml:1`.
- `dependency-groups` — [dependency-groups] Evidence: `pyproject.toml:7`.
- `tool.pytest.ini_options` — [tool.pytest.ini_options] Evidence: `pyproject.toml:10`.
- `tool.uv` — [tool.uv] Evidence: `pyproject.toml:14`.

# Dependencies

No internal file dependency identified.

# Configuration

- Configuration or environment input is defined or read here. Evidence: `pyproject.toml:1`. Secret values are omitted.

# Related

- [Web Interaction](../modules/web-interaction.md).

# Evidence

- `pyproject.toml:1` — file start.
- `git_blob: d70a66028d584ad1944c0e437e13cbde265c6523` — source content hash.
