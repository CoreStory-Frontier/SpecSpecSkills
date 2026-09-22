* Equipment Use Management Module.
* Owns Equipment Use records, pickup, return, and use history.

FUNCTION Pickup(tcActorId, tnRsvId, ttPickup)
LOCAL loResult, lnSelect, lnUseId, loReservation
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "use_id", 0)
IF !Authorize(tcActorId, "PICKUP")
    loResult.message = "Actor is not permitted to record pickup."
    RETURN loResult
ENDIF
loReservation = ReservationContext(tnRsvId)
IF !loReservation.success
    loResult.message = loReservation.message
    RETURN loResult
ENDIF
IF loReservation.state != "CONFIRMED"
    loResult.message = "Pickup requires a confirmed reservation."
    RETURN loResult
ENDIF
lnSelect = SELECT()
USE data\equipuse IN 0 SHARED AGAIN ALIAS equipuse
SELECT equipuse
LOCATE FOR rsv_id = tnRsvId
IF FOUND()
    loResult.message = "Pickup is already recorded."
    USE IN equipuse
    RETURN loResult
ENDIF
lnUseId = NextId("equipuse", "use_id")
APPEND BLANK
REPLACE use_id WITH lnUseId, ;
        rsv_id WITH tnRsvId, ;
        equip_id WITH loReservation.equip_id, ;
        actor_id WITH loReservation.actor_id, ;
        pickup_time WITH ttPickup, ;
        return_time WITH CTOT("")
loResult.success = .T.
loResult.use_id = lnUseId
USE IN equipuse
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION ReturnEquipment(tcActorId, tnUseId, ttReturn)
LOCAL loResult, lnSelect, loUse, lnRsvId
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "use_id", tnUseId)
IF !Authorize(tcActorId, "RETURN")
    loResult.message = "Actor is not permitted to record return."
    RETURN loResult
ENDIF
lnSelect = SELECT()
USE data\equipuse IN 0 SHARED AGAIN ALIAS equipuse
SELECT equipuse
LOCATE FOR use_id = tnUseId
IF !FOUND()
    loResult.message = "Use record does not exist."
    USE IN equipuse
    RETURN loResult
ENDIF
IF EMPTY(pickup_time)
    loResult.message = "Return requires one pickup."
    USE IN equipuse
    RETURN loResult
ENDIF
IF !EMPTY(return_time)
    loResult.message = "Return is already recorded."
    USE IN equipuse
    RETURN loResult
ENDIF
IF ttReturn <= pickup_time
    loResult.message = "Return time must be after pickup."
    USE IN equipuse
    RETURN loResult
ENDIF
lnRsvId = rsv_id
REPLACE return_time WITH ttReturn
USE IN equipuse
CompleteReturn(lnRsvId)
loResult.success = .T.
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION HandoffHistory(tcActorId, tnEquipId)
LOCAL loRows, loReservations, lnI, loRow
loRows = CREATEOBJECT("Collection")
IF !Authorize(tcActorId, "HISTORY")
    RETURN loRows
ENDIF
loReservations = EquipmentHistory(tnEquipId)
FOR lnI = 1 TO loReservations.Count
    loRows.Add(loReservations.Item(lnI))
ENDFOR
USE data\equipuse IN 0 SHARED AGAIN ALIAS equipuse
SELECT * FROM equipuse ;
    WHERE equip_id = tnEquipId ;
    ORDER BY use_id ;
    INTO CURSOR eqhand_history
SELECT eqhand_history
SCAN
    loRow = CREATEOBJECT("Empty")
    ADDPROPERTY(loRow, "kind", "USE")
    ADDPROPERTY(loRow, "id", use_id)
    ADDPROPERTY(loRow, "rsv_id", rsv_id)
    ADDPROPERTY(loRow, "equip_id", equip_id)
    ADDPROPERTY(loRow, "actor_id", actor_id)
    ADDPROPERTY(loRow, "pickup_time", pickup_time)
    ADDPROPERTY(loRow, "return_time", return_time)
    loRows.Add(loRow)
ENDSCAN
USE IN eqhand_history
USE IN equipuse
RETURN loRows

FUNCTION ReservationContext(tnRsvId)
LOCAL loResult, lnSelect
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "Reservation does not exist.")
ADDPROPERTY(loResult, "rsv_id", tnRsvId)
ADDPROPERTY(loResult, "equip_id", 0)
ADDPROPERTY(loResult, "actor_id", "")
ADDPROPERTY(loResult, "start_time", CTOT(""))
ADDPROPERTY(loResult, "end_time", CTOT(""))
ADDPROPERTY(loResult, "state", "")
lnSelect = SELECT()
USE data\reservations IN 0 SHARED AGAIN ALIAS reservations
SELECT reservations
LOCATE FOR rsv_id = tnRsvId
IF FOUND()
    loResult.success = .T.
    loResult.message = ""
    loResult.rsv_id = reservations.rsv_id
    loResult.equip_id = reservations.equip_id
    loResult.actor_id = reservations.actor_id
    loResult.start_time = reservations.start_time
    loResult.end_time = reservations.end_time
    loResult.state = reservations.state
ENDIF
USE IN reservations
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult
