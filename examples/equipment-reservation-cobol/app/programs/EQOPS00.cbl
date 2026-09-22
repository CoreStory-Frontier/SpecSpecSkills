      ******************************************************************
      * EQOPS00 — Scheduling Operations Module.
      * Coordinates Equipment Catalog and Schedule Management without
      * owning their data.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQOPS00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SAVE-OP PIC X(12).
       01 WS-SAVE-EQUIP PIC S9(9) COMP-5.
       01 WS-I PIC S9(9) COMP-5.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE 'OK' TO EQ-STATUS
           EVALUATE EQ-OP
             WHEN 'ADD'
               CALL 'EQCAT00' USING EQ-COMMAREA
             WHEN 'SEARCH'
               PERFORM SEARCH-EQUIP
             WHEN 'RESERVE'
               MOVE 'RESERVE' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'MINE'
               MOVE 'MINE' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'MAINT'
               MOVE 'MAINT' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'CANCEL'
               MOVE 'CANCEL' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'COMPLETE'
               MOVE 'COMPLETE' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'CONTEXT'
               MOVE 'CONTEXT' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN 'HISTORY'
               MOVE 'HISTORY' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Scheduling operation is not supported.' TO EQ-ERROR
           END-EVALUATE
           GOBACK.

       SEARCH-EQUIP.
           MOVE 'SEARCH' TO WS-SAVE-OP
           MOVE 'CATALOG' TO EQ-OP
           CALL 'EQCAT00' USING EQ-COMMAREA
           IF EQ-STATUS NOT = 'OK'
               GO TO SEARCH-DONE
           END-IF
           MOVE WS-SAVE-OP TO EQ-OP
           PERFORM VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > EQ-EQUIP-COUNT
               MOVE EQ-EQ-ID(WS-I) TO WS-SAVE-EQUIP
               MOVE WS-SAVE-EQUIP TO EQ-EQUIP-ID
               MOVE 'AVAILABLE' TO EQ-OP
               CALL 'EQSCH00' USING EQ-COMMAREA
               IF EQ-STATUS NOT = 'OK'
                   GO TO SEARCH-DONE
               END-IF
               MOVE EQ-AVAILABLE TO EQ-EQ-AVAILABLE(WS-I)
               MOVE 'SEARCH' TO EQ-OP
           END-PERFORM
           MOVE 'OK' TO EQ-STATUS.

       SEARCH-DONE.
           EXIT.
