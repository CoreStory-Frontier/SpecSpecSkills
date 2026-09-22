# System (L3)

## Technical overview

- [Technical overview](technical-overview.md) - System boundary and system design summary.

## Data entities

- [Equipment](data/equipment.md) - One physical equipment asset.
- [Reservation](data/reservation.md) - An employee's claim on equipment for a period.
- [Maintenance period](data/maintenance-period.md) - A period when equipment is unavailable for maintenance.
- [Equipment use](data/equipment-use.md) - Pickup and return history for reserved equipment.

## Interfaces

- [Employee equipment interface](interfaces/employee-equipment.md) - Employee search and reservation operations.
- [Custodian equipment interface](interfaces/custodian-equipment.md) - Custodian management and handoff operations.
- [Workforce identity interface](interfaces/workforce-identity.md) - External actor identity and role context.

## Workflows

- [Reserve equipment](workflows/reserve-equipment.md) - Availability checks and conflict-safe reservation.
- [Manage maintenance](workflows/manage-maintenance.md) - Maintenance periods and invalid reservations.
- [Cancel invalid reservation](workflows/cancel-invalid-reservation.md) - Custodian cancellation of a maintenance conflict.
- [Record equipment pickup](workflows/record-equipment-pickup.md) - Equipment pickup recording.
- [Record equipment return](workflows/record-equipment-return.md) - Equipment return recording.

## Authorization

- [Equipment access](authorization/equipment-access.md) - Employee and custodian access rules.

## Decisions

- [Use browser interaction](decisions/0001-browser-interaction.md) - Browser-based interaction with protocol-neutral contracts.
- [Use a modular monolith](decisions/0002-modular-monolith.md) - One deployable application with internal responsibility boundaries.

## Deployment

- [Application runtime](deployment/application-runtime.md) - One deployable application runtime.

## Observability

- [Equipment operations](observability/equipment-operations.md) - Candidate signals for product outcomes.
