      ******************************************************************
      * EQCAT00 — Equipment Catalog Module.
      * Owns Equipment identity, name, and description.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQCAT00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       01 WS-EQUIP-COUNT PIC S9(9) COMP-5.
       01 WS-NAME-LOWER PIC X(40).
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE 'OK' TO EQ-STATUS
           EVALUATE EQ-OP
             WHEN 'ADD'
               PERFORM ADD-EQUIP
             WHEN 'CATALOG'
               PERFORM LIST-EQUIP
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Catalog operation is not supported.' TO EQ-ERROR
           END-EVALUATE
           GOBACK.

       ADD-EQUIP.
           MOVE 0 TO WS-EQUIP-COUNT
           EXEC SQL
               SELECT COUNT(*) INTO :WS-EQUIP-COUNT
                   FROM EQP_EQUIP
                   WHERE UPPER(EQUIP_NAME) = UPPER(:EQ-NAME)
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment name check failed.' TO EQ-ERROR
               GO TO ADD-DONE
           END-IF
           IF WS-EQUIP-COUNT > 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment name already exists.' TO EQ-ERROR
               GO TO ADD-DONE
           END-IF
           EXEC SQL
               INSERT INTO EQP_EQUIP
                   (EQUIP_NAME, EQUIP_DESC)
                   VALUES
                   (:EQ-NAME, :EQ-DESCRIPTION)
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment insert failed.' TO EQ-ERROR
               GO TO ADD-DONE
           END-IF
           EXEC SQL
               SELECT EQUIP_ID INTO :EQ-EQUIP-ID
                   FROM EQP_EQUIP
                   WHERE EQUIP_NAME = :EQ-NAME
           END-EXEC
           IF SQLCODE NOT = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment identity read failed.' TO EQ-ERROR
           END-IF.

       ADD-DONE.
           EXIT.

       LIST-EQUIP.
           MOVE 0 TO EQ-EQUIP-COUNT
           EXEC SQL
               DECLARE EQ-EQUIP-CUR CURSOR FOR
                   SELECT EQUIP_ID, EQUIP_NAME, EQUIP_DESC
                       FROM EQP_EQUIP
                       ORDER BY EQUIP_ID
           END-EXEC
           EXEC SQL OPEN EQ-EQUIP-CUR END-EXEC
           PERFORM UNTIL SQLCODE NOT = 0 OR EQ-EQUIP-COUNT >= 50
               EXEC SQL
                   FETCH EQ-EQUIP-CUR
                       INTO :EQ-EQ-ID(EQ-EQUIP-COUNT + 1),
                            :EQ-EQ-NAME(EQ-EQUIP-COUNT + 1),
                            :EQ-EQ-DESC(EQ-EQUIP-COUNT + 1)
               END-EXEC
               IF SQLCODE = 0
                   ADD 1 TO EQ-EQUIP-COUNT
               END-IF
           END-PERFORM
           EXEC SQL CLOSE EQ-EQUIP-CUR END-EXEC
           IF SQLCODE NOT = 0 AND SQLCODE NOT = 100
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Equipment list failed.' TO EQ-ERROR
           END-IF.
