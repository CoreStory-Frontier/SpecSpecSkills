---
type: "Source File"
title: "pyproject.toml"
description: "Declare Python and dependency constraints, uv mode, and pytest discovery."
spec_id: "FILE-pyproject-toml"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "pyproject.toml"
git_blob: "d70a66028d584ad1944c0e437e13cbde265c6523"
language: "toml"
role: "config"
revision_status: "uncommitted"
---

# Purpose

Declare Python and dependency constraints, uv mode, and pytest discovery.

# Responsibilities

- Declare Python and dependency constraints, uv mode, and pytest discovery.

# Symbols

No code declarations. Document and configuration units are listed below.

- `pyproject.toml:1` — `[project]`
- `pyproject.toml:2` — `name = "equipment-reservation-reference"`
- `pyproject.toml:3` — `version = "0.1.0"`
- `pyproject.toml:4` — `requires-python = ">=3.13,<3.14"`
- `pyproject.toml:5` — `dependencies = ["flask>=3.1,<3.2"]`
- `pyproject.toml:7` — `[dependency-groups]`
- `pyproject.toml:8` — `dev = ["pytest>=9,<10", "playwright>=1.55,<2"]`
- `pyproject.toml:10` — `[tool.pytest.ini_options]`
- `pyproject.toml:11` — `pythonpath = ["."]`
- `pyproject.toml:12` — `testpaths = ["tests"]`
- `pyproject.toml:14` — `[tool.uv]`
- `pyproject.toml:15` — `package = false`

# Data & side effects

No direct persistent writes. Policy data and presentation/configuration support the owning Module.

# Dependencies

No code imports. This is a supporting document or configuration artifact.

# Errors

No application exceptions are raised by this artifact.

# Configuration

requires-python restricts the interpreter to Python 3.13. dependencies installs Flask 3.1. The dev group supplies pytest and Playwright. tool.pytest.ini_options adds the project to import lookup and discovers tests/. tool.uv disables package installation; run from this directory. uv.lock pins the resolved versions.

# Related

- [web-interaction](../modules/web-interaction.md)

# Evidence

- `pyproject.toml:1`
- `pyproject.toml:2`
- `pyproject.toml:3`
- `pyproject.toml:4`
- `pyproject.toml:5`
- `pyproject.toml:7`
- `pyproject.toml:8`
- `pyproject.toml:10`
- `pyproject.toml:11`
- `pyproject.toml:12`
- `pyproject.toml:14`
- `pyproject.toml:15`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
