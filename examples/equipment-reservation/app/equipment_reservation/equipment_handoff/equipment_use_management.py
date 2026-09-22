"""Own Equipment Use records, eligibility checks, handoff events, and composed history."""

import logging

from ..equipment_scheduling import scheduling_operations as scheduling

logger = logging.getLogger(__name__)


def initialize(db):
    """Create Equipment Use storage with one-use-per-reservation and asset references."""
    db.execute("CREATE TABLE IF NOT EXISTS equipment_use (id INTEGER PRIMARY KEY, reservation_id INTEGER NOT NULL UNIQUE REFERENCES reservations(id), equipment_id INTEGER NOT NULL REFERENCES equipment(id), employee TEXT NOT NULL, pickup_time TEXT NOT NULL, return_time TEXT)")


def pickup(db, reservation_id, pickup_time):
    """Record one pickup for a confirmed reservation or reject ineligible/duplicate requests."""
    item = scheduling.handoff_context(db, reservation_id)['reservation']
    time = scheduling.timestamp(pickup_time)
    if item['state'] != 'confirmed':
        raise ValueError("Pickup requires a confirmed reservation.")
    if db.execute("SELECT 1 FROM equipment_use WHERE reservation_id=?", (reservation_id,)).fetchone():
        raise ValueError("Pickup is already recorded.")
    key = db.execute("INSERT INTO equipment_use(reservation_id,equipment_id,employee,pickup_time) VALUES (?,?,?,?)", (reservation_id, item['equipment_id'], item['employee'], time)).lastrowid
    logger.info("handoff equipment=%s kind=pickup", item['equipment_id'])
    return dict(db.execute("SELECT * FROM equipment_use WHERE id=?", (key,)).fetchone())


def record_return(db, use_id, return_time):
    """Record an ordered, unique return and update scheduling in the same transaction."""
    row = db.execute("SELECT * FROM equipment_use WHERE id=?", (use_id,)).fetchone()
    time = scheduling.timestamp(return_time)
    if row is None or row['return_time'] is not None:
        raise ValueError("Return requires one pickup and no previous return.")
    if time < row['pickup_time']:
        raise ValueError("Return time cannot precede pickup.")
    db.execute("UPDATE equipment_use SET return_time=? WHERE id=?", (time, use_id))
    scheduling.complete_return(db, row['reservation_id'])
    logger.info("handoff equipment=%s kind=return", row['equipment_id'])
    return dict(db.execute("SELECT * FROM equipment_use WHERE id=?", (use_id,)).fetchone())


def history(db, equipment_id):
    """Compose all reservation and use records for exactly one known Equipment item."""
    result = scheduling.history_context(db, equipment_id)
    result['uses'] = [dict(row) for row in db.execute("SELECT * FROM equipment_use WHERE equipment_id=? ORDER BY id", (equipment_id,))]
    return result


def execute(db, operation, values):
    """Dispatch a previously authorized handoff request, rejecting unknown operations."""
    if operation == 'pickup':
        return pickup(db, values.get('reservation_id'), values.get('pickup_time', ''))
    if operation == 'return':
        return record_return(db, values.get('use_id'), values.get('return_time', ''))
    if operation == 'history':
        return history(db, values.get('equipment_id'))
    raise ValueError("Unknown handoff operation.")
