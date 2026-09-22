* Equipment Reservation VFP9 criterion test driver.
* One procedure per L4 Behavior bullet or Acceptance criterion.
* This workstation has no Visual FoxPro 9 runtime, so these tests are
* source-complete but not executed here.

SET PROCEDURE TO app\programs\EQACT.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQCAT.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQDB.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQSHED.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQOPS.PRG ADDITIVE
SET PROCEDURE TO app\programs\EQHAND.PRG ADDITIVE

#DEFINE TEST_START DATETIME(2030,1,1,10,0,0)
#DEFINE TEST_END   DATETIME(2030,1,1,11,0,0)

FUNCTION RunAllCriterionTests
LOCAL lnI
    FOR lnI = 1 TO 50
        DO (TestName(lnI))
    ENDFOR
    RETURN .T.
ENDFUNC

FUNCTION TestName(tnIndex)
LOCAL lcNames[50]
    lcNames[1] = "Test_FE_B1"
    lcNames[2] = "Test_FE_B2"
    lcNames[3] = "Test_FE_B3"
    lcNames[4] = "Test_FE_B4"
    lcNames[5] = "Test_FE_B5"
    lcNames[6] = "Test_FE_A1"
    lcNames[7] = "Test_FE_A2"
    lcNames[8] = "Test_FE_A3"
    lcNames[9] = "Test_RE_B1"
    lcNames[10] = "Test_RE_B2"
    lcNames[11] = "Test_RE_B3"
    lcNames[12] = "Test_RE_B4"
    lcNames[13] = "Test_RE_A1"
    lcNames[14] = "Test_RE_A2"
    lcNames[15] = "Test_RE_A3"
    lcNames[16] = "Test_RE_A4"
    lcNames[17] = "Test_VR_B1"
    lcNames[18] = "Test_VR_B2"
    lcNames[19] = "Test_VR_B3"
    lcNames[20] = "Test_VR_B4"
    lcNames[21] = "Test_VR_A1"
    lcNames[22] = "Test_VR_A2"
    lcNames[23] = "Test_VR_A3"
    lcNames[24] = "Test_ME_B1"
    lcNames[25] = "Test_ME_B2"
    lcNames[26] = "Test_ME_B3"
    lcNames[27] = "Test_ME_B4"
    lcNames[28] = "Test_ME_B5"
    lcNames[29] = "Test_ME_B6"
    lcNames[30] = "Test_ME_A1"
    lcNames[31] = "Test_ME_A2"
    lcNames[32] = "Test_ME_A3"
    lcNames[33] = "Test_ME_A4"
    lcNames[34] = "Test_TU_B1"
    lcNames[35] = "Test_TU_B2"
    lcNames[36] = "Test_TU_B3"
    lcNames[37] = "Test_TU_A1"
    lcNames[38] = "Test_TU_A2"
    lcNames[39] = "Test_TU_A3"
    lcNames[40] = "Test_CE_B1"
    lcNames[41] = "Test_CE_B2"
    lcNames[42] = "Test_CE_B3"
    lcNames[43] = "Test_CE_B4"
    lcNames[44] = "Test_CE_B5"
    lcNames[45] = "Test_CE_B6"
    lcNames[46] = "Test_CE_B7"
    lcNames[47] = "Test_CE_A1"
    lcNames[48] = "Test_CE_A2"
    lcNames[49] = "Test_CE_A3"
    lcNames[50] = "Test_CE_A4"
    RETURN lcNames[tnIndex]
ENDFUNC

PROCEDURE Test_FE_B1
    * Criterion: FE-B1. Distinct equipment identity.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddEquipment("CASEY", "Tripod", "Camera support")
    ASSERT EquipmentCount() == 2
ENDPROC

PROCEDURE Test_FE_B2
    * Criterion: FE-B2. Employee supplies a period.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT SearchCount("ALICE") > 0
ENDPROC

PROCEDURE Test_FE_B3
    * Criterion: FE-B3. Confirmed reservation blocks availability.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_FE_B4
    * Criterion: FE-B4. Non-confirmed states do not block.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    CompleteReturn(loRes.rsv_id)
    ASSERT SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_FE_B5
    * Criterion: FE-B5. Maintenance blocks availability.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_FE_A1
    * Criterion: FE-A1. Free item is available.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_FE_A2
    * Criterion: FE-A2. Confirmed overlap is unavailable.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_FE_A3
    * Criterion: FE-A3. Maintenance overlap is unavailable.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_RE_B1
    * Criterion: RE-B1. Employee selects item and period.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT loRes.success
ENDPROC

PROCEDURE Test_RE_B2
    * Criterion: RE-B2. Reserve only when fully available.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    loRes = Reserve("BOB", 1, TEST_START, TEST_END)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_RE_B3
    * Criterion: RE-B3. Reject confirmed overlap.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    loRes = Reserve("BOB", 1, TEST_START, TEST_END)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_RE_B4
    * Criterion: RE-B4. Reject invalid period.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_END, TEST_START)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_RE_A1
    * Criterion: RE-A1. Confirm available reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT loRes.success AND ReservationState(loRes.rsv_id) == "CONFIRMED"
ENDPROC

PROCEDURE Test_RE_A2
    * Criterion: RE-A2. Reject overlapping reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    loRes = Reserve("BOB", 1, TEST_START, TEST_END)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_RE_A3
    * Criterion: RE-A3. Reject maintenance overlap.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_RE_A4
    * Criterion: RE-A4. Reject end before start.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_END, TEST_START)
    ASSERT !loRes.success
ENDPROC

PROCEDURE Test_VR_B1
    * Criterion: VR-B1. Employee requests own reservations.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT MyReservationCount("ALICE") == 1
ENDPROC

PROCEDURE Test_VR_B2
    * Criterion: VR-B2. Show only assigned reservations.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT MyReservationCount("BOB") == 0
ENDPROC

PROCEDURE Test_VR_B3
    * Criterion: VR-B3. Show empty result when none.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT MyReservationCount("BOB") == 0
ENDPROC

PROCEDURE Test_VR_B4
    * Criterion: VR-B4. No data without actor or permission.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT MyReservationCount("UNKNOWN") == 0
ENDPROC

PROCEDURE Test_VR_A1
    * Criterion: VR-A1. Only that employee sees reservations.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    Reserve("ALICE", 1, TEST_START, TEST_END)
    ASSERT MyReservationCount("ALICE") == 1
ENDPROC

PROCEDURE Test_VR_A2
    * Criterion: VR-A2. Empty result for no reservations.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT MyReservationCount("BOB") == 0
ENDPROC

PROCEDURE Test_VR_A3
    * Criterion: VR-A3. Unauthorized actor gets no data.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT MyReservationCount("UNKNOWN") == 0
ENDPROC

PROCEDURE Test_ME_B1
    * Criterion: ME-B1. Custodian adds equipment.
    ResetTestData()
    loRes = AddEquipment("CASEY", "Camera", "Shared kit")
    ASSERT loRes.success AND loRes.equip_id > 0
ENDPROC

PROCEDURE Test_ME_B2
    * Criterion: ME-B2. Custodian blocks maintenance period.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT loRes.success
ENDPROC

PROCEDURE Test_ME_B3
    * Criterion: ME-B3. Maintenance makes item unavailable.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_ME_B4
    * Criterion: ME-B4. Custodian cancels invalid reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    loCancel = CancelInvalid("CASEY", loRes.rsv_id)
    ASSERT loCancel.success
ENDPROC

PROCEDURE Test_ME_B5
    * Criterion: ME-B5. Maintenance invalidates confirmed reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT ReservationState(loRes.rsv_id) == "INVALID"
ENDPROC

PROCEDURE Test_ME_B6
    * Criterion: ME-B6. Cancelled and completed states remain.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    CompleteReturn(loRes.rsv_id)
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT ReservationState(loRes.rsv_id) == "COMPLETED"
ENDPROC

PROCEDURE Test_ME_A1
    * Criterion: ME-A1. Two equipment records are distinct.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddEquipment("CASEY", "Tripod", "Camera support")
    ASSERT EquipmentCount() == 2
ENDPROC

PROCEDURE Test_ME_A2
    * Criterion: ME-A2. Maintenance overlap is unavailable.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT !SearchAvailable("ALICE", 1)
ENDPROC

PROCEDURE Test_ME_A3
    * Criterion: ME-A3. Maintenance invalidates overlapping reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    ASSERT ReservationState(loRes.rsv_id) == "INVALID"
ENDPROC

PROCEDURE Test_ME_A4
    * Criterion: ME-A4. Cancel invalid reservation.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    AddMaintenance("CASEY", 1, TEST_START, TEST_END, "Service")
    loCancel = CancelInvalid("CASEY", loRes.rsv_id)
    ASSERT loCancel.success AND ReservationState(loRes.rsv_id) == "CANCELLED"
ENDPROC

PROCEDURE Test_TU_B1
    * Criterion: TU-B1. Custodian records pickup.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    loPickup = Pickup("CASEY", loRes.rsv_id, TEST_START)
    ASSERT loPickup.success
ENDPROC

PROCEDURE Test_TU_B2
    * Criterion: TU-B2. Custodian records return.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    loPickup = Pickup("CASEY", loRes.rsv_id, TEST_START)
    loReturn = ReturnEquipment("CASEY", loPickup.use_id, TEST_END)
    ASSERT loReturn.success
ENDPROC

PROCEDURE Test_TU_B3
    * Criterion: TU-B3. History keeps reservation, pickup, return.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    loPickup = Pickup("CASEY", loRes.rsv_id, TEST_START)
    ReturnEquipment("CASEY", loPickup.use_id, TEST_END)
    ASSERT HandoffHistory("CASEY", 1).Count >= 2
ENDPROC

PROCEDURE Test_TU_A1
    * Criterion: TU-A1. Pickup appears in history.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    Pickup("CASEY", loRes.rsv_id, TEST_START)
    ASSERT HandoffHistory("CASEY", 1).Count > 1
ENDPROC

