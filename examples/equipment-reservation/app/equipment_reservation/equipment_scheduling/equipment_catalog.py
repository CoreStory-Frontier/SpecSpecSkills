"""Own Equipment records; provide catalog operations on the caller's transaction."""

import sqlite3
from contextlib import contextmanager


@contextmanager
def transaction(path):
    """Yield an isolated SQLite write transaction; commit success or roll back failure."""
    db = sqlite3.connect(path, timeout=10)
    db.row_factory = sqlite3.Row
    db.execute("PRAGMA foreign_keys = ON")
    try:
        db.execute("BEGIN IMMEDIATE")
        yield db
        db.commit()
    except BaseException:
        db.rollback()
        raise
    finally:
        db.close()


def initialize(db):
    """Create the Equipment table if absent without changing existing records."""
    db.execute("CREATE TABLE IF NOT EXISTS equipment (id INTEGER PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL)")


def add(db, name, description):
    """Create one distinct asset; reject blank names with ValueError."""
    if not name.strip():
        raise ValueError("Equipment name is required.")
    key = db.execute("INSERT INTO equipment(name, description) VALUES (?, ?)", (name.strip(), description.strip())).lastrowid
    return get(db, key)


def get(db, equipment_id):
    """Return one asset or raise ValueError for an unknown identity."""
    row = db.execute("SELECT * FROM equipment WHERE id = ?", (equipment_id,)).fetchone()
    if row is None:
        raise ValueError("Equipment does not exist.")
    return dict(row)


def all_equipment(db):
    """Return catalog records in stable identity order."""
    return [dict(row) for row in db.execute("SELECT * FROM equipment ORDER BY id")]
