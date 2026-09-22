"""Local demo identity adapter and server-side employee/custodian policy."""

IDENTITIES = {
    'alice': ('employee',),
    'bob': ('employee',),
    'casey': ('custodian',),
    'drew': ('employee', 'custodian'),
}
PERMISSIONS = {
    'search': 'employee', 'reserve': 'employee', 'mine': 'employee',
    'add': 'custodian', 'catalog': 'custodian', 'reservations': 'custodian',
    'maintenance': 'custodian', 'cancel': 'custodian',
    'pickup': 'custodian', 'return': 'custodian', 'history': 'custodian',
}


def authorize(identity, operation):
    """Return an allowed fixed identity or raise PermissionError; never trust supplied roles."""
    role = PERMISSIONS.get(operation)
    if identity not in IDENTITIES or role not in IDENTITIES[identity]:
        raise PermissionError("This action is unavailable for the current identity.")
    return identity
