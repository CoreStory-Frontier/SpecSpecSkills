* Web Interaction Module.
* Hosts the browser shell in a Visual FoxPro form and maps browser
* form actions to the Scheduling and Handoff Modules.

SET PROCEDURE TO app\programs\EQACT.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQDB.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQCAT.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQSHED.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQOPS.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQHAND.PRG ADDITIVE

DEFINE CLASS EqBrowserForm AS Form
    Caption = "Equipment Reservation"
    Width = 900
    Height = 700
    ShowWindow = 2
    AutoCenter = .T.
    Name = "EqBrowserForm"

    ADD OBJECT Browser AS OleControl WITH ;
        OleClass = "Shell.Explorer", ;
        Top = 10, Left = 10, Width = 870, Height = 670, ;
        Name = "Browser"

    PROCEDURE Init
        LOCAL lcPath
        lcPath = FULLPATH("web\index.html")
        THIS.Browser.Navigate("file://" + STRTRAN(lcPath, "\", "/"))
    ENDPROC

    PROCEDURE Browser_BeforeNavigate2
        LPARAMETERS pdisp, URL, Flags, TargetFrameName, PostData, Headers, Cancel
        LOCAL lcUrl, lcAction, lcActor, lcEquipId, lcRsvId, lcUseId, lcStart, lcEnd, lcName, lcDescription, lcReason
        lcUrl = LOWER(ALLTRIM(URL))
        IF ATC("localhost/eq?", lcUrl) = 0
            RETURN
        ENDIF
        Cancel = .T.
        lcAction = GetParam(lcUrl, "action")
        lcActor = GetParam(lcUrl, "actor")
        lcEquipId = VAL(GetParam(lcUrl, "equip_id"))
        lcRsvId = VAL(GetParam(lcUrl, "rsv_id"))
        lcUseId = VAL(GetParam(lcUrl, "use_id"))
        lcStart = CTOT(GetParam(lcUrl, "start"))
        lcEnd = CTot(GetParam(lcUrl, "end"))
        lcName = GetParam(lcUrl, "name")
        lcDescription = GetParam(lcUrl, "description")
        lcReason = GetParam(lcUrl, "reason")
        THIS.HandleAction(lcAction, lcActor, lcEquipId, lcRsvId, lcUseId, lcStart, lcEnd, lcName, lcDescription, lcReason)
    ENDPROC

    PROCEDURE HandleAction(tcAction, tcActor, tnEquipId, tnRsvId, tnUseId, ttStart, ttEnd, tcName, tcDescription, tcReason)
        LOCAL loResult, lcHtml
        IF !Authorize(tcActor, tcAction)
            lcHtml = HtmlResult(.F., "Actor is not permitted to perform this action.", .NULL.)
        ELSE
            DO CASE
            CASE INLIST(UPPER(tcAction), "ADD", "SEARCH", "RESERVE", "MINE", "MAINT", "CANCEL", "HISTORY")
                loResult = Execute(tcActor, tcAction, tnEquipId, tnRsvId, tnUseId, ttStart, ttEnd, tcName, tcDescription, tcReason)
            CASE INLIST(UPPER(tcAction), "PICKUP", "RETURN")
                loResult = ExecuteHandoff(tcAction, tcActor, tnRsvId, tnUseId, ttStart, ttEnd)
            OTHERWISE
                loResult = CREATEOBJECT("Empty")
                ADDPROPERTY(loResult, "success", .F.)
                ADDPROPERTY(loResult, "message", "Unknown action.")
            ENDCASE
            lcHtml = HtmlResult(loResult.success, loResult.message, loResult)
        ENDIF
        THIS.ShowResult(lcHtml)
    ENDPROC

    PROCEDURE ShowResult(tcHtml)
        MESSAGEBOX(tcHtml, 64, "Equipment Reservation")
    ENDPROC

    PROCEDURE Destroy
        CLEAR EVENTS
    ENDPROC
ENDDEFINE

FUNCTION ExecuteHandoff(tcAction, tcActor, tnRsvId, tnUseId, ttStart, ttEnd)
LOCAL loResult
DO CASE
CASE UPPER(tcAction) == "PICKUP"
    loResult = Pickup(tcActor, tnRsvId, ttStart)
CASE UPPER(tcAction) == "RETURN"
    loResult = ReturnEquipment(tcActor, tnUseId, ttEnd)
OTHERWISE
    loResult = CREATEOBJECT("Empty")
    ADDPROPERTY(loResult, "success", .F.)
    ADDPROPERTY(loResult, "message", "Unknown handoff action.")
ENDCASE
RETURN loResult

FUNCTION GetParam(tcUrl, tcName)
LOCAL lcQuery, lcValue, lnPos, lnEnd
lcValue = ""
lnPos = ATC(tcName + "=", tcUrl)
IF lnPos > 0
    lnEnd = ATC("&", SUBSTR(tcUrl, lnPos))
    IF lnEnd = 0
        lcQuery = SUBSTR(tcUrl, lnPos)
    ELSE
        lcQuery = SUBSTR(tcUrl, lnPos, lnEnd - 1)
    ENDIF
    lcValue = SUBSTR(lcQuery, LEN(tcName) + 2)
ENDIF
RETURN URLDecode(lcValue)

FUNCTION URLDecode(tcValue)
LOCAL lcValue
lcValue = STRTRAN(tcValue, "+", " ")
lcValue = STRTRAN(lcValue, "%3A", ":")
lcValue = STRTRAN(lcValue, "%3F", "?")
lcValue = STRTRAN(lcValue, "%3D", "=")
lcValue = STRTRAN(lcValue, "%26", "&")
RETURN lcValue

FUNCTION HtmlResult(llSuccess, tcMessage, tuResult)
LOCAL lcHtml
lcHtml = IIF(llSuccess, "SUCCESS", "ERROR") + CHR(13) + tcMessage
IF VARTYPE(tuResult) = "O" AND PEMSTATUS(tuResult, "items", 5)
    lcHtml = lcHtml + CHR(13) + "Items: " + TRANSFORM(tuResult.items.Count)
ENDIF
RETURN lcHtml

PUBLIC goEqForm
goEqForm = CREATEOBJECT("EqBrowserForm")
goEqForm.Show()
READ EVENTS
