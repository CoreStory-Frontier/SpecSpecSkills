* Build the Equipment Reservation VFP9 project.
* Run from the example root in Visual FoxPro 9.

SET SAFETY OFF
SET PATH TO app\programs;app;data;web
BUILD PROJECT equipment_reservation FROM ;
    app\setup.prg, ;
    app\programs\EQACT.PRG, ;
    app\programs\EQCAT.PRG, ;
    app\programs\EQDB.PRG, ;
    app\programs\EQSHED.PRG, ;
    app\programs\EQOPS.PRG, ;
    app\programs\EQHAND.PRG, ;
    app\programs\EQWEB.PRG, ;
    app\tests\EQTEST.PRG
BUILD EXE equipment_reservation.EXE FROM equipment_reservation
