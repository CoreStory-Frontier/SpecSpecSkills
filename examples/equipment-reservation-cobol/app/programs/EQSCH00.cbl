      ******************************************************************
      * EQSCH00 — Schedule Management Module.
      * Owns Reservation and Maintenance Period data and conflict rules.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQSCH00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       01 WS-CONFLICT-COUNT PIC S9(9) COMP-5.
       01 WS-INVALID-COUNT PIC S9(9) COMP-5.
       01 WS-I PIC S9(9) COMP-5.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE 'OK' TO EQ-STATUS
           EVALUATE EQ-OP
             WHEN 'AVAILABLE'
               PERFORM CHECK-AVAILABLE
             WHEN 'CONTEXT'
               PERFORM READ-CONTEXT
             WHEN 'CONTEXT'
               PERFORM READ-CONTEXT
             WHEN 'RESERVE'
               PERFORM RESERVE-EQUIP
             WHEN 'MAINT'
               PERFORM RECORD-MAINT
             WHEN 'CANCEL'
               PERFORM CANCEL-INVALID
             WHEN 'MINE'
               PERFORM LIST-MINE
             WHEN 'HISTORY'
               PERFORM LIST-RESERVATIONS
             WHEN 'COMPLETE'
               PERFORM COMPLETE-RETURN
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Schedule operation is not supported.' TO EQ-ERROR
           END-EVALUATE
           GOBACK.

       CHECK-AVAILABLE.
           MOVE 'N' TO EQ-AVAILABLE
           MOVE 0 TO WS-CONFLICT-COUNT
           EXEC SQL
               SELECT COUNT(*) INTO :WS-CONFLICT-COUNT
                   FROM EQP_RSRVN
                   WHERE EQUIP_ID = :EQ-EQUIP-ID
                     AND RSRV_STATE = 'CONFIRMED'
                     AND RSRV_START < TIMESTAMP(:EQ-END-TS)
                     AND RSRV_END   > TIMESTAMP(:EQ-START-TS)
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation conflict check failed.' TO EQ-ERROR
               GO TO AVAIL-DONE
           END-IF
           IF WS-CONFLICT-COUNT > 0
               MOVE 'N' TO EQ-AVAILABLE
               GO TO AVAIL-DONE
           END-IF
           EXEC SQL
               SELECT COUNT(*) INTO :WS-CONFLICT-COUNT
                   FROM EQP_MAINT
                   WHERE EQUIP_ID = :EQ-EQUIP-ID
                     AND MAINT_START < TIMESTAMP(:EQ-END-TS)
                     AND MAINT_END   > TIMESTAMP(:EQ-START-TS)
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Maintenance conflict check failed.' TO EQ-ERROR
               GO TO AVAIL-DONE
           END-IF
           IF WS-CONFLICT-COUNT = 0
               MOVE 'Y' TO EQ-AVAILABLE
           END-IF.

       AVAIL-DONE.
           EXIT.

       READ-CONTEXT.
           EXEC SQL
               SELECT RSRV_ID, EQUIP_ID, ACTOR_ID,
                      RSRV_START, RSRV_END, RSRV_STATE
                   INTO :EQ-RSRV-ID, :EQ-EQUIP-ID, :EQ-ACTOR-ID,
                        :EQ-START-TS, :EQ-END-TS, :EQ-STATE
                   FROM EQP_RSRVN
                   WHERE RSRV_ID = :EQ-RSRV-ID
           END-EXEC
           EVALUATE SQLCODE
             WHEN 0
               CONTINUE
             WHEN 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation does not exist.' TO EQ-ERROR
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation context read failed.' TO EQ-ERROR
           END-EVALUATE.

       CONTEXT-DONE.
           EXIT.

       READ-CONTEXT.
           EXEC SQL
               SELECT RSRV_ID, EQUIP_ID, ACTOR_ID,
                      RSRV_START, RSRV_END, RSRV_STATE
                   INTO :EQ-RSRV-ID, :EQ-EQUIP-ID, :EQ-ACTOR-ID,
                        :EQ-START-TS, :EQ-END-TS, :EQ-STATE
                   FROM EQP_RSRVN
                   WHERE RSRV_ID = :EQ-RSRV-ID
           END-EXEC
           EVALUATE SQLCODE
             WHEN 0
               CONTINUE
             WHEN 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation does not exist.' TO EQ-ERROR
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation context read failed.' TO EQ-ERROR
           END-EVALUATE.

       CONTEXT-DONE.
           EXIT.

       RESERVE-EQUIP.
           IF EQ-END-TS <= EQ-START-TS
               MOVE 'ER' TO EQ-STATUS
               MOVE 'End time must be after start time.' TO EQ-ERROR
               GO TO RESERVE-DONE
           END-IF
           EXEC SQL
               SELECT EQUIP_ID INTO :EQ-EQUIP-ID
                   FROM EQP_EQUIP
                   WHERE EQUIP_ID = :EQ-EQUIP-ID
                   FOR UPDATE
           END-EXEC
           IF SQLCODE = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment does not exist.' TO EQ-ERROR
               GO TO RESERVE-DONE
           END-IF
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment lock failed.' TO EQ-ERROR
               GO TO RESERVE-DONE
           END-IF
           MOVE 'AVAILABLE' TO EQ-OP
           PERFORM CHECK-AVAILABLE
           MOVE 'RESERVE' TO EQ-OP
           IF EQ-STATUS NOT = 'OK'
               GO TO RESERVE-DONE
           END-IF
           IF EQ-AVAILABLE NOT = 'Y'
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment is unavailable for that period.' TO EQ-ERROR
               GO TO RESERVE-DONE
           END-IF
           EXEC SQL
               INSERT INTO EQP_RSRVN
                   (EQUIP_ID, ACTOR_ID, RSRV_START, RSRV_END, RSRV_STATE)
                   VALUES
                   (:EQ-EQUIP-ID, :EQ-ACTOR-ID,
                    TIMESTAMP(:EQ-START-TS), TIMESTAMP(:EQ-END-TS),
                    'CONFIRMED')
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation insert failed.' TO EQ-ERROR
               GO TO RESERVE-DONE
           END-IF
           EXEC SQL
               SELECT IDENTITY_VAL_LOCAL() INTO :EQ-RSRV-ID
                   FROM SYSIBM.SYSDUMMY1
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation identity read failed.' TO EQ-ERROR
           END-IF.

       RESERVE-DONE.
           EXIT.

       RECORD-MAINT.
           IF EQ-END-TS <= EQ-START-TS
               MOVE 'ER' TO EQ-STATUS
               MOVE 'End time must be after start time.' TO EQ-ERROR
               GO TO MAINT-DONE
           END-IF
           EXEC SQL
               SELECT EQUIP_ID INTO :EQ-EQUIP-ID
                   FROM EQP_EQUIP
                   WHERE EQUIP_ID = :EQ-EQUIP-ID
                   FOR UPDATE
           END-EXEC
           IF SQLCODE = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment does not exist.' TO EQ-ERROR
               GO TO MAINT-DONE
           END-IF
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment lock failed.' TO EQ-ERROR
               GO TO MAINT-DONE
           END-IF
           EXEC SQL
               INSERT INTO EQP_MAINT
                   (EQUIP_ID, MAINT_START, MAINT_END, MAINT_REASON)
                   VALUES
                   (:EQ-EQUIP-ID,
                    TIMESTAMP(:EQ-START-TS), TIMESTAMP(:EQ-END-TS),
                    :EQ-REASON)
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Maintenance insert failed.' TO EQ-ERROR
               GO TO MAINT-DONE
           END-IF
           MOVE 0 TO WS-INVALID-COUNT
           EXEC SQL
               DECLARE EQ-INVALID-CUR CURSOR FOR
                   SELECT RSRV_ID
                       FROM EQP_RSRVN
                       WHERE EQUIP_ID = :EQ-EQUIP-ID
                         AND RSRV_STATE = 'CONFIRMED'
                         AND RSRV_START < TIMESTAMP(:EQ-END-TS)
                         AND RSRV_END   > TIMESTAMP(:EQ-START-TS)
                       ORDER BY RSRV_ID
                       FOR UPDATE
           END-EXEC
           EXEC SQL OPEN EQ-INVALID-CUR END-EXEC
           PERFORM UNTIL SQLCODE NOT = 0 OR WS-INVALID-COUNT >= 50
               EXEC SQL
                   FETCH EQ-INVALID-CUR
                       INTO :EQ-INVALID-RSRV-ID(WS-INVALID-COUNT + 1)
               END-EXEC
               IF SQLCODE = 0
                   ADD 1 TO WS-INVALID-COUNT
               END-IF
           END-PERFORM
           EXEC SQL CLOSE EQ-INVALID-CUR END-EXEC
           PERFORM VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > WS-INVALID-COUNT
               EXEC SQL
                   UPDATE EQP_RSRVN
                       SET RSRV_STATE = 'INVALID'
                       WHERE RSRV_ID = :EQ-INVALID-RSRV-ID(WS-I)
               END-EXEC
               IF SQLCODE NOT = 0
                   MOVE 'ER' TO EQ-STATUS
                   MOVE 'Reservation invalidation failed.' TO EQ-ERROR
                   GO TO MAINT-DONE
               END-IF
           END-PERFORM
           MOVE WS-INVALID-COUNT TO EQ-INVALID-COUNT.

       MAINT-DONE.
           EXIT.

       CANCEL-INVALID.
           EXEC SQL
               SELECT RSRV_STATE, RSRV_START, RSRV_END
                   INTO :EQ-STATE, :EQ-START-TS, :EQ-END-TS
                   FROM EQP_RSRVN
                   WHERE RSRV_ID = :EQ-RSRV-ID
                   FOR UPDATE
           END-EXEC
           IF SQLCODE = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation does not exist.' TO EQ-ERROR
               GO TO CANCEL-DONE
           END-IF
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation read failed.' TO EQ-ERROR
               GO TO CANCEL-DONE
           END-IF
           IF EQ-STATE NOT = 'INVALID'
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Only an invalid reservation can be cancelled.' TO EQ-ERROR
               GO TO CANCEL-DONE
           END-IF
           MOVE 0 TO WS-CONFLICT-COUNT
           EXEC SQL
               SELECT COUNT(*) INTO :WS-CONFLICT-COUNT
                   FROM EQP_MAINT
                   WHERE EQUIP_ID = :EQ-EQUIP-ID
                     AND MAINT_START < :EQ-END-TS
                     AND MAINT_END   > :EQ-START-TS
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Maintenance overlap check failed.' TO EQ-ERROR
               GO TO CANCEL-DONE
           END-IF
           IF WS-CONFLICT-COUNT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation has no overlapping maintenance.' TO EQ-ERROR
               GO TO CANCEL-DONE
           END-IF
           EXEC SQL
               UPDATE EQP_RSRVN
                   SET RSRV_STATE = 'CANCELLED'
                   WHERE RSRV_ID = :EQ-RSRV-ID
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation cancel failed.' TO EQ-ERROR
           END-IF.

       CANCEL-DONE.
           EXIT.

       LIST-MINE.
           MOVE 0 TO EQ-RSRV-COUNT
           EXEC SQL
               DECLARE EQ-MINE-CUR CURSOR FOR
                   SELECT RSRV_ID, EQUIP_ID, ACTOR_ID,
                          RSRV_START, RSRV_END, RSRV_STATE
                       FROM EQP_RSRVN
                       WHERE ACTOR_ID = :EQ-ACTOR-ID
                       ORDER BY RSRV_ID
           END-EXEC
           EXEC SQL OPEN EQ-MINE-CUR END-EXEC
           PERFORM UNTIL SQLCODE NOT = 0 OR EQ-RSRV-COUNT >= 50
               EXEC SQL
                   FETCH EQ-MINE-CUR
                       INTO :EQ-RV-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-EQUIP-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-ACTOR-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-START-TS(EQ-RSRV-COUNT + 1),
                            :EQ-RV-END-TS(EQ-RSRV-COUNT + 1),
                            :EQ-RV-STATE(EQ-RSRV-COUNT + 1)
               END-EXEC
               IF SQLCODE = 0
                   ADD 1 TO EQ-RSRV-COUNT
               END-IF
           END-PERFORM
           EXEC SQL CLOSE EQ-MINE-CUR END-EXEC
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation list failed.' TO EQ-ERROR
           END-IF.

       LIST-RESERVATIONS.
           MOVE 0 TO EQ-RSRV-COUNT
           EXEC SQL
               DECLARE EQ-HIST-CUR CURSOR FOR
                   SELECT RSRV_ID, EQUIP_ID, ACTOR_ID,
                          RSRV_START, RSRV_END, RSRV_STATE
                       FROM EQP_RSRVN
                       WHERE EQUIP_ID = :EQ-EQUIP-ID
                       ORDER BY RSRV_ID
           END-EXEC
           EXEC SQL OPEN EQ-HIST-CUR END-EXEC
           PERFORM UNTIL SQLCODE NOT = 0 OR EQ-RSRV-COUNT >= 50
               EXEC SQL
                   FETCH EQ-HIST-CUR
                       INTO :EQ-RV-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-EQUIP-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-ACTOR-ID(EQ-RSRV-COUNT + 1),
                            :EQ-RV-START-TS(EQ-RSRV-COUNT + 1),
                            :EQ-RV-END-TS(EQ-RSRV-COUNT + 1),
                            :EQ-RV-STATE(EQ-RSRV-COUNT + 1)
               END-EXEC
               IF SQLCODE = 0
                   ADD 1 TO EQ-RSRV-COUNT
               END-IF
           END-PERFORM
           EXEC SQL CLOSE EQ-HIST-CUR END-EXEC
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation history failed.' TO EQ-ERROR
           END-IF.

       COMPLETE-RETURN.
           EXEC SQL
               UPDATE EQP_RSRVN
                   SET RSRV_STATE = 'COMPLETED'
                   WHERE RSRV_ID = :EQ-RSRV-ID
                     AND RSRV_STATE = 'CONFIRMED'
           END-EXEC
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Reservation completion failed.' TO EQ-ERROR
           END-IF.
