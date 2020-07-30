spool solution3
set echo on
set feedback on
set linesize 100
set pagesize 200
SET SERVEROUTPUT ON

-- drop the trigger if it exists
declare 
  l_count integer;
begin

  select count(*)
    into l_count
  from user_triggers
  where trigger_name = 'ModifyEmployeeDept';

  if l_count > 0 then 
     execute immediate 'drop trigger ModifyEmployeeDept';
  end if;
end;
/

-- Create PL/SQL procedure


spool off