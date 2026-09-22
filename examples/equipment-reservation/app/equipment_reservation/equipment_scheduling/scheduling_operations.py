"""Expose protocol-neutral scheduling contracts and the shared transaction boundary."""

from . import equipment_catalog as catalog
from . import schedule_management as schedule


def transaction(path):
    """Provide the application transaction without exposing storage through HTTP contracts."""
    return catalog.transaction(path)


def initialize(db):
    """Initialize catalog and schedule storage in dependency order."""
    catalog.initialize(db)
    schedule.initialize(db)


def execute(db, operation, actor, values):
    """Dispatch an authorized scheduling operation; propagate validation errors."""
    if operation == 'add':
        return catalog.add(db, values.get('name', ''), values.get('description', ''))
    if operation == 'search':
        return schedule.availability(db, values.get('start', ''), values.get('end', ''))
    if operation == 'reserve':
        return schedule.reserve(db, values.get('equipment_id'), actor, values.get('start', ''), values.get('end', ''))
    if operation == 'mine':
        return schedule.reservations(db, employee=actor)
    if operation == 'catalog':
        return catalog.all_equipment(db)
    if operation == 'reservations':
        return schedule.reservations(db)
    if operation == 'maintenance':
        return schedule.maintenance(db, values.get('equipment_id'), values.get('start', ''), values.get('end', ''), values.get('reason', ''))
    if operation == 'cancel':
        return schedule.cancel(db, values.get('reservation_id'))
    raise ValueError("Unknown scheduling operation.")


def handoff_context(db, reservation_id):
    """Supply reservation and asset context owned by Scheduling for handoff checks."""
    item = schedule.reservation(db, reservation_id)
    return {'reservation':item, 'equipment':catalog.get(db, item['equipment_id'])}


def complete_return(db, reservation_id):
    """Ask Schedule Management to complete a still-confirmed reservation after return."""
    return schedule.complete_return(db, reservation_id)


def history_context(db, equipment_id):
    """Supply asset identity and all reservation states for use-history composition."""
    return {'equipment':catalog.get(db, equipment_id), 'reservations':schedule.reservations(db, equipment_id=equipment_id)}


def timestamp(value):
    """Expose the scheduling UTC time shape to handoff consumers."""
    return schedule.instant(value)
