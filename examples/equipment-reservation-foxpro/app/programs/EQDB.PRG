* Shared DBF helpers for the Equipment Reservation reference.

FUNCTION NextId(tcTable, tcField)
LOCAL lnSelect, lcAlias, laMax[1], lnId
lcAlias = SYS(2015)
lnSelect = SELECT()
USE ("data\" + tcTable) IN 0 SHARED AGAIN ALIAS (lcAlias)
SELECT MAX(EVALUATE(tcField)) FROM (lcAlias) INTO ARRAY laMax
IF _TALLY > 0 AND VARTYPE(laMax[1]) = "N"
    lnId = laMax[1] + 1
ELSE
    lnId = 1
ENDIF
USE IN (lcAlias)
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN lnId

FUNCTION OpenTable(tcTable)
LOCAL lcAlias
lcAlias = LOWER(ALLTRIM(tcTable))
IF !USED(lcAlias)
    USE ("data\" + lcAlias) IN 0 SHARED AGAIN ALIAS (lcAlias)
ENDIF
RETURN .T.

FUNCTION CloseTable(tcTable)
LOCAL lcAlias
lcAlias = LOWER(ALLTRIM(tcTable))
IF USED(lcAlias)
    USE IN (lcAlias)
ENDIF
RETURN .T.
