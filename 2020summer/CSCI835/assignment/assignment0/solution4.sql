spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment0/solution4.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON

DELETE FROM visit
WHERE hname = 'Delta Hotel' and hcity = 'Toronto';

DELETE FROM hotel
WHERE hname = 'Delta Hotel' and city = 'Toronto';

UPDATE traveller t 
SET visitedhotels_num = (
    SELECT COUNT(*) FROM visit WHERE t.pnum = pnum GROUP BY (pnum, nationality)
);

UPDATE visit v 
SET arrival_date = TO_DATE('01-JUN-2019', 'DD-MON-YYYY')
WHERE pnum='152483045685' AND nationality = 'China' AND hname = 'Kyono Mori Yurinsha' AND hcity = 'Kyoto' AND arrival_date = TO_DATE('3-JUNE-2019', 'DD-MON-YYYY');

--COMMIT;

PROMPT solution4.sql done.
spool off