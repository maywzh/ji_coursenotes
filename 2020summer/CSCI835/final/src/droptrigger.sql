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