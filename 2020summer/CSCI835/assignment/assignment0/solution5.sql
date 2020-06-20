spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment0/solution5.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON

SELECT DISTINCT t.fname, t.lname
FROM traveller t 
    INNER JOIN visit v ON t.pnum = v.pnum AND t.nationality = v.nationality 
    INNER JOIN hotel h ON v.hname = h.hname and v.hcity = h.city
WHERE h.star = 4;

SELECT hname, (SELECT COUNT(*) FROM visit v WHERE v.hname = h.hname AND v.hcity = h.city) as visitors_num
FROM hotel h;

SELECT hname as visitors_num
FROM hotel h
WHERE (SELECT COUNT(*) FROM visit v WHERE v.hname = h.hname AND v.hcity = h.city) = 0;

SELECT lname from traveller 
UNION
SELECT hname from hotel;

--COMMIT;

PROMPT solution5.sql done.
spool off