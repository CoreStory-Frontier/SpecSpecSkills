      ******************************************************************
      * EQTEST00 — Criterion test driver.
      * One paragraph per L4 Behavior bullet or Acceptance criterion.
      * Run on z/OS with DB2 attached. This workstation has no mainframe
      * runtime, so these tests are source-complete but not executed here.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQTEST00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       01 WS-EXPECTED-STATUS PIC X(2).
       01 WS-EXPECTED-FLAG PIC X.
       01 WS-I PIC S9(9) COMP-5 VALUE 1.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           PERFORM TEST-FE-B1
           PERFORM TEST-FE-B2
           PERFORM TEST-FE-B3
           PERFORM TEST-FE-B4
           PERFORM TEST-FE-B5
           PERFORM TEST-FE-A1
           PERFORM TEST-FE-A2
           PERFORM TEST-FE-A3
           PERFORM TEST-RE-B1
           PERFORM TEST-RE-B2
           PERFORM TEST-RE-B3
           PERFORM TEST-RE-B4
           PERFORM TEST-RE-A1
           PERFORM TEST-RE-A2
           PERFORM TEST-RE-A3
           PERFORM TEST-RE-A4
           PERFORM TEST-VR-B1
           PERFORM TEST-VR-B2
           PERFORM TEST-VR-B3
           PERFORM TEST-VR-B4
           PERFORM TEST-VR-A1
           PERFORM TEST-VR-A2
           PERFORM TEST-VR-A3
           PERFORM TEST-ME-B1
           PERFORM TEST-ME-B2
           PERFORM TEST-ME-B3
           PERFORM TEST-ME-B4
           PERFORM TEST-ME-B5
           PERFORM TEST-ME-B6
           PERFORM TEST-ME-A1
           PERFORM TEST-ME-A2
           PERFORM TEST-ME-A3
           PERFORM TEST-ME-A4
           PERFORM TEST-TU-B1
           PERFORM TEST-TU-B2
           PERFORM TEST-TU-B3
           PERFORM TEST-TU-A1
           PERFORM TEST-TU-A2
           PERFORM TEST-TU-A3
           PERFORM TEST-CE-B1
           PERFORM TEST-CE-B2
           PERFORM TEST-CE-B3
           PERFORM TEST-CE-B4
           PERFORM TEST-CE-B5
           PERFORM TEST-CE-B6
           PERFORM TEST-CE-B7
           PERFORM TEST-CE-A1
           PERFORM TEST-CE-A2
           PERFORM TEST-CE-A3
           PERFORM TEST-CE-A4
           GOBACK

      ******************************************************************
      * One test per criterion.
      ******************************************************************

       TEST-FE-B1.
      * Criterion: FE-B1. Distinct equipment identity.
           PERFORM RESET-DATA
           PERFORM SEED-TWO-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-B1 FAILED: status"
           END-IF
           IF EQ-EQUIP-ID = 0
               DISPLAY "FE-B1 FAILED: equipment identity"
           END-IF

       TEST-FE-B2.
      * Criterion: FE-B2. Employee supplies a period.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-B2 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-B2 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-B2 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-B3.
      * Criterion: FE-B3. Confirmed reservation blocks availability.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-B3 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-B3 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-B3 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-B4.
      * Criterion: FE-B4. Non-confirmed states do not block.
           PERFORM RESET-DATA
           PERFORM SEED-COMPLETED-RESERVATION
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-B4 FAILED: status"
           END-IF
           MOVE "Y" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-B4 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-B4 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-B5.
      * Criterion: FE-B5. Maintenance blocks availability.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-B5 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-B5 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-B5 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-A1.
      * Criterion: FE-A1. Free item is available.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-A1 FAILED: status"
           END-IF
           MOVE "Y" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-A1 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-A1 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-A2.
      * Criterion: FE-A2. Confirmed overlap is unavailable.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-A2 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-A2 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-A2 FAILED: availability"
               END-IF
           END-IF

       TEST-FE-A3.
      * Criterion: FE-A3. Maintenance overlap is unavailable.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "FE-A3 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "FE-A3 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "FE-A3 FAILED: availability"
               END-IF
           END-IF

       TEST-RE-B1.
      * Criterion: RE-B1. Employee selects item and period.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-B1 FAILED: status"
           END-IF
           IF EQ-RSRV-ID = 0
               DISPLAY "RE-B1 FAILED: reservation identity"
           END-IF

       TEST-RE-B2.
      * Criterion: RE-B2. Reserve only when fully available.
           PERFORM RESET-DATA
           PERFORM SEED-PARTIAL-RESERVATION
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-B2 FAILED: status"
           END-IF

       TEST-RE-B3.
      * Criterion: RE-B3. Reject confirmed overlap.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-B3 FAILED: status"
           END-IF

       TEST-RE-B4.
      * Criterion: RE-B4. Reject invalid period.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-B4 FAILED: status"
           END-IF

       TEST-RE-A1.
      * Criterion: RE-A1. Confirm available reservation.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-A1 FAILED: status"
           END-IF
           IF EQ-RSRV-ID = 0
               DISPLAY "RE-A1 FAILED: reservation identity"
           END-IF

       TEST-RE-A2.
      * Criterion: RE-A2. Reject overlapping reservation.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-A2 FAILED: status"
           END-IF

       TEST-RE-A3.
      * Criterion: RE-A3. Reject maintenance overlap.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-A3 FAILED: status"
           END-IF

       TEST-RE-A4.
      * Criterion: RE-A4. Reject end before start.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "RESERVE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           IF EQ-OP = "RESERVE" AND WS-I = 12
               MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           END-IF
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "RE-A4 FAILED: status"
           END-IF

       TEST-VR-B1.
      * Criterion: VR-B1. Employee requests own reservations.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-B1 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "VR-B1 FAILED: reservation count"
           END-IF

       TEST-VR-B2.
      * Criterion: VR-B2. Show only assigned reservations.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-B2 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "VR-B2 FAILED: reservation count"
           END-IF

       TEST-VR-B3.
      * Criterion: VR-B3. Show empty result when none.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "MINE" TO EQ-OP
           MOVE "BOB" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-B3 FAILED: status"
           END-IF
           MOVE 0 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "VR-B3 FAILED: reservation count"
           END-IF

       TEST-VR-B4.
      * Criterion: VR-B4. No data without actor or permission.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "UNKNOWN" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-B4 FAILED: status"
           END-IF

       TEST-VR-A1.
      * Criterion: VR-A1. Only that employee sees reservations.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-A1 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "VR-A1 FAILED: reservation count"
           END-IF

       TEST-VR-A2.
      * Criterion: VR-A2. Empty result for no reservations.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "MINE" TO EQ-OP
           MOVE "BOB" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-A2 FAILED: status"
           END-IF
           MOVE 0 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "VR-A2 FAILED: reservation count"
           END-IF

       TEST-VR-A3.
      * Criterion: VR-A3. Unauthorized actor gets no data.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "UNKNOWN" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "ER" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "VR-A3 FAILED: status"
           END-IF

       TEST-ME-B1.
      * Criterion: ME-B1. Custodian adds equipment.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B1 FAILED: status"
           END-IF
           IF EQ-EQUIP-ID = 0
               DISPLAY "ME-B1 FAILED: equipment identity"
           END-IF

       TEST-ME-B2.
      * Criterion: ME-B2. Custodian blocks maintenance period.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "MAINT" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B2 FAILED: status"
           END-IF
           IF EQ-INVALID-COUNT = 0
               DISPLAY "ME-B2 FAILED: no invalidation"
           END-IF

       TEST-ME-B3.
      * Criterion: ME-B3. Maintenance makes item unavailable.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B3 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "ME-B3 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "ME-B3 FAILED: availability"
               END-IF
           END-IF

       TEST-ME-B4.
      * Criterion: ME-B4. Custodian cancels invalid reservation.
           PERFORM RESET-DATA
           PERFORM SEED-INVALID-RESERVATION
           MOVE "CANCEL" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-RSRV-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B4 FAILED: status"
           END-IF
           IF EQ-STATE NOT = "CANCELLED"
               DISPLAY "ME-B4 FAILED: state"
           END-IF

       TEST-ME-B5.
      * Criterion: ME-B5. Maintenance invalidates confirmed reservation.
           PERFORM RESET-DATA
           PERFORM SEED-INVALID-RESERVATION
           MOVE "MAINT" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B5 FAILED: status"
           END-IF
           IF EQ-STATE NOT = "INVALID"
               DISPLAY "ME-B5 FAILED: state"
           END-IF

       TEST-ME-B6.
      * Criterion: ME-B6. Cancelled and completed states remain.
           PERFORM RESET-DATA
           PERFORM SEED-CANCELLED-RESERVATION
           MOVE "MAINT" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-B6 FAILED: status"
           END-IF
           IF EQ-STATE NOT = "INVALID"
               DISPLAY "ME-B6 FAILED: state"
           END-IF

       TEST-ME-A1.
      * Criterion: ME-A1. Two equipment records are distinct.
           PERFORM RESET-DATA
           PERFORM SEED-TWO-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-A1 FAILED: status"
           END-IF
           IF EQ-EQUIP-ID = 0
               DISPLAY "ME-A1 FAILED: equipment identity"
           END-IF

       TEST-ME-A2.
      * Criterion: ME-A2. Maintenance overlap is unavailable.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-MAINT
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-A2 FAILED: status"
           END-IF
           MOVE "N" TO WS-EXPECTED-FLAG
           IF EQ-EQUIP-COUNT = 0
               DISPLAY "ME-A2 FAILED: no equipment"
           ELSE
               IF EQ-EQ-AVAILABLE(1) NOT = WS-EXPECTED-FLAG
                   DISPLAY "ME-A2 FAILED: availability"
               END-IF
           END-IF

       TEST-ME-A3.
      * Criterion: ME-A3. Maintenance invalidates overlapping reservation.
           PERFORM RESET-DATA
           PERFORM SEED-INVALID-RESERVATION
           MOVE "MAINT" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-A3 FAILED: status"
           END-IF
           IF EQ-STATE NOT = "INVALID"
               DISPLAY "ME-A3 FAILED: state"
           END-IF

       TEST-ME-A4.
      * Criterion: ME-A4. Cancel invalid reservation.
           PERFORM RESET-DATA
           PERFORM SEED-INVALID-RESERVATION
           MOVE "CANCEL" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-RSRV-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQOPS00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "ME-A4 FAILED: status"
           END-IF
           IF EQ-STATE NOT = "CANCELLED"
               DISPLAY "ME-A4 FAILED: state"
           END-IF

       TEST-TU-B1.
      * Criterion: TU-B1. Custodian records pickup.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "PICKUP" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-RSRV-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-B1 FAILED: status"
           END-IF
           IF EQ-USE-ID = 0
               DISPLAY "TU-B1 FAILED: use identity"
           END-IF

       TEST-TU-B2.
      * Criterion: TU-B2. Custodian records return.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "RETURN" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-USE-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-B2 FAILED: status"
           END-IF
           IF EQ-USE-ID = 0
               DISPLAY "TU-B2 FAILED: use identity"
           END-IF

       TEST-TU-B3.
      * Criterion: TU-B3. History keeps reservation, pickup, return.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "HISTORY" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-EQUIP-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-B3 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "TU-B3 FAILED: reservation count"
           END-IF

       TEST-TU-A1.
      * Criterion: TU-A1. Pickup appears in history.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "HISTORY" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-EQUIP-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-A1 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "TU-A1 FAILED: reservation count"
           END-IF

       TEST-TU-A2.
      * Criterion: TU-A2. Return appears in history.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "HISTORY" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-EQUIP-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-A2 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "TU-A2 FAILED: reservation count"
           END-IF

       TEST-TU-A3.
      * Criterion: TU-A3. History shows all three records.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "HISTORY" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-EQUIP-ID
           MOVE "OK" TO WS-EXPECTED-STATUS
           CALL "EQHND00" USING EQ-COMMAREA
           IF EQ-STATUS NOT = WS-EXPECTED-STATUS
               DISPLAY "TU-A3 FAILED: status"
           END-IF
           MOVE 1 TO WS-I
           IF EQ-RSRV-COUNT NOT = WS-I
               DISPLAY "TU-A3 FAILED: reservation count"
           END-IF

       TEST-CE-B1.
      * Criterion: CE-B1. Employees find and reserve.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B1 FAILED: unauthorized"
           END-IF

       TEST-CE-B2.
      * Criterion: CE-B2. Employees view own reservations.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-RESERVATION
           MOVE "MINE" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B2 FAILED: unauthorized"
           END-IF

       TEST-CE-B3.
      * Criterion: CE-B3. Custodians manage equipment.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B3 FAILED: unauthorized"
           END-IF

       TEST-CE-B4.
      * Criterion: CE-B4. Custodians view history.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-USE
           MOVE "HISTORY" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE 1 TO EQ-EQUIP-ID
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B4 FAILED: unauthorized"
           END-IF

       TEST-CE-B5.
      * Criterion: CE-B5. Product does not manage identities.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "CONTEXT" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B5 FAILED: unauthorized"
           END-IF

       TEST-CE-B6.
      * Criterion: CE-B6. Roles control access.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B6 FAILED: unauthorized"
           END-IF

       TEST-CE-B7.
      * Criterion: CE-B7. No action beyond roles.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "N" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-B7 FAILED: unauthorized"
           END-IF

       TEST-CE-A1.
      * Criterion: CE-A1. Permitted employee function.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "SEARCH" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-A1 FAILED: unauthorized"
           END-IF

       TEST-CE-A2.
      * Criterion: CE-A2. Employee cannot use custodian function.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "ALICE" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "N" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-A2 FAILED: unauthorized"
           END-IF

       TEST-CE-A3.
      * Criterion: CE-A3. Custodian uses custodian function.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "CASEY" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-A3 FAILED: unauthorized"
           END-IF

       TEST-CE-A4.
      * Criterion: CE-A4. Both roles are permitted.
           PERFORM RESET-DATA
           PERFORM SEED-ONE-EQUIP
           MOVE "ADD" TO EQ-OP
           MOVE "DREW" TO EQ-ACTOR-ID
           MOVE "2030-01-01 10:00:00.000000" TO EQ-START-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-END-TS
           MOVE "2030-01-01 10:00:00.000000" TO EQ-PICKUP-TS
           MOVE "2030-01-01 11:00:00.000000" TO EQ-RETURN-TS
           MOVE "Camera" TO EQ-NAME
           MOVE "Shared kit" TO EQ-DESCRIPTION
           MOVE "Service" TO EQ-REASON
           MOVE "Y" TO WS-EXPECTED-FLAG
           CALL "EQACT00" USING EQ-COMMAREA
           IF EQ-AUTHORIZED NOT = WS-EXPECTED-FLAG
               DISPLAY "CE-A4 FAILED: unauthorized"
           END-IF

      ******************************************************************
      * Data setup.
      ******************************************************************
       RESET-DATA.
           EXEC SQL DELETE FROM EQP_USE END-EXEC
           EXEC SQL DELETE FROM EQP_MAINT END-EXEC
           EXEC SQL DELETE FROM EQP_RSRVN END-EXEC
           EXEC SQL DELETE FROM EQP_EQUIP END-EXEC
           MOVE 1 TO EQ-EQUIP-ID
           MOVE 1 TO EQ-RSRV-ID
           MOVE 1 TO EQ-USE-ID.

       SEED-ONE-EQUIP.
           EXEC SQL INSERT INTO EQP_EQUIP
               (EQUIP_ID, EQUIP_NAME, EQUIP_DESC)
               VALUES (1, "Camera", "Shared kit") END-EXEC.

       SEED-TWO-EQUIP.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_EQUIP
               (EQUIP_ID, EQUIP_NAME, EQUIP_DESC)
               VALUES (2, "Tripod", "Camera support") END-EXEC.

       SEED-ONE-RESERVATION.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_RSRVN
               (RSRV_ID, EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
               VALUES (1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000", "CONFIRMED") END-EXEC.

       SEED-PARTIAL-RESERVATION.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_RSRVN
               (RSRV_ID, EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
               VALUES (1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 10:30:00.000000", "CONFIRMED") END-EXEC.

       SEED-COMPLETED-RESERVATION.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_RSRVN
               (RSRV_ID, EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
               VALUES (1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000", "COMPLETED") END-EXEC.

       SEED-CANCELLED-RESERVATION.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_RSRVN
               (RSRV_ID, EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
               VALUES (1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000", "CANCELLED") END-EXEC.

       SEED-INVALID-RESERVATION.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_RSRVN
               (RSRV_ID, EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
               VALUES (1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000", "CONFIRMED") END-EXEC.

       SEED-ONE-MAINT.
           PERFORM SEED-ONE-EQUIP
           EXEC SQL INSERT INTO EQP_MAINT
               (MAINT_ID, EQUIP_ID, MAINT_START, MAINT_END, MAINT_REASON)
               VALUES (1, 1,
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000", "Service") END-EXEC.

       SEED-ONE-USE.
           PERFORM SEED-ONE-RESERVATION
           EXEC SQL INSERT INTO EQP_USE
               (USE_ID, RSRV_ID, EQUIP_ID, ACTOR_ID, PICKUP_TS, RETURN_TS)
               VALUES (1, 1, 1, "ALICE",
                       "2030-01-01 10:00:00.000000",
                       "2030-01-01 11:00:00.000000") END-EXEC.
