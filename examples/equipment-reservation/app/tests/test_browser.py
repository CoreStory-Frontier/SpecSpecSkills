"""Exercise the real HTML forms with Chromium against a localhost server."""

import json
import threading

from playwright.sync_api import sync_playwright
from werkzeug.serving import make_server

from equipment_reservation.web_access.web_interaction import create_app


def submit(page, identity, button, **values):
    """Select a demo actor, fill labelled form fields, submit, and read the visible result."""
    page.locator('[name=identity]').select_option(identity)
    for key, value in values.items():
        page.locator(f'[name={key}]').fill(str(value))
    page.get_by_role('button', name=button, exact=True).click()
    if page.get_by_role('alert').count():
        return {'error': page.get_by_role('alert').inner_text()}
    return json.loads(page.locator('#result').inner_text())


def test_browser_journey(tmp_path):
    """P1: start the application and reserve persisted equipment through browser forms."""
    app = create_app({'DATABASE':str(tmp_path / 'browser.sqlite'), 'SECRET_KEY':'browser-test'})
    server = make_server('127.0.0.1', 0, app, threaded=True)
    thread = threading.Thread(target=server.serve_forever, daemon=True)
    thread.start()
    try:
        with sync_playwright() as runner:
            browser = runner.chromium.launch()
            page = browser.new_page()
            page.goto(f'http://127.0.0.1:{server.server_port}')
            item = submit(page, 'casey', 'Add equipment', name='Camera', description='Shared kit')
            results = submit(page, 'alice', 'Search availability', start='2030-01-01T10:00', end='2030-01-01T11:00')
            assert results[0]['available'] is True
            reservation = submit(page, 'alice', 'Reserve equipment', equipment_id=item['id'], start='2030-01-01T10:00', end='2030-01-01T11:00')
            assert reservation['state'] == 'confirmed'
            assert len(submit(page, 'alice', 'My reservations')) == 1
            assert submit(page, 'bob', 'My reservations') == []
            use = submit(page, 'casey', 'Record pickup', reservation_id=reservation['id'], pickup_time='2030-01-01T10:00')
            maintenance = submit(page, 'casey', 'Record maintenance', equipment_id=item['id'], start='2030-01-01T10:00', end='2030-01-01T11:00', reason='Service')
            assert maintenance['invalid_reservations'] == [reservation['id']]
            cancelled = submit(page, 'casey', 'Cancel invalid reservation', reservation_id=reservation['id'])
            assert cancelled['state'] == 'cancelled'
            returned = submit(page, 'casey', 'Record return', use_id=use['id'], return_time='2030-01-01T11:00')
            assert returned['return_time'] is not None
            history = submit(page, 'casey', 'Equipment history', equipment_id=item['id'])
            assert history['reservations'][0]['state'] == 'cancelled'
            assert len(history['uses']) == 1
            assert 'error' in submit(page, 'alice', 'Equipment history', equipment_id=item['id'])
            browser.close()
    finally:
        server.shutdown()
        thread.join()
        server.server_close()
