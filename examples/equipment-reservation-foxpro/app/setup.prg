* Equipment Reservation VFP9 data setup.
* Run once from the example root in Visual FoxPro 9.

SET SAFETY OFF
SET EXCLUSIVE ON
SET MULTILOCKS ON
CLOSE DATABASES ALL

IF !DIRECTORY("data")
    MD data
ENDIF

IF FILE("data\actors.dbf")
    DELETE FILE "data\actors.dbf"
ENDIF
IF FILE("data\equipment.dbf")
    DELETE FILE "data\equipment.dbf"
ENDIF
IF FILE("data\reservations.dbf")
    DELETE FILE "data\reservations.dbf"
ENDIF
IF FILE("data\maintenance.dbf")
    DELETE FILE "data\maintenance.dbf"
ENDIF
IF FILE("data\equipuse.dbf")
    DELETE FILE "data\equipuse.dbf"
ENDIF

CREATE TABLE data\actors FREE ;
    (actor_id C(12), employee_role L, custodian_role L)
INDEX ON actor_id TAG actor_id

CREATE TABLE data\equipment FREE ;
    (equip_id I, equip_name C(40), equip_desc C(120))
INDEX ON equip_id TAG equip_id
INDEX ON UPPER(equip_name) TAG name

CREATE TABLE data\reservations FREE ;
    (rsv_id I, equip_id I, actor_id C(12), start_time T, end_time T, state C(10))
INDEX ON rsv_id TAG rsv_id
INDEX ON equip_id TAG equip_id
INDEX ON actor_id TAG actor_id
INDEX ON state TAG state
INDEX ON equip_id + state + DTOS(start_time) TAG equip_state_time

CREATE TABLE data\maintenance FREE ;
    (maint_id I, equip_id I, start_time T, end_time T, reason C(80))
INDEX ON maint_id TAG maint_id
INDEX ON equip_id TAG equip_id

CREATE TABLE data\equipuse FREE ;
    (use_id I, rsv_id I, equip_id I, actor_id C(12), pickup_time T, return_time T)
INDEX ON use_id TAG use_id
INDEX ON rsv_id TAG rsv_id
INDEX ON equip_id TAG equip_id

USE data\actors EXCLUSIVE
APPEND BLANK
REPLACE actor_id WITH "ALICE", employee_role WITH .T., custodian_role WITH .F.
APPEND BLANK
REPLACE actor_id WITH "BOB", employee_role WITH .T., custodian_role WITH .F.
APPEND BLANK
REPLACE actor_id WITH "CASEY", employee_role WITH .F., custodian_role WITH .T.
APPEND BLANK
REPLACE actor_id WITH "DREW", employee_role WITH .T., custodian_role WITH .T.
USE

CLOSE DATABASES ALL
WAIT WINDOW "Equipment Reservation tables created." NOWAIT
