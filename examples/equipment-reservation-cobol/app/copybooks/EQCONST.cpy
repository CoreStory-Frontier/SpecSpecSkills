      ******************************************************************
      * Shared operation and state constants.
      ******************************************************************
       01 EQ-CONSTANTS.
          05 EQ-OP-ADD             PIC X(12) VALUE 'ADD'.
          05 EQ-OP-SEARCH          PIC X(12) VALUE 'SEARCH'.
          05 EQ-OP-RESERVE         PIC X(12) VALUE 'RESERVE'.
          05 EQ-OP-MINE            PIC X(12) VALUE 'MINE'.
          05 EQ-OP-MAINT           PIC X(12) VALUE 'MAINT'.
          05 EQ-OP-CANCEL          PIC X(12) VALUE 'CANCEL'.
          05 EQ-OP-PICKUP          PIC X(12) VALUE 'PICKUP'.
          05 EQ-OP-RETURN          PIC X(12) VALUE 'RETURN'.
          05 EQ-OP-HISTORY         PIC X(12) VALUE 'HISTORY'.
          05 EQ-OP-CATALOG         PIC X(12) VALUE 'CATALOG'.
          05 EQ-OP-CONTEXT         PIC X(12) VALUE 'CONTEXT'.
          05 EQ-STATE-CONFIRMED    PIC X(10) VALUE 'CONFIRMED'.
          05 EQ-STATE-INVALID      PIC X(10) VALUE 'INVALID'.
          05 EQ-STATE-CANCELLED    PIC X(10) VALUE 'CANCELLED'.
          05 EQ-STATE-COMPLETED    PIC X(10) VALUE 'COMPLETED'.
