      ******************************************************************
      * EQHND00 — Equipment Use Management Module.
      * Owns Equipment Use records, pickup, return, and use history.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQHND00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       01 WS-USE-COUNT PIC S9(9) COMP-5.
       01 WS-RSRV-STATE PIC X(10).
       01 WS-RETURN-INPUT PIC X(26).
       01 WS-I PIC S9(9) COMP-5.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE 'OK' TO EQ-STATUS
           EVALUATE EQ-OP
             WHEN 'PICKUP'
               PERFORM RECORD-PICKUP
             WHEN 'RETURN'
               PERFORM RECORD-RETURN
             WHEN 'HISTORY'
               PERFORM HISTORY
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Handoff operation is not supported.' TO EQ-ERROR
           END-EVALUATE
           GOBACK.

       RECORD-PICKUP.
           MOVE 'CONTEXT' TO EQ-OP
           CALL 'EQOPS00' USING EQ-COMMAREA
           MOVE 'PICKUP' TO EQ-OP
           IF EQ-STATUS NOT = 'OK'
               GO TO PICKUP-DONE
           END-IF
           IF EQ-STATE NOT = 'CONFIRMED'
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Pickup requires a confirmed reservation.' TO EQ-ERROR
               GO TO PICKUP-DONE
           END-IF
           MOVE 0 TO WS-USE-COUNT
           EXEC SQL
               SELECT COUNT(*) INTO :WS-USE-COUNT
                   FROM EQP_USE
                   WHERE RSRV_ID = :EQ-RSRV-ID
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Use record check failed.' TO EQ-ERROR
               GO TO PICKUP-DONE
           END-IF
           IF WS-USE-COUNT > 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Pickup is already recorded.' TO EQ-ERROR
               GO TO PICKUP-DONE
           END-IF
           EXEC SQL
               INSERT INTO EQP_USE
                   (RSRV_ID, EQUIP_ID, ACTOR_ID, PICKUP_TS)
                   VALUES
                   (:EQ-RSRV-ID, :EQ-EQUIP-ID, :EQ-ACTOR-ID,
                    TIMESTAMP(:EQ-PICKUP-TS))
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Pickup insert failed.' TO EQ-ERROR
               GO TO PICKUP-DONE
           END-IF
           EXEC SQL
               SELECT USE_ID INTO :EQ-USE-ID
                   FROM EQP_USE
                   WHERE RSRV_ID = :EQ-RSRV-ID
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Use identity read failed.' TO EQ-ERROR
           END-IF.

       PICKUP-DONE.
           EXIT.

       RECORD-RETURN.
           MOVE EQ-RETURN-TS TO WS-RETURN-INPUT
           EXEC SQL
               SELECT USE_ID, RSRV_ID, EQUIP_ID, ACTOR_ID, PICKUP_TS, RETURN_TS
                   INTO :EQ-USE-ID, :EQ-RSRV-ID, :EQ-EQUIP-ID,
                        :EQ-ACTOR-ID, :EQ-PICKUP-TS, :EQ-RETURN-TS
                   FROM EQP_USE
                   WHERE USE_ID = :EQ-USE-ID
                   FOR UPDATE
           END-EXEC
           IF SQLCODE = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Use record does not exist.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Use record read failed.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           IF EQ-PICKUP-TS = SPACES
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Return requires one pickup.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           IF EQ-RETURN-TS NOT = SPACES
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Return is already recorded.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           IF WS-RETURN-INPUT <= EQ-PICKUP-TS
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Return time must be after pickup.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           EXEC SQL
               UPDATE EQP_USE
                   SET RETURN_TS = TIMESTAMP(:WS-RETURN-INPUT)
                   WHERE USE_ID = :EQ-USE-ID
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Return update failed.' TO EQ-ERROR
               GO TO RETURN-DONE
           END-IF
           MOVE 'COMPLETE' TO EQ-OP
           CALL 'EQOPS00' USING EQ-COMMAREA
           MOVE 'RETURN' TO EQ-OP
           IF EQ-STATUS NOT = 'OK'
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation completion failed.' TO EQ-ERROR
           END-IF.

       RETURN-DONE.
           EXIT.

       HISTORY.
           MOVE 'HISTORY' TO EQ-OP
           CALL 'EQOPS00' USING EQ-COMMAREA
           IF EQ-STATUS NOT = 'OK'
               GO TO HISTORY-DONE
           END-IF
           MOVE 0 TO EQ-USE-COUNT
           EXEC SQL
               DECLARE EQ-USE-CUR CURSOR FOR
                   SELECT USE_ID, RSRV_ID, EQUIP_ID, ACTOR_ID,
                          PICKUP_TS, RETURN_TS
                       FROM EQP_USE
                       WHERE EQUIP_ID = :EQ-EQUIP-ID
                       ORDER BY USE_ID
           END-EXEC
           EXEC SQL OPEN EQ-USE-CUR END-EXEC
           PERFORM UNTIL SQLCODE NOT = 0 OR EQ-USE-COUNT >= 50
               EXEC SQL
                   FETCH EQ-USE-CUR
                       INTO :EQ-USE-ID-ROW(EQ-USE-COUNT + 1),
                            :EQ-USE-RSRV-ID(EQ-USE-COUNT + 1),
                            :EQ-USE-EQUIP-ID(EQ-USE-COUNT + 1),
                            :EQ-USE-ACTOR-ID(EQ-USE-COUNT + 1),
                            :EQ-USE-PICKUP-TS(EQ-USE-COUNT + 1),
                            :EQ-USE-RETURN-TS(EQ-USE-COUNT + 1)
               END-EXEC
               IF SQLCODE = 0
                   ADD 1 TO EQ-USE-COUNT
               END-IF
           END-PERFORM
           EXEC SQL CLOSE EQ-USE-CUR END-EXEC
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Use history failed.' TO EQ-ERROR
           END-IF.

       HISTORY-DONE.
           EXIT.
