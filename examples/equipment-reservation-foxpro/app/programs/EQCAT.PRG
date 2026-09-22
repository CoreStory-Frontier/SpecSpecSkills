* Equipment Catalog Module.
* Owns Equipment identity, name, and description.

FUNCTION AddEquipment(tcActorId, tcName, tcDescription)
LOCAL loResult, lnSelect, lnNextId
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "message", "")
ADDPROPERTY(loResult, "equip_id", 0)
IF !Authorize(tcActorId, "ADD")
    loResult.message = "Actor is not permitted to add equipment."
    RETURN loResult
ENDIF
IF EMPTY(ALLTRIM(tcName))
    loResult.message = "Equipment name is required."
    RETURN loResult
ENDIF
lnSelect = SELECT()
IF !USED("equipment")
    USE data\equipment IN 0 SHARED AGAIN ALIAS equipment
ENDIF
SELECT equipment
LOCATE FOR UPPER(ALLTRIM(equip_name)) == UPPER(ALLTRIM(tcName))
IF FOUND()
    loResult.message = "Equipment name already exists."
    IF lnSelect > 0
        SELECT (lnSelect)
    ENDIF
    RETURN loResult
ENDIF
lnNextId = NextId("equipment", "equip_id")
APPEND BLANK
REPLACE equip_id WITH lnNextId, ;
        equip_name WITH ALLTRIM(tcName), ;
        equip_desc WITH ALLTRIM(tcDescription)
loResult.success = .T.
loResult.equip_id = lnNextId
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult

FUNCTION ListEquipment(tcActorId)
LOCAL lcAlias, lnSelect, lcCursor
IF !Authorize(tcActorId, "SEARCH") AND !Authorize(tcActorId, "ADD")
    RETURN CREATEOBJECT("Collection")
ENDIF
lnSelect = SELECT()
IF !USED("equipment")
    USE data\equipment IN 0 SHARED AGAIN ALIAS equipment
ENDIF
lcCursor = SYS(2015)
SELECT * FROM equipment ORDER BY equip_id INTO CURSOR (lcCursor)
LOCAL loRows, lnCount
loRows = CREATEOBJECT("Collection")
SELECT (lcCursor)
SCAN
    LOCAL loRow
    loRow = CREATEOBJECT("Empty")
    ADDPROPERTY(loRow, "equip_id", equip_id)
    ADDPROPERTY(loRow, "equip_name", equip_name)
    ADDPROPERTY(loRow, "equip_desc", equip_desc)
    loRows.Add(loRow)
ENDSCAN
USE IN (lcCursor)
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loRows

FUNCTION GetEquipment(tcEquipId)
LOCAL loResult, lnSelect
loResult = CREATEOBJECT("Empty")
ADDPROPERTY(loResult, "success", .F.)
ADDPROPERTY(loResult, "equip_id", 0)
ADDPROPERTY(loResult, "equip_name", "")
ADDPROPERTY(loResult, "equip_desc", "")
lnSelect = SELECT()
IF !USED("equipment")
    USE data\equipment IN 0 SHARED AGAIN ALIAS equipment
ENDIF
SELECT equipment
LOCATE FOR equip_id = tcEquipId
IF FOUND()
    loResult.success = .T.
    loResult.equip_id = equipment.equip_id
    loResult.equip_name = equipment.equip_name
    loResult.equip_desc = equipment.equip_desc
ENDIF
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loResult
