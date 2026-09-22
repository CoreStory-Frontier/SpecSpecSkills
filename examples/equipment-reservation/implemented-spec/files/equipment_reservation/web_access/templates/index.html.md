---
type: "Source File"
title: "equipment_reservation/web_access/templates/index.html"
description: "Render the localhost demo workspace, labelled UTC forms, result data, and error messages."
spec_id: "FILE-equipment-reservation-web-access-templates-index-html"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "equipment_reservation/web_access/templates/index.html"
git_blob: "8611c1b9327cbf15b0938b68c898b9842a7a3b0e"
language: "html"
role: "source"
revision_status: "uncommitted"
---

# Purpose

Render the localhost demo workspace, labelled UTC forms, result data, and error messages.

# Responsibilities

- Render the localhost demo workspace, labelled UTC forms, result data, and error messages.

# Symbols

No code declarations. Document and configuration units are listed below.

- `equipment_reservation/web_access/templates/index.html:2` — `<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">`
- `equipment_reservation/web_access/templates/index.html:4` — `<style>`
- `equipment_reservation/web_access/templates/index.html:13` — `{% if error %}<p role="alert" class="error">{{ error }}</p>{% endif %}`
- `equipment_reservation/web_access/templates/index.html:14` — `{% if result is defined and result is not none %}<section aria-label="Result"><h2>Result</h2><pre id="result">{{ result | tojson(indent=2) }}</pre></section>{% endif %}`
- `equipment_reservation/web_access/templates/index.html:16` — `<form id="workspace" method="post" action="/action/search">`
- `equipment_reservation/web_access/templates/index.html:17` — `<input type="hidden" name="csrf" value="{{ csrf }}">`
- `equipment_reservation/web_access/templates/index.html:18` — `<label>Demo identity <select name="identity"><option value="">No identity</option>{% for name,roles in identities.items() %}<option value="{{ name }}">{{ name }} — {{ roles | join(', ') }}</option>{% endfor %}</select></label>`
- `equipment_reservation/web_access/templates/index.html:19` — `<label>Equipment name <input name="name"></label><label>Description <input name="description"></label>`
- `equipment_reservation/web_access/templates/index.html:20` — `<label>Equipment ID <input name="equipment_id" type="number" min="1"></label>`
- `equipment_reservation/web_access/templates/index.html:21` — `<label>Start (UTC) <input name="start" type="datetime-local" step="1"></label>`
- `equipment_reservation/web_access/templates/index.html:22` — `<label>End (UTC) <input name="end" type="datetime-local" step="1"></label>`
- `equipment_reservation/web_access/templates/index.html:23` — `<label>Maintenance reason <input name="reason"></label>`
- `equipment_reservation/web_access/templates/index.html:24` — `<label>Reservation ID <input name="reservation_id" type="number" min="1"></label>`
- `equipment_reservation/web_access/templates/index.html:25` — `<label>Equipment Use ID <input name="use_id" type="number" min="1"></label>`
- `equipment_reservation/web_access/templates/index.html:26` — `<label>Pickup time (UTC) <input name="pickup_time" type="datetime-local" step="1"></label>`
- `equipment_reservation/web_access/templates/index.html:27` — `<label>Return time (UTC) <input name="return_time" type="datetime-local" step="1"></label>`
- `equipment_reservation/web_access/templates/index.html:28` — `<p><button formaction="/action/pickup">Record pickup</button> <button formaction="/action/return">Record return</button> <button formaction="/action/history">Equipment history</button></p>`
- `equipment_reservation/web_access/templates/index.html:29` — `<p><button formaction="/action/maintenance">Record maintenance</button> <button formaction="/action/cancel">Cancel invalid reservation</button> <button formaction="/action/reservations">All reservations</button></p>`
- `equipment_reservation/web_access/templates/index.html:30` — `<p><button formaction="/action/add">Add equipment</button> <button formaction="/action/catalog">Equipment catalog</button></p>`
- `equipment_reservation/web_access/templates/index.html:31` — `<p><button formaction="/action/search">Search availability</button> <button formaction="/action/reserve">Reserve equipment</button> <button formaction="/action/mine">My reservations</button></p>`

# Control flow

The browser submits the selected form action. Jinja renders errors or JSON results with escaping.

# Data & side effects

No direct persistent writes. Policy data and presentation/configuration support the owning Module.

# Dependencies

- Used by [equipment_reservation/web_access/web_interaction.py](../web_interaction.py.md).

# Errors

No application exceptions are raised by this artifact.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Tests

- [test_application.py](../../../tests/test_application.py.md) — application integration and browser coverage.
- [test_browser.py](../../../tests/test_browser.py.md) — application integration and browser coverage.

# Related

- [web-interaction](../../../../modules/web-interaction.md)

# Evidence

- `equipment_reservation/web_access/templates/index.html:2`
- `equipment_reservation/web_access/templates/index.html:4`
- `equipment_reservation/web_access/templates/index.html:13`
- `equipment_reservation/web_access/templates/index.html:14`
- `equipment_reservation/web_access/templates/index.html:16`
- `equipment_reservation/web_access/templates/index.html:17`
- `equipment_reservation/web_access/templates/index.html:18`
- `equipment_reservation/web_access/templates/index.html:19`
- `equipment_reservation/web_access/templates/index.html:20`
- `equipment_reservation/web_access/templates/index.html:21`
- `equipment_reservation/web_access/templates/index.html:22`
- `equipment_reservation/web_access/templates/index.html:23`
- `equipment_reservation/web_access/templates/index.html:24`
- `equipment_reservation/web_access/templates/index.html:25`
- `equipment_reservation/web_access/templates/index.html:26`
- `equipment_reservation/web_access/templates/index.html:27`
- `equipment_reservation/web_access/templates/index.html:28`
- `equipment_reservation/web_access/templates/index.html:29`
- `equipment_reservation/web_access/templates/index.html:30`
- `equipment_reservation/web_access/templates/index.html:31`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
