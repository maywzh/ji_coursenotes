
SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON


SELECT COUNT(pnum, nationality) FROM visit GROUP BY (hname, hcity);

SELECT hotel.country FROM (traveller INNER JOIN visit ON traveller.pnum = visit.pnum AND traveller.nationality = visit.nationality) INNER JOIN hotel ON hotel.hname = visit.hname AND hotel.city = visit.hcity GROUP BY (traveller.pnum,  traveller.nationality, visit.hname, visit.hcity)

PROMPT solution3.sql done.
spool off