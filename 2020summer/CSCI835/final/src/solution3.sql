spool solution3
set echo on
set feedback on
set linesize 100
set pagesize 200
SET SERVEROUTPUT ON

-- drop the trigger if it exists
DECLARE 
  l_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO l_count
  FROM user_triggers
  WHERE TRIGGER_NAME = 'MODIFYEMPLOYEEDEPT';

  IF l_count > 0 THEN
     EXECUTE IMMEDIATE 'DROP TRIGGER ModifyEmployeeDept';
  END IF;
END;
/

-- Create PL/SQL procedure
CREATE OR REPLACE PROCEDURE INSERT_NEW_EMPLOYEE(E#_ IN Employee.E#%TYPE, Name_ IN Employee.Name%TYPE, DOB_ IN Employee.DOB%TYPE, Supervisor#_ IN Employee.Supervisor#%TYPE, DName_ IN Employee.DName%TYPE) IS tne_ Department.TNE%TYPE;
BEGIN
  INSERT INTO Employee VALUES(E#_ , Name_, DOB_, Supervisor#_, DName_); 
  SELECT COUNT(*) INTO tne_ FROM Employee WHERE DName = DName_;
  UPDATE Department d SET TNE = tne_ WHERE d.Dname = DName_;
  COMMIT;
END INSERT_NEW_EMPLOYEE;
/

SELECT TNE FROM Department WHERE DName='Product Development Department';
EXECUTE INSERT_NEW_EMPLOYEE('RX590', 'Linda A. Hughes', TO_DATE('12-12-2013', 'DD-MM-YYYY'), 'AE798', 'Product Development Department');
SELECT TNE FROM Department WHERE DName='Product Development Department';

spool off