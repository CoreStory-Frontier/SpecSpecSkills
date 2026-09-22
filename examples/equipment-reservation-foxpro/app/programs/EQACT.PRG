* Actor Access Module.
* Obtains the fixed demo actor roles and authorizes one operation.
* Production integration point: replace actors.dbf with the external
* workforce identity source.

FUNCTION ActorContext(tcActorId)
LOCAL lcActorId, loContext, lnSelect
lcActorId = UPPER(ALLTRIM(tcActorId))
loContext = CREATEOBJECT("Empty")
ADDPROPERTY(loContext, "actor_id", lcActorId)
ADDPROPERTY(loContext, "employee_role", .F.)
ADDPROPERTY(loContext, "custodian_role", .F.)
ADDPROPERTY(loContext, "known", .F.)
IF EMPTY(lcActorId)
    RETURN loContext
ENDIF
lnSelect = SELECT()
IF !USED("actors")
    USE data\actors IN 0 SHARED AGAIN ALIAS actors
ENDIF
SELECT actors
LOCATE FOR UPPER(ALLTRIM(actor_id)) == lcActorId
IF FOUND()
    ADDPROPERTY(loContext, "known", .T.)
    ADDPROPERTY(loContext, "employee_role", actors.employee_role)
    ADDPROPERTY(loContext, "custodian_role", actors.custodian_role)
ENDIF
IF lnSelect > 0
    SELECT (lnSelect)
ENDIF
RETURN loContext

FUNCTION Authorize(tcActorId, tcOperation)
LOCAL loContext, llAllowed
loContext = ActorContext(tcActorId)
llAllowed = .F.
IF loContext.known
    DO CASE
    CASE INLIST(UPPER(tcOperation), "ADD", "MAINT", "CANCEL", "PICKUP", "RETURN", "HISTORY")
        llAllowed = loContext.custodian_role
    CASE INLIST(UPPER(tcOperation), "SEARCH", "RESERVE", "MINE")
        llAllowed = loContext.employee_role
    CASE UPPER(tcOperation) == "CONTEXT"
        llAllowed = .T.
    ENDCASE
ENDIF
RETURN llAllowed
