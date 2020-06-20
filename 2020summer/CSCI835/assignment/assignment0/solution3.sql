spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment0/solution3.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON

ALTER TABLE traveller
ADD visitedhotels_num INT;

UPDATE traveller t 
SET visitedhotels_num = (
    SELECT COUNT(*) FROM visit WHERE t.pnum = pnum GROUP BY (pnum, nationality)
);

ALTER TABLE visit
ADD hcountry VARCHAR(30);

UPDATE visit v
SET hcountry = (
    SELECT country FROM hotel WHERE v.hname = hname AND v.hcity = city
);

COMMIT;

PROMPT solution3.sql done.
spool off