SELECT EMPLOYEE_ID FROM ORDERS WHERE  ORDER_ID=308;

SELECT EMPLOYEE_ID FROM ORDERS WHERE  ORDER_ID=310;

UPDATE ORDERS
SET EMPLOYEE_ID=8
WHERE  ORDER_ID=308;

UPDATE ORDERS
SET EMPLOYEE_ID=1
WHERE  ORDER_ID=310;

COMMIT;