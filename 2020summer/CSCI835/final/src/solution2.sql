spool solution2
set echo on
set feedback on
set linesize 100
set pagesize 200
SET SERVEROUTPUT ON

ALTER TABLE Department
ADD TNE NUMBER(9) DEFAULT 0; --Total Number of Employee

UPDATE Department d SET TNE = nvl((SELECT count(E#) AS tne FROM Employee e WHERE e.Dname = d.Dname), 0);

-- CREATE OR REPLACE TRIGGER ModifyEmployeeDept
-- AFTER INSERT OR DELETE OR UPDATE ON Employee
-- FOR EACH ROW
-- BEGIN
--   IF DELETING THEN
--     UPDATE Department d SET TNE = nvl((SELECT count(E#) AS tne FROM Employee e WHERE e.Dname = d.Dname), 0) WHERE d.Dname = :OLD.Dname;
--   ELSIF UPDATING THEN
--     IF (:OLD.Dname != :NEW.Dname) THEN
--       UPDATE Department d SET TNE = nvl((SELECT count(E#) AS tne FROM Employee e WHERE e.Dname = d.Dname), 0) WHERE d.Dname = :OLD.Dname OR Dname = :NEW.Dname;
--     END IF;
--   ELSE
--     UPDATE Department d SET TNE = nvl((SELECT count(E#) AS tne FROM Employee e WHERE e.Dname = d.Dname), 0) WHERE d.Dname = :NEW.Dname;
--   END IF;
-- END;
-- /

CREATE OR REPLACE TRIGGER ModifyEmployeeDept
AFTER INSERT OR DELETE OR UPDATE ON Employee
BEGIN
  UPDATE Department d SET TNE = nvl((SELECT count(E#) FROM Employee e WHERE e.Dname = d.Dname), 0);
END;
/


INSERT INTO Department VALUES ('Business Department', 'Kenneth J. Willis', TO_DATE('09-12-2015', 'DD-MM-YYYY'), 0);

INSERT INTO DeptLocation VALUES ('Business Department', 'Albany');
INSERT INTO DeptLocation VALUES ('Business Department', 'New York');

SELECT TNE FROM Department WHERE Dname = 'Business Department';
INSERT INTO Employee VALUES('YH391', 'Gregory M. Platt', TO_DATE('05-03-1972', 'DD-MM-YYYY'), NULL, 'Business Department');
INSERT INTO Employee VALUES('TI867', 'Richard J. Reed', TO_DATE('04-12-1992', 'DD-MM-YYYY'), 'YH391', 'Business Department');
INSERT INTO Employee VALUES('GX689', 'Pat R. Mejia', TO_DATE('01-12-1987', 'DD-MM-YYYY'), 'YH391', 'Business Department');
SELECT TNE FROM Department WHERE Dname = 'Business Department';

DELETE FROM Employee
WHERE E#='GX689';

SELECT TNE FROM Department WHERE Dname = 'Business Department';

UPDATE Employee
SET Dname='Product Development Department', Supervisor#='AE798'
WHERE E#='TI867';
SELECT TNE FROM Department WHERE Dname = 'Business Department';

spool off