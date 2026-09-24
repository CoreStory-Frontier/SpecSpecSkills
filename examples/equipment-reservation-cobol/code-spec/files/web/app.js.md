---
type: "Source File"
title: "app.js"
description: "JavaScript source file at web/app.js."
spec_id: "FILE-web-app-js"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "web/app.js"
language: "JavaScript"
role: "source"
git_blob: "f3d45c00f4472d020988539ed91f3f85ff50ba6b"
source_ref: "b49ac9d318000495dffc599116320a75fd08fd91"
git_commit: "b49ac9d318000495dffc599116320a75fd08fd91"
---

# Purpose

[inferred] app.js supports the Web Interaction responsibility. The source starts: `const fields = document.querySelector('#fields');`.

# Responsibilities

- Owns the declarations and behavior listed under Symbols. Evidence: `web/app.js:1`.
- Its direct owning Module is [Web Interaction](../../modules/web-interaction.md).

# Symbols

- `fields` — const fields = document.querySelector('#fields'); Evidence: `web/app.js:1`.
- `result` — const result = document.querySelector('#result'); Evidence: `web/app.js:2`.
- `actor` — const actor = document.querySelector('#actor'); Evidence: `web/app.js:3`.
- `currentAction` — let currentAction = 'SEARCH'; Evidence: `web/app.js:4`.
- `shapes` — const shapes = { Evidence: `web/app.js:6`.
- `showFields` — function showFields(action) { Evidence: `web/app.js:18`.
- `label` — const label = document.createElement('label'); Evidence: `web/app.js:22`.
- `input` — const input = document.createElement('input'); Evidence: `web/app.js:24`.
- `submit` — async function submit() { Evidence: `web/app.js:32`.
- `body` — const body = [`ACTION=${currentAction}`, `ACTOR=${actor.value}`]; Evidence: `web/app.js:34`.
- `response` — const response = await fetch('/eqrs', { Evidence: `web/app.js:38`.

# Control flow

- `function showFields` iterates over records. Entry: `web/app.js:18`.
- `async function submit` iterates over records. Entry: `web/app.js:32`.

# Data & side effects

- browser network request at `web/app.js:38`.

# Dependencies

- Used by [index.html](index.html.md).

# Tests

- [EQTEST00.cbl](../app/tests/EQTEST00.cbl.md) documents test source; test execution status is in the bundle record.

# Related

- [Web Interaction](../../modules/web-interaction.md).

# Evidence

- `web/app.js:1` — file start.
- `git_blob: f3d45c00f4472d020988539ed91f3f85ff50ba6b` — source content hash.
