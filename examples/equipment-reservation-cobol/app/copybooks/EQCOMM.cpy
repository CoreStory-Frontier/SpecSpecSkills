      ******************************************************************
      * Equipment Reservation shared module contract.
      * One record is passed between Web Interaction, Actor Access,
      * Scheduling Operations, Schedule Management, Equipment Catalog,
      * and Equipment Use Management.
      ******************************************************************
       01 EQ-COMMAREA.
          05 EQ-OP                 PIC X(12).
          05 EQ-ACTOR-ID           PIC X(12).
          05 EQ-EQUIP-ID           PIC S9(9) COMP-5.
          05 EQ-RSRV-ID            PIC S9(9) COMP-5.
          05 EQ-USE-ID             PIC S9(9) COMP-5.
          05 EQ-START-TS           PIC X(26).
          05 EQ-END-TS              PIC X(26).
          05 EQ-PICKUP-TS           PIC X(26).
          05 EQ-RETURN-TS           PIC X(26).
          05 EQ-NAME                PIC X(40).
          05 EQ-DESCRIPTION         PIC X(120).
          05 EQ-REASON              PIC X(80).

          05 EQ-EMPLOYEE-ROLE       PIC X.
             88 EQ-EMPLOYEE-YES    VALUE 'Y'.
          05 EQ-CUSTODIAN-ROLE      PIC X.
             88 EQ-CUSTODIAN-YES   VALUE 'Y'.
          05 EQ-AUTHORIZED         PIC X.
             88 EQ-AUTHORIZED-YES  VALUE 'Y'.
          05 EQ-AVAILABLE          PIC X.
             88 EQ-AVAILABLE-YES   VALUE 'Y'.
          05 EQ-STATE              PIC X(10).
          05 EQ-STATUS             PIC X(2).
             88 EQ-STATUS-OK       VALUE 'OK'.
             88 EQ-STATUS-ERROR    VALUE 'ER'.
          05 EQ-MESSAGE            PIC X(160).
          05 EQ-ERROR              PIC X(160).

          05 EQ-EQUIP-COUNT        PIC S9(9) COMP-5.
          05 EQ-EQUIP-ROWS         OCCURS 50 TIMES.
             10 EQ-EQ-ID           PIC S9(9) COMP-5.
             10 EQ-EQ-NAME         PIC X(40).
             10 EQ-EQ-DESC         PIC X(120).
             10 EQ-EQ-AVAILABLE    PIC X.

          05 EQ-RSRV-COUNT         PIC S9(9) COMP-5.
          05 EQ-RSRV-ROWS          OCCURS 50 TIMES.
             10 EQ-RV-ID           PIC S9(9) COMP-5.
             10 EQ-RV-EQUIP-ID     PIC S9(9) COMP-5.
             10 EQ-RV-ACTOR-ID     PIC X(12).
             10 EQ-RV-START-TS     PIC X(26).
             10 EQ-RV-END-TS      PIC X(26).
             10 EQ-RV-STATE        PIC X(10).

          05 EQ-USE-COUNT           PIC S9(9) COMP-5.
          05 EQ-USE-ROWS           OCCURS 50 TIMES.
             10 EQ-USE-ID-ROW      PIC S9(9) COMP-5.
             10 EQ-USE-RSRV-ID     PIC S9(9) COMP-5.
             10 EQ-USE-EQUIP-ID    PIC S9(9) COMP-5.
             10 EQ-USE-ACTOR-ID    PIC X(12).
             10 EQ-USE-PICKUP-TS   PIC X(26).
             10 EQ-USE-RETURN-TS   PIC X(26).

          05 EQ-INVALID-COUNT       PIC S9(9) COMP-5.
          05 EQ-INVALID-ROWS        OCCURS 50 TIMES.
             10 EQ-INVALID-RSRV-ID PIC S9(9) COMP-5.
