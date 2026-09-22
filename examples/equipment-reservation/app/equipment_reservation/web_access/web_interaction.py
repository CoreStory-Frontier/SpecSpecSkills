"""Serve browser forms and coordinate policy checks before domain transactions."""

import os
import secrets
import logging
from pathlib import Path

from flask import Flask, jsonify, render_template, request, session

from . import actor_access
from ..equipment_scheduling import scheduling_operations as scheduling
from ..equipment_handoff import equipment_use_management as handoff


def create_app(config=None):
    """Create a localhost reference app; initialize persistent storage and request handlers."""
    app = Flask(__name__)
    logging.basicConfig(level=logging.INFO, format='%(name)s %(message)s')
    app.config.update(SECRET_KEY=os.environ.get('EQUIPMENT_SECRET') or secrets.token_hex(32),
                      DATABASE=os.environ.get('EQUIPMENT_DATABASE', str(Path(app.instance_path) / 'equipment.sqlite')),
                      SESSION_COOKIE_HTTPONLY=True, SESSION_COOKIE_SAMESITE='Strict')
    app.config.update(config or {})
    Path(app.config['DATABASE']).parent.mkdir(parents=True, exist_ok=True)
    with scheduling.transaction(app.config['DATABASE']) as db:
        scheduling.initialize(db)
        handoff.initialize(db)

    @app.get('/')
    def home():
        """Render a demo selector and forms; never disclose domain records on page load."""
        session.setdefault('csrf', secrets.token_hex(24))
        return render_template('index.html', identities=actor_access.IDENTITIES, csrf=session['csrf'])

    @app.post('/action/<operation>')
    def action(operation):
        """Authorize a form action, execute atomically, and return HTML or explicit JSON."""
        wants_json = request.accept_mimetypes.best == 'application/json'
        try:
            if not session.get('csrf') or not secrets.compare_digest(session['csrf'], request.form.get('csrf', '')):
                raise PermissionError("Refresh the page before submitting this form.")
            actor = actor_access.authorize(request.form.get('identity'), operation)
            with scheduling.transaction(app.config['DATABASE']) as db:
                if operation in ('pickup', 'return', 'history'):
                    result = handoff.execute(db, operation, request.form)
                else:
                    result = scheduling.execute(db, operation, actor, request.form)
            status, error = 200, None
        except PermissionError as exc:
            result, status, error = None, 403, str(exc)
        except ValueError as exc:
            result, status, error = None, 400, str(exc)
        if wants_json:
            return jsonify(result=result, error=error), status
        return render_template('index.html', identities=actor_access.IDENTITIES, csrf=session.get('csrf', ''),
                               result=result, error=error), status

    return app
