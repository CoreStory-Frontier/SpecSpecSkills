---
type: "Source File"
title: "tests/test_browser.py"
description: "Exercise the real HTML forms with Chromium against a localhost server."
spec_id: "FILE-tests-test-browser-py"
layer: "L0"
provenance: "observed"
generator: "agent"
source_path: "tests/test_browser.py"
git_blob: "f5f0d7feb368e0b82092a06441daa27afc0bb41a"
language: "python"
role: "test"
revision_status: "uncommitted"
---

# Purpose

Exercise the real HTML forms with Chromium against a localhost server.

# Responsibilities

- Select a demo actor, fill labelled form fields, submit, and read the visible result.
- P1: start the application and reserve persisted equipment through browser forms.

# Symbols

## `submit(page, identity, button, **values)`

Select a demo actor, fill labelled form fields, submit, and read the visible result.

Calls: `json.loads`, `page.get_by_role`, `page.get_by_role('alert').count`, `page.get_by_role('alert').inner_text`, `page.get_by_role('button', name=button, exact=True).click`, `page.locator`, `page.locator('#result').inner_text`, `page.locator('[name=identity]').select_option`, `page.locator(f'[name={key}]').fill`, `str`, `values.items`.

Branch conditions: `page.get_by_role('alert').count()`.

Evidence: `tests/test_browser.py:12-20`.

## `test_browser_journey(tmp_path)`

P1: start the application and reserve persisted equipment through browser forms.

Calls: `browser.close`, `browser.new_page`, `create_app`, `len`, `make_server`, `page.goto`, `runner.chromium.launch`, `server.server_close`, `server.shutdown`, `str`, `submit`, `sync_playwright`, `thread.join`, `thread.start`, `threading.Thread`.

Evidence: `tests/test_browser.py:23-56`.


# Control flow

The listed operations run in caller order. Conditions above select validation and failure paths. Tests assert results; failures stop the test.

# Data & side effects

Uses isolated SQLite files and HTTP/browser sessions; browser tests bind a temporary localhost server.

# Dependencies

- Uses [equipment_reservation/web_access/web_interaction.py](../equipment_reservation/web_access/web_interaction.py.md).
- External/standard-library imports: json, playwright.sync_api, threading, werkzeug.serving.

# Errors

Assertion failures report unmet test expectations; setup and browser failures fail the run.

# Configuration

See the named declarations or artifact units above. No secret configuration values are recorded.

# Related

- [web-interaction](../../modules/web-interaction.md)

# Evidence

- `tests/test_browser.py:12-20`
- `tests/test_browser.py:23-56`

# Notes

Working-tree snapshot. Git revision pinning is pending; this is not a fully conformant upstream code-spec.
