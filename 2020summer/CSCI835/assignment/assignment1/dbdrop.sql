spool dbdrop
SET ECHO OFF
SET ECHO ON
SET LINESIZE 200
SET WRAP OFF

DROP TABLE student PURGE;
DROP TABLE hotel PURGE;
DROP TABLE building PURGE;
DROP TABLE team PURGE;

COMMIT;
PROMPT Done.

spool off