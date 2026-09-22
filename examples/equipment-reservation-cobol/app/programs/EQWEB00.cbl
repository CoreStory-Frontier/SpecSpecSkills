      ******************************************************************
      * EQWEB00 — Web Interaction Module.
      * Receives browser form data from CICS, authorizes the actor, and
      * returns plain-text result lines.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQWEB00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       01 WS-REQUEST          PIC X(8192).
       01 WS-REQUEST-LEN      PIC S9(8) COMP-4 VALUE 8192.
       01 WS-RESPONSE         PIC X(32768).
       01 WS-RESPONSE-LEN     PIC S9(8) COMP-4 VALUE 32768.
       01 WS-RESPONSE-PTR     PIC S9(8) COMP-4 VALUE 1.
       01 WS-LINE             PIC X(512).
       01 WS-LINE-LEN         PIC S9(8) COMP-4 VALUE 512.
       01 WS-KEY              PIC X(32).
       01 WS-VALUE            PIC X(256).
       01 WS-POS              PIC S9(8) COMP-4.
       01 WS-EQ-POS           PIC S9(8) COMP-4.
       01 WS-SEP-POS          PIC S9(8) COMP-4.
       01 WS-I                PIC S9(9) COMP-5.
       01 WS-END              PIC S9(8) COMP-4.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE SPACES TO WS-REQUEST
                          WS-RESPONSE
                          WS-LINE
           MOVE 1 TO WS-RESPONSE-PTR
           EXEC CICS WEB RECEIVE
               INTO(WS-REQUEST)
               LENGTH(WS-REQUEST-LEN)
               MAXLENGTH(8192)
           END-EXEC
           IF WS-REQUEST-LEN = 0
               MOVE 'ER' TO EQ-STATUS
               MOVE 'No request data.' TO EQ-ERROR
               PERFORM SEND-ERROR
               GO TO DONE
           END-IF
           PERFORM PARSE-REQUEST
           IF EQ-OP = SPACES
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Missing action.' TO EQ-ERROR
               PERFORM SEND-ERROR
               GO TO DONE
           END-IF
           IF EQ-ACTOR-ID = SPACES
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Missing actor.' TO EQ-ERROR
               PERFORM SEND-ERROR
               GO TO DONE
           END-IF
           CALL 'EQACT00' USING EQ-COMMAREA
           IF EQ-STATUS NOT = 'OK'
               PERFORM SEND-ERROR
               GO TO DONE
           END-IF
           EVALUATE EQ-OP
             WHEN 'ADD'
             WHEN 'SEARCH'
             WHEN 'RESERVE'
             WHEN 'MINE'
             WHEN 'MAINT'
             WHEN 'CANCEL'
               CALL 'EQOPS00' USING EQ-COMMAREA
             WHEN 'PICKUP'
             WHEN 'RETURN'
             WHEN 'HISTORY'
               CALL 'EQHND00' USING EQ-COMMAREA
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Unknown action.' TO EQ-ERROR
           END-EVALUATE
           IF EQ-STATUS NOT = 'OK'
               PERFORM SEND-ERROR
           ELSE
               PERFORM SEND-RESULT
           END-IF
           GO TO DONE.

       PARSE-REQUEST.
           MOVE 1 TO WS-POS
           PERFORM UNTIL WS-POS > WS-REQUEST-LEN
           MOVE SPACES TO WS-LINE
           MOVE 0 TO WS-LINE-LEN
           MOVE 0 TO WS-END
           MOVE WS-POS TO WS-END
           PERFORM UNTIL WS-END > WS-REQUEST-LEN
               IF WS-REQUEST(WS-END:1) = X'0A'
                   EXIT PERFORM
               END-IF
               ADD 1 TO WS-END
           END-PERFORM
           IF WS-END > WS-POS
               COMPUTE WS-LINE-LEN = WS-END - WS-POS
               MOVE WS-REQUEST(WS-POS:WS-LINE-LEN) TO WS-LINE(1:WS-LINE-LEN)
           END-IF
           IF WS-LINE-LEN > 0
               PERFORM PROCESS-LINE
           END-IF
           COMPUTE WS-POS = WS-END + 1
           IF WS-POS > WS-REQUEST-LEN
               EXIT PERFORM
           END-IF
           END-PERFORM.

       PROCESS-LINE.
           MOVE SPACES TO WS-KEY
                          WS-VALUE
           MOVE 1 TO WS-EQ-POS
           PERFORM UNTIL WS-EQ-POS > WS-LINE-LEN
               IF WS-LINE(WS-EQ-POS:1) = '='
                   EXIT PERFORM
               END-IF
               ADD 1 TO WS-EQ-POS
           END-PERFORM
           IF WS-EQ-POS > WS-LINE-LEN
               EXIT PARAGRAPH
           END-IF
           IF WS-EQ-POS > 1
               MOVE WS-LINE(1:WS-EQ-POS - 1) TO WS-KEY
           END-IF
           COMPUTE WS-LINE-LEN = WS-LINE-LEN - WS-EQ-POS
           IF WS-LINE-LEN > 0
               MOVE WS-LINE(WS-EQ-POS + 1:WS-LINE-LEN) TO WS-VALUE
           END-IF
           EVALUATE WS-KEY
             WHEN 'ACTION'
               MOVE WS-VALUE(1:12) TO EQ-OP
             WHEN 'ACTOR'
               MOVE WS-VALUE(1:12) TO EQ-ACTOR-ID
             WHEN 'EQUIP_ID'
               COMPUTE EQ-EQUIP-ID = FUNCTION NUMVAL(WS-VALUE)
             WHEN 'RSRV_ID'
               COMPUTE EQ-RSRV-ID = FUNCTION NUMVAL(WS-VALUE)
             WHEN 'USE_ID'
               COMPUTE EQ-USE-ID = FUNCTION NUMVAL(WS-VALUE)
             WHEN 'START'
               MOVE WS-VALUE(1:26) TO EQ-START-TS
             WHEN 'END'
               MOVE WS-VALUE(1:26) TO EQ-END-TS
             WHEN 'PICKUP'
               MOVE WS-VALUE(1:26) TO EQ-PICKUP-TS
             WHEN 'RETURN'
               MOVE WS-VALUE(1:26) TO EQ-RETURN-TS
             WHEN 'NAME'
               MOVE WS-VALUE(1:40) TO EQ-NAME
             WHEN 'DESCRIPTION'
               MOVE WS-VALUE(1:120) TO EQ-DESCRIPTION
             WHEN 'REASON'
               MOVE WS-VALUE(1:80) TO EQ-REASON
             WHEN OTHER
               CONTINUE
           END-EVALUATE.

       APPEND-LINE.
           STRING WS-LINE
               DELIMITED BY SIZE
               X'0A'
               DELIMITED BY SIZE
               INTO WS-RESPONSE
               POINTER WS-RESPONSE-PTR
           END-STRING.

       APPEND-KEY-VALUE.
           MOVE SPACES TO WS-LINE
           STRING WS-KEY
               '='
               WS-VALUE
               DELIMITED BY SIZE
               INTO WS-LINE
           END-STRING
           PERFORM APPEND-LINE.

       SEND-RESULT.
           MOVE SPACES TO WS-LINE
           STRING 'STATUS='
                   EQ-STATUS
                   DELIMITED BY SIZE
                   INTO WS-LINE
           END-STRING
           PERFORM APPEND-LINE
           EVALUATE EQ-OP
             WHEN 'ADD'
               MOVE 'EQUIP_ID' TO WS-KEY
               MOVE EQ-EQUIP-ID TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'SEARCH'
               PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > EQ-EQUIP-COUNT
                   MOVE 'EQUIP_ID' TO WS-KEY
                   MOVE EQ-EQ-ID(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
                   MOVE 'NAME' TO WS-KEY
                   MOVE EQ-EQ-NAME(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
                   MOVE 'AVAILABLE' TO WS-KEY
                   MOVE EQ-EQ-AVAILABLE(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
               END-PERFORM
             WHEN 'RESERVE'
               MOVE 'RSRV_ID' TO WS-KEY
               MOVE EQ-RSRV-ID TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'MINE'
               PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > EQ-RSRV-COUNT
                   MOVE 'RSRV_ID' TO WS-KEY
                   MOVE EQ-RV-ID(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
               END-PERFORM
             WHEN 'MAINT'
               MOVE 'INVALID_COUNT' TO WS-KEY
               MOVE EQ-INVALID-COUNT TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'CANCEL'
               MOVE 'STATE' TO WS-KEY
               MOVE EQ-STATE TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'PICKUP'
               MOVE 'USE_ID' TO WS-KEY
               MOVE EQ-USE-ID TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'RETURN'
               MOVE 'USE_ID' TO WS-KEY
               MOVE EQ-USE-ID TO WS-VALUE
               PERFORM APPEND-KEY-VALUE
             WHEN 'HISTORY'
               PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > EQ-RSRV-COUNT
                   MOVE 'RSRV_ID' TO WS-KEY
                   MOVE EQ-RV-ID(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
                   MOVE 'STATE' TO WS-KEY
                   MOVE EQ-RV-STATE(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
               END-PERFORM
               PERFORM VARYING WS-I FROM 1 BY 1
                   UNTIL WS-I > EQ-USE-COUNT
                   MOVE 'USE_ID' TO WS-KEY
                   MOVE EQ-USE-ID-ROW(WS-I) TO WS-VALUE
                   PERFORM APPEND-KEY-VALUE
               END-PERFORM
             WHEN OTHER
               CONTINUE
           END-EVALUATE
           COMPUTE WS-RESPONSE-LEN = WS-RESPONSE-PTR - 1
           EXEC CICS WEB SEND
               FROM(WS-RESPONSE)
               FROMLENGTH(WS-RESPONSE-LEN)
               MEDIATYPE('text/plain')
           END-EXEC.

       SEND-ERROR.
           MOVE SPACES TO WS-LINE
           STRING 'STATUS=ER'
               DELIMITED BY SIZE
               INTO WS-LINE
           END-STRING
           PERFORM APPEND-LINE
           MOVE SPACES TO WS-LINE
           STRING 'MESSAGE='
                   EQ-ERROR
                   DELIMITED BY SIZE
                   INTO WS-LINE
           END-STRING
           PERFORM APPEND-LINE
           COMPUTE WS-RESPONSE-LEN = WS-RESPONSE-PTR - 1
           EXEC CICS WEB SEND
               FROM(WS-RESPONSE)
               FROMLENGTH(WS-RESPONSE-LEN)
               MEDIATYPE('text/plain')
           END-EXEC.

       DONE.
           EXEC CICS RETURN END-EXEC.