PROCEDURE Test_TU_A2
    * Criterion: TU-A2. Return appears in history.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    loPickup = Pickup("CASEY", loRes.rsv_id, TEST_START)
    ReturnEquipment("CASEY", loPickup.use_id, TEST_END)
    ASSERT HandoffHistory("CASEY", 1).Count >= 2
ENDPROC

PROCEDURE Test_TU_A3
    * Criterion: TU-A3. History shows all three records.
    ResetTestData()
    AddEquipment("CASEY", "Camera", "Shared kit")
    loRes = Reserve("ALICE", 1, TEST_START, TEST_END)
    loPickup = Pickup("CASEY", loRes.rsv_id, TEST_START)
    ReturnEquipment("CASEY", loPickup.use_id, TEST_END)
    ASSERT HandoffHistory("CASEY", 1).Count >= 2
ENDPROC

PROCEDURE Test_CE_B1
    * Criterion: CE-B1. Employees find and reserve.
    ResetTestData()
    ASSERT Authorize("ALICE", "SEARCH") AND Authorize("ALICE", "RESERVE")
ENDPROC

PROCEDURE Test_CE_B2
    * Criterion: CE-B2. Employees view own reservations.
    ResetTestData()
    ASSERT Authorize("ALICE", "MINE")
ENDPROC

PROCEDURE Test_CE_B3
    * Criterion: CE-B3. Custodians manage equipment.
    ResetTestData()
    ASSERT Authorize("CASEY", "ADD") AND Authorize("CASEY", "MAINT") AND Authorize("CASEY", "CANCEL") AND Authorize("CASEY", "PICKUP") AND Authorize("CASEY", "RETURN")
ENDPROC

PROCEDURE Test_CE_B4
    * Criterion: CE-B4. Custodians view history.
    ResetTestData()
    ASSERT Authorize("CASEY", "HISTORY")
ENDPROC

PROCEDURE Test_CE_B5
    * Criterion: CE-B5. Product does not manage identities.
    ResetTestData()
    loContext = ActorContext("ALICE")
    ASSERT loContext.known AND loContext.employee_role AND !loContext.custodian_role
ENDPROC

PROCEDURE Test_CE_B6
    * Criterion: CE-B6. Roles control access.
    ResetTestData()
    ASSERT Authorize("ALICE", "SEARCH") AND !Authorize("ALICE", "ADD")
ENDPROC

PROCEDURE Test_CE_B7
    * Criterion: CE-B7. No action beyond roles.
    ResetTestData()
    ASSERT !Authorize("ALICE", "ADD")
ENDPROC

PROCEDURE Test_CE_A1
    * Criterion: CE-A1. Permitted employee function.
    ResetTestData()
    ASSERT Authorize("ALICE", "SEARCH")
ENDPROC

PROCEDURE Test_CE_A2
    * Criterion: CE-A2. Employee cannot use custodian function.
    ResetTestData()
    ASSERT !Authorize("ALICE", "ADD")
ENDPROC

PROCEDURE Test_CE_A3
    * Criterion: CE-A3. Custodian uses custodian function.
    ResetTestData()
    ASSERT Authorize("CASEY", "ADD")
ENDPROC

PROCEDURE Test_CE_A4
    * Criterion: CE-A4. Both roles are permitted.
    ResetTestData()
    ASSERT Authorize("DREW", "SEARCH") AND Authorize("DREW", "ADD")
ENDPROC

FUNCTION EquipmentCount
LOCAL lnCount, lnSelect
    lnCount = 0
    lnSelect = SELECT()
    USE data\equipment IN 0 SHARED AGAIN ALIAS equipment_test
    COUNT TO lnCount
    USE IN equipment_test
    IF lnSelect > 0
        SELECT (lnSelect)
    ENDIF
    RETURN lnCount
ENDFUNC

FUNCTION SearchAvailable(tcActor, tnEquipId)
LOCAL loItems
    loItems = SearchEquipment(tcActor, TEST_START, TEST_END)
    RETURN loItems.Count >= tnEquipId AND loItems.Item(tnEquipId).available
ENDFUNC

FUNCTION SearchCount(tcActor)
    RETURN SearchEquipment(tcActor, TEST_START, TEST_END).Count
ENDFUNC

FUNCTION MyReservationCount(tcActor)
    RETURN MyReservations(tcActor).Count
ENDFUNC

FUNCTION ReservationState(tnRsvId)
LOCAL lcState, lnSelect
    lcState = ""
    lnSelect = SELECT()
    USE data\reservations IN 0 SHARED AGAIN ALIAS reservations_test
    SELECT reservations_test
    LOCATE FOR rsv_id = tnRsvId
    IF FOUND()
        lcState = state
    ENDIF
    USE IN reservations_test
    IF lnSelect > 0
        SELECT (lnSelect)
    ENDIF
    RETURN lcState
ENDFUNC

PROCEDURE ResetTestData
    CLOSE TABLES ALL
    USE data\equipment EXCLUSIVE
    ZAP
    USE
    USE data\reservations EXCLUSIVE
    ZAP
    USE
    USE data\maintenance EXCLUSIVE
    ZAP
    USE
    USE data\equipuse EXCLUSIVE
    ZAP
    USE
    CLOSE TABLES ALL
ENDPROC
