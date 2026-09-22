"""Own schedule records, UTC periods, conflict rules, and schedule outcome signals."""

import logging
from datetime import datetime, timezone

from . import equipment_catalog as catalog

logger = logging.getLogger(__name__)


def initialize(db):
    """Create reservation and maintenance tables; foreign keys protect asset references."""
    db.execute("CREATE TABLE IF NOT EXISTS reservations (id INTEGER PRIMARY KEY, equipment_id INTEGER NOT NULL REFERENCES equipment(id), employee TEXT NOT NULL, start TEXT NOT NULL, end TEXT NOT NULL, state TEXT NOT NULL CHECK(state IN ('confirmed','invalid','cancelled','completed')))")
    db.execute("CREATE TABLE IF NOT EXISTS maintenance (id INTEGER PRIMARY KEY, equipment_id INTEGER NOT NULL REFERENCES equipment(id), start TEXT NOT NULL, end TEXT NOT NULL, reason TEXT NOT NULL)")


def instant(value):
    """Normalize an ISO timestamp to UTC; naive form inputs explicitly mean UTC."""
    try:
        parsed = datetime.fromisoformat(value)
        if parsed.tzinfo is None:
            parsed = parsed.replace(tzinfo=timezone.utc)
        return parsed.astimezone(timezone.utc).isoformat(timespec="microseconds")
    except (ValueError, TypeError, OverflowError):
        raise ValueError("Use a valid date and time.") from None


def period(start, end):
    """Return normalized half-open bounds, rejecting non-positive durations."""
    start, end = instant(start), instant(end)
    if end <= start:
        raise ValueError("End time must be after start time.")
    return start, end


def unavailable_reason(db, equipment_id, start, end):
    """Report maintenance or confirmed-reservation overlap; adjacent bounds are free."""
    if db.execute("SELECT 1 FROM maintenance WHERE equipment_id=? AND start < ? AND end > ?", (equipment_id, end, start)).fetchone():
        return "maintenance"
    if db.execute("SELECT 1 FROM reservations WHERE equipment_id=? AND state='confirmed' AND start < ? AND end > ?", (equipment_id, end, start)).fetchone():
        return "reservation"
    return None


def availability(db, start, end):
    """Return each asset with availability and emit the decision context."""
    start, end = period(start, end)
    result = []
    for item in catalog.all_equipment(db):
        reason = unavailable_reason(db, item['id'], start, end)
        item.update(available=reason is None, reason=reason)
        logger.info("availability equipment=%s start=%s end=%s available=%s reason=%s", item['id'], start, end, reason is None, reason)
        result.append(item)
    return result


def reservation(db, reservation_id):
    """Return the authoritative reservation context or reject an unknown identity."""
    row = db.execute("SELECT * FROM reservations WHERE id=?", (reservation_id,)).fetchone()
    if row is None:
        raise ValueError("Reservation does not exist.")
    return dict(row)


def reserve(db, equipment_id, employee, start, end):
    """Confirm one conflict-free request within the caller's serialized transaction."""
    catalog.get(db, equipment_id)
    start, end = period(start, end)
    reason = unavailable_reason(db, equipment_id, start, end)
    if reason:
        logger.info("reservation equipment=%s result=rejected reason=%s", equipment_id, reason)
        raise ValueError("Equipment is unavailable for that period.")
    key = db.execute("INSERT INTO reservations(equipment_id,employee,start,end,state) VALUES (?,?,?,?,'confirmed')", (equipment_id, employee, start, end)).lastrowid
    logger.info("reservation equipment=%s result=confirmed", equipment_id)
    return reservation(db, key)


def reservations(db, employee=None, equipment_id=None):
    """Read reservations with optional owner and asset filters; retain all states."""
    return [dict(row) for row in db.execute("SELECT * FROM reservations WHERE (? IS NULL OR employee=?) AND (? IS NULL OR equipment_id=?) ORDER BY id", (employee, employee, equipment_id, equipment_id))]


def maintenance(db, equipment_id, start, end, reason):
    """Block a period and atomically invalidate only overlapping confirmed reservations."""
    catalog.get(db, equipment_id)
    start, end = period(start, end)
    key = db.execute("INSERT INTO maintenance(equipment_id,start,end,reason) VALUES (?,?,?,?)", (equipment_id, start, end, reason)).lastrowid
    affected = [row['id'] for row in db.execute("SELECT id FROM reservations WHERE equipment_id=? AND state='confirmed' AND start < ? AND end > ?", (equipment_id, end, start))]
    db.execute("UPDATE reservations SET state='invalid' WHERE equipment_id=? AND state='confirmed' AND start < ? AND end > ?", (equipment_id, end, start))
    for reservation_id in affected:
        logger.info("invalid_reservation equipment=%s reservation=%s", equipment_id, reservation_id)
    return {'id':key, 'equipment_id':equipment_id, 'start':start, 'end':end, 'reason':reason, 'invalid_reservations':affected}


def cancel(db, reservation_id):
    """Cancel only an invalid reservation with overlapping maintenance; otherwise reject."""
    item = reservation(db, reservation_id)
    overlap = db.execute("SELECT 1 FROM maintenance WHERE equipment_id=? AND start < ? AND end > ?", (item['equipment_id'], item['end'], item['start'])).fetchone()
    if item['state'] != 'invalid' or not overlap:
        raise ValueError("Only a reservation invalidated by maintenance can be cancelled.")
    db.execute("UPDATE reservations SET state='cancelled' WHERE id=?", (reservation_id,))
    return reservation(db, reservation_id)


def complete_return(db, reservation_id):
    """Complete a confirmed reservation; preserve invalid and cancelled historical states."""
    reservation(db, reservation_id)
    db.execute("UPDATE reservations SET state='completed' WHERE id=? AND state='confirmed'", (reservation_id,))
    return reservation(db, reservation_id)
