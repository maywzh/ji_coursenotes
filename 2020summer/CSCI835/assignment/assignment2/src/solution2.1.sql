SPOOL /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment2/src/solution2.lst

SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 100
SET PAGESIZE 200
SET SERVEROUTPUT ON

EXEC INSERT_ORDER_DETAIL(383, 'Perth Pasties', 32.8, 10, 0);
EXEC INSERT_ORDER_DETAIL(383, 'Lakkalikoori', 16.2, 10, 0.1);

SPOOL OFF