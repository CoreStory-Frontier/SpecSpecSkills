* Scheduling Operations Module.
* Coordinates Equipment Catalog and Schedule Management without owning data.

FUNCTION SearchEquipment(tcActorId, ttStart, ttEnd)
LOCAL loRows, loItems, lnI, loItem, llAvailable
loRows = CREATEOBJECT("Collection")
IF !Authorize(tcActorId, "SEARCH")
    RETURN loRows
ENDIF
loItems = ListEquipment(tcActorId)
FOR lnI = 1 TO loItems.Count
    loItem = loItems.Item(lnI)
    llAvailable = Availability(loItem.equip_id, ttStart, ttEnd)
    ADDPROPERTY(loItem, "available", llAvailable)
    loRows.Add(loItem)
ENDFOR
RETURN loRows

FUNCTION Execute(tcActorId, tcOperation, tnEquipId, tnRsvId, tnUseId, ttStart, ttEnd, tcName, tcDescription, tcReason)
LOCAL loResult
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
DO CASE
CASE UPPER(tcOperation) == "ADD"
    loResult = AddEquipment(tcActorId, tcName, tcDescription)
CASE UPPER(tcOperation) == "SEARCH"
    loResult = CREATEOBJECT("Empty")
    ADDPROPERTY(loResult, "success", .T.)
    ADDPROPERTY(loResult, "message", "")
    ADDPROPERTY(loResult, "items", SearchEquipment(tcActorId, ttStart, ttEnd))
CASE UPPER(tcOperation) == "RESERVE"
    loResult = Reserve(tcActorId, tnEquipId, ttStart, ttEnd)
CASE UPPER(tcOperation) == "MINE"
    loResult = CREATEOBJECT("Empty")
    ADDPROPERTY(loResult, "success", .T.)
    ADDPROPERTY(loResult, "message", "")
    ADDPROPERTY(loResult, "items", MyReservations(tcActorId))
CASE UPPER(tcOperation) == "MAINT"
    loResult = AddMaintenance(tcActorId, tnEquipId, ttStart, ttEnd, tcReason)
CASE UPPER(tcOperation) == "CANCEL"
    loResult = CancelInvalid(tcActorId, tnRsvId)
CASE UPPER(tcOperation) == "HISTORY"
    loResult = CREATEOBJECT("Empty")
    ADDPROPERTY(loResult, "success", .T.)
    ADDPROPERTY(loResult, "message", "")
    ADDPROPERTY(loResult, "items", EquipmentHistory(tnEquipId))
OTHERWISE
    loResult.message = "Unknown scheduling operation."
ENDCASE
RETURN loResult
