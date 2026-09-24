---
type: "Source File"
title: "styles.css"
description: "CSS config file at web/styles.css."
spec_id: "FILE-web-styles-css"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "web/styles.css"
language: "CSS"
role: "config"
git_blob: "0f626ba316b30c7dd66ee590c58947028d411207"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] styles.css supports the Web Interaction responsibility. The source starts: `body {`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `web/styles.css:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `body` — body { Evidence: `web/styles.css:1`.
- `main` — main { Evidence: `web/styles.css:7`.
- `section` — section { Evidence: `web/styles.css:11`.
- `button` — button { Evidence: `web/styles.css:15`.

# Dependencies

- Used by [index.html](index.html.md).

# Configuration

- Configuration or environment input is defined or read here. Evidence: `web/styles.css:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `web/styles.css:1` — file start.
- `git_blob: 0f626ba316b30c7dd66ee590c58947028d411207` — source content hash.
