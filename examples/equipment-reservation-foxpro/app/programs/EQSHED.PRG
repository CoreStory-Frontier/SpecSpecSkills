* Schedule Management Module.
* Owns Reservation and Maintenance Period data and conflict rules.

FUNCTION Availability(tnEquipId, ttStart, ttEnd)
LOCAL llAvailable
llAvailable = .F.
IF ttEnd <= ttStart
    RETURN llAvailable
ENDIF
IF EquipmentExists(tnEquipId)
    llAvailable = .T.
    SELECT COUNT(*) FROM reservations ;
        WHERE equip_id = tnEquipId ;
          AND state = "CONFIRMED" ;
          AND start_time < ttEnd ;
          AND end_time > ttStart ;
        INTO ARRAY laCount
    IF laCount[1] > 0
        llAvailable = .F.
    ELSE
        SELECT COUNT(*) FROM maintenance ;
            WHERE equip_id = tnEquipId ;
              AND start_time < ttEnd ;
              AND end_time > ttStart ;
            INTO ARRAY laCount
        IF laCount[1] > 0
            llAvailable = .F.
        ENDIF
    ENDIF
ENDIF
RETURN llAvailable

FUNCTION Reserve(tcActorId, tnEquipId, ttStart, ttEnd)
LOCAL loResult, lnSelect, lnNextId
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "rsv_id", 0)
IF !Authorize(tcActorId, "RESERVE")
    loResult.message = "Actor is not permitted to reserve equipment."
    RETURN loResult
ENDIF
IF ttEnd <= ttStart
    loResult.message = "End time must be after start time."
    RETURN loResult
ENDIF
IF !EquipmentExists(tnEquipId)
    loResult.message = "Equipment does not exist."
    RETURN loResult
ENDIF
lnSelect = SELECT()
USE data\equipment IN 0 SHARED AGAIN ALIAS equipment_lock
SELECT equipment_lock
LOCATE FOR equip_id = tnEquipId
IF !RLOCK()
    loResult.message = "Equipment is busy. Try again."
    USE IN equipment_lock
    RETURN loResult
ENDIF
IF !Availability(tnEquipId, ttStart, ttEnd)
    loResult.message = "Equipment is unavailable for that period."
    UNLOCK
    USE IN equipment_lock
    RETURN loResult
ENDIF
lnNextId = NextId("reservations", "rsv_id")
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
SELECT reservations
APPEND BLANK
REPLACE rsv_id WITH lnNextId, ;
        equip_id WITH tnEquipId, ;
        actor_id WITH UPPER(ALLTRIM(tcActorId)), ;
        start_time WITH ttStart, ;
        end_time WITH ttEnd, ;
        state WITH "CONFIRMED"
loResult.success = .T.
loResult.rsv_id = lnNextId
UNLOCK
USE IN reservations
USE IN equipment_lock
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION AddMaintenance(tcActorId, tnEquipId, ttStart, ttEnd, tcReason)
LOCAL loResult, lnSelect, lnNextId, lnMaintId, laInvalid[1]
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "maint_id", 0)
ADDPROPERTY(loResult, "invalid_ids", CREATEOBJECT("Collection"))
IF !Authorize(tcActorId, "MAINT")
    loResult.message = "Actor is not permitted to record maintenance."
    RETURN loResult
ENDIF
IF ttEnd <= ttStart
    loResult.message = "End time must be after start time."
    RETURN loResult
ENDIF
IF !EquipmentExists(tnEquipId)
    loResult.message = "Equipment does not exist."
    RETURN loResult
ENDIF
lnSelect = SELECT()
USE data\equipment IN 0 SHARED AGAIN ALIAS equipment_lock
SELECT equipment_lock
LOCATE FOR equip_id = tnEquipId
IF !RLOCK()
    loResult.message = "Equipment is busy. Try again."
    USE IN equipment_lock
    RETURN loResult
ENDIF
lnMaintId = NextId("maintenance", "maint_id")
USE data\maintenance IN 0 SHARED AGAIN ALIAS maintenance
SELECT maintenance
APPEND BLANK
REPLACE maint_id WITH lnMaintId, ;
        equip_id WITH tnEquipId, ;
        start_time WITH ttStart, ;
        end_time WITH ttEnd, ;
        reason WITH ALLTRIM(tcReason)
SELECT rsv_id FROM reservations ;
    WHERE equip_id = tnEquipId ;
      AND state = "CONFIRMED" ;
      AND start_time < ttEnd ;
      AND end_time > ttStart ;
    INTO ARRAY laInvalid
