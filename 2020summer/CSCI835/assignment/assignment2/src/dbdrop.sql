set echo on
set feedback on
set linesize 300

spool dbdrop
ALTER TABLE PRODUCT
DROP COLUMN ORDERED_NUM;
DROP PROCEDURE INSERT_ORDER_DETAIL;
DROP TRIGGER "MAYWZH"."ORDERPRODUCT";


DROP TABLE ORDER_DETAIL;
DROP TABLE ORDERS;
DROP TABLE PRODUCT;
DROP TABLE SUPPLIER;
DROP TABLE CATEGORY;
DROP TABLE CUSTOMER;
DROP TABLE EMPLOYEE;
DROP TABLE SHIPPER;

spool off
