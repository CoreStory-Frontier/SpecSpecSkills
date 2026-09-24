---
type: "Source File"
title: "index.html"
description: "HTML config file at web/index.html."
spec_id: "FILE-web-index-html"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "web/index.html"
language: "HTML"
role: "config"
git_blob: "88f386f539fb2d7d5bb252095918d2a33923e51f"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] index.html supports the Web Interaction responsibility. The source starts: `<!doctype html>`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `web/index.html:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `actor` — <select id="actor"> Evidence: `web/index.html:14`.
- `fields` — <section id="fields"></section> Evidence: `web/index.html:33`.
- `submit` — <button id="submit">Submit</button> Evidence: `web/index.html:35`.
- `result` — <pre id="result">No request sent.</pre> Evidence: `web/index.html:37`.

# Dependencies

- Uses [app.js](app.js.md).
- Uses [styles.css](styles.css.md).

# Configuration

- Configuration or environment input is defined or read here. Evidence: `web/index.html:1`. Secret values are omitted.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `web/index.html:1` — file start.
- `git_blob: 88f386f539fb2d7d5bb252095918d2a33923e51f` — source content hash.
