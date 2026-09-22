      ******************************************************************
      * EQACT00 — Actor Access Module.
      * Obtains fixed demo actor roles and authorizes one operation.
      * Production integration point: replace the EQP_ACTR lookup with the
      * approved external workforce identity source.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EQACT00.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY EQSQLCA.
       LINKAGE SECTION.
       COPY EQCOMM.
       PROCEDURE DIVISION USING EQ-COMMAREA.

       MAIN-PARA.
           MOVE 'N' TO EQ-EMPLOYEE-ROLE
                      EQ-CUSTODIAN-ROLE
                      EQ-AUTHORIZED
           EVALUATE EQ-OP
             WHEN 'CONTEXT'
               PERFORM LOAD-ACTOR
               MOVE 'Y' TO EQ-AUTHORIZED
             WHEN 'ADD'
             WHEN 'MAINT'
             WHEN 'CANCEL'
             WHEN 'PICKUP'
             WHEN 'RETURN'
             WHEN 'HISTORY'
               PERFORM LOAD-ACTOR
               IF EQ-CUSTODIAN-ROLE = 'Y'
                   MOVE 'Y' TO EQ-AUTHORIZED
               ELSE
                   MOVE 'N' TO EQ-AUTHORIZED
               END-IF
             WHEN 'SEARCH'
             WHEN 'RESERVE'
             WHEN 'MINE'
               PERFORM LOAD-ACTOR
               IF EQ-EMPLOYEE-ROLE = 'Y'
                   MOVE 'Y' TO EQ-AUTHORIZED
               ELSE
                   MOVE 'N' TO EQ-AUTHORIZED
               END-IF
             WHEN OTHER
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Unknown operation.' TO EQ-ERROR
               GO TO DONE
           END-EVALUATE
           IF EQ-STATUS = SPACES
               MOVE 'OK' TO EQ-STATUS
           ELSE
               MOVE 'N' TO EQ-AUTHORIZED
           END-IF
           GO TO DONE.

       LOAD-ACTOR.
           EXEC SQL
               SELECT EMPLOYEE_ROLE, CUSTODIAN_ROLE
                   INTO :EQ-EMPLOYEE-ROLE, :EQ-CUSTODIAN-ROLE
                   FROM EQP_ACTR
                   WHERE ACTOR_ID = :EQ-ACTOR-ID
           END-EXEC
           EVALUATE SQLCODE
             WHEN 0
               CONTINUE
             WHEN 100
               MOVE 'N' TO EQ-EMPLOYEE-ROLE
                              EQ-CUSTODIAN-ROLE
                              EQ-AUTHORIZED
               MOVE 'ER' TO EQ-STATUS
               MOVE 'Actor is not known.' TO EQ-ERROR
             WHEN OTHER
               MOVE 'N' TO EQ-EMPLOYEE-ROLE
                              EQ-CUSTODIAN-ROLE
                              EQ-AUTHORIZED
               MOVE 'ER' TO EQ-STATUS
               STRING 'Actor lookup failed. SQLCODE='
                   SQLCODE
                   DELIMITED BY SIZE
                   INTO EQ-ERROR
           END-EVALUATE.

       DONE.
           GOBACK.
