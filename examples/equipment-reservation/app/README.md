# Equipment Reservation reference application

A local browser application built from the adjacent SpecSpec design. It uses Python 3.13,
Flask 3.1, server-rendered forms, and SQLite. The dependency lock records exact versions.

## Run

From this directory, with uv installed:

```sh
uv sync --locked
uv run flask --app equipment_reservation.web_access.web_interaction run --host 127.0.0.1 --port 5000
```

Open http://127.0.0.1:5000. All forms label times in UTC. Start with Casey to add equipment.
Use the returned Equipment ID as Alice to search and reserve. Reservation and Equipment Use IDs
from results identify later handoff actions. The catalog and reservation list help custodians
find records. Results show explicit data so this small reference is easy to inspect.

Demo identities: Alice and Bob are employees, Casey is a custodian, and Drew has both roles.
The visible identity selector is an approved local substitute, not authentication. The server
enforces role and ownership rules, but any local visitor can select any demo identity. There is
no employee administration or real workforce-provider integration.

## Storage and configuration

SQLite persists in Flask's instance directory by default. Set `EQUIPMENT_DATABASE` to use another
local database path. Set `EQUIPMENT_SECRET` to a local session secret if sessions must survive a
restart; otherwise the process generates one. Never commit secret values or database contents.
Seed data is entered through the custodian form; tests use isolated synthetic records.

Periods include their start and exclude their end. Only confirmed reservations block booking.
Maintenance blocks its whole period and invalidates overlapping confirmed reservations. Cancelled
and completed records remain unchanged. Return completes a confirmed reservation and preserves
invalid or cancelled states. SQLite write transactions serialize conflicting operations.

## Verify

```sh
uv run playwright install chromium
uv run pytest -q
uv run python -m compileall -q equipment_reservation tests
```

Browser tests start and stop their own localhost server. Tests cover every role, overlap and
state rules, concurrent requests, rollback, persistence, browser flows, and candidate event logs.
There is no separate frontend build or static type checker in this stack.

## Boundaries and limits

Web Access contains Web Interaction and Actor Access. Equipment Scheduling contains Equipment
Catalog, Schedule Management, and Scheduling Operations. Equipment Handoff contains Equipment
Use Management. Handoff calls Scheduling Operations; Scheduling never imports Handoff.

The application is a reference implementation. Flask's development server and demo identity
selector are for localhost use. External identity integration, production deployment, and capacity
testing are not demonstrated. Structured log messages are candidate signals, not a metrics service.
INFO signals are written through Python logging and captured by the acceptance tests.

The phase plan and acceptance evidence are in `../implementation-plan.md` and
`../implementation-record.md`. The code-derived bundle is in `../implemented-spec/` after P5.