IF _TALLY > 0
    LOCAL lnI
    FOR lnI = 1 TO ALEN(laInvalid, 1)
        UPDATE reservations SET state = "INVALID" WHERE rsv_id = laInvalid[lnI]
        loResult.invalid_ids.Add(laInvalid[lnI])
    ENDFOR
ENDIF
loResult.success = .T.
loResult.maint_id = lnMaintId
UNLOCK
USE IN maintenance
USE IN equipment_lock
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION CancelInvalid(tcActorId, tnRsvId)
LOCAL loResult, lnSelect, loReservation
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "state", "")
IF !Authorize(tcActorId, "CANCEL")
    loResult.message = "Actor is not permitted to cancel a reservation."
    RETURN loResult
ENDIF
lnSelect = SELECT()
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
SELECT reservations
LOCATE FOR rsv_id = tnRsvId
IF !FOUND()
    loResult.message = "Reservation does not exist."
    USE IN reservations
    RETURN loResult
ENDIF
IF state != "INVALID"
    loResult.message = "Only an invalid reservation can be cancelled."
    USE IN reservations
    RETURN loResult
ENDIF
SELECT COUNT(*) FROM maintenance ;
    WHERE equip_id = reservations.equip_id ;
      AND start_time < reservations.end_time ;
      AND end_time > reservations.start_time ;
    INTO ARRAY laCount
IF laCount[1] = 0
    loResult.message = "Reservation has no overlapping maintenance."
    USE IN reservations
    RETURN loResult
ENDIF
REPLACE state WITH "CANCELLED"
loResult.success = .T.
loResult.state = "CANCELLED"
USE IN reservations
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION MyReservations(tcActorId)
LOCAL loRows, lnSelect, lcCursor
loRows = CREATEOBJECT("Collection")
IF !Authorize(tcActorId, "MINE")
    RETURN loRows
ENDIF
lnSelect = SELECT()
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
lcCursor = SYS(2015)
SELECT * FROM reservations ;
    WHERE UPPER(ALLTRIM(actor_id)) == UPPER(ALLTRIM(tcActorId)) ;
    ORDER BY rsv_id ;
    INTO CURSOR (lcCursor)
SELECT (lcCursor)
SCAN
    LOCAL loRow
    loRow = CREATEOBJECT("Empty")
    ADDPROPERTY(loRow, "rsv_id", rsv_id)
    ADDPROPERTY(loRow, "equip_id", equip_id)
    ADDPROPERTY(loRow, "actor_id", actor_id)
    ADDPROPERTY(loRow, "start_time", start_time)
    ADDPROPERTY(loRow, "end_time", end_time)
    ADDPROPERTY(loRow, "state", state)
    loRows.Add(loRow)
ENDSCAN
USE IN (lcCursor)
USE IN reservations
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loRows

FUNCTION EquipmentHistory(tnEquipId)
LOCAL loRows, lnSelect, lcCursor
loRows = CREATEOBJECT("Collection")
lnSelect = SELECT()
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
lcCursor = SYS(2015)
SELECT * FROM reservations ;
    WHERE equip_id = tnEquipId ;
    ORDER BY rsv_id ;
    INTO CURSOR (lcCursor)
SELECT (lcCursor)
SCAN
    LOCAL loRow
    loRow = CREATEOBJECT("Empty")
    ADDPROPERTY(loRow, "kind", "RESERVATION")
    ADDPROPERTY(loRow, "id", rsv_id)
    ADDPROPERTY(loRow, "equip_id", equip_id)
    ADDPROPERTY(loRow, "actor_id", actor_id)
    ADDPROPERTY(loRow, "start_time", start_time)
    ADDPROPERTY(loRow, "end_time", end_time)
    ADDPROPERTY(loRow, "state", state)
    loRows.Add(loRow)
ENDSCAN
USE IN (lcCursor)
USE IN reservations
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loRows

FUNCTION CompleteReturn(tnRsvId)
LOCAL llSuccess
llSuccess = .F.
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
SELECT reservations
LOCATE FOR rsv_id = tnRsvId
IF FOUND() AND state == "CONFIRMED"
    REPLACE state WITH "COMPLETED"
    llSuccess = .T.
ENDIF
USE IN reservations
RETURN llSuccess

FUNCTION EquipmentExists(tnEquipId)
LOCAL llFound, lnSelect
llFound = .F.
lnSelect = SELECT()
USE data\equipment IN 0 SHARED AGAIN ALIAS equipment
SELECT equipment
LOCATE FOR equip_id = tnEquipId
llFound = FOUND()
USE IN equipment
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN llFound
