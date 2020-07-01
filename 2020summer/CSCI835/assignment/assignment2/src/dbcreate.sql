set echo on
set feedback on
set linesize 300

spool dbcreate

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE CATEGORY
(
    CATEGORY_NAME 	VARCHAR(30)	NOT NULL,
    DESCRIPTION 	VARCHAR(2000)       NULL,
    PICTURE 		VARCHAR(255)        NULL,
    CONSTRAINT PK_CATEGORY PRIMARY KEY (CATEGORY_NAME)
);

COMMENT ON COLUMN CATEGORY.CATEGORY_NAME IS 'Name of food category.';
COMMENT ON COLUMN CATEGORY.PICTURE IS 'A picture representing the food category.';				    

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE CUSTOMER
(
    CUSTOMER_CODE 	VARCHAR(5)	NOT NULL,
    COMPANY_NAME 	VARCHAR(40)	NOT NULL,
    CONTACT_NAME 	VARCHAR(30)         NULL,      
    CONTACT_TITLE 	VARCHAR(30)         NULL,
    ADDRESS 		VARCHAR(60)         NULL,
    CITY 		VARCHAR(15)         NULL,
    REGION 		VARCHAR(15)         NULL,
    POSTAL_CODE 	VARCHAR(10)         NULL,
    COUNTRY 		VARCHAR(15)         NULL,
    PHONE 		VARCHAR(24)         NULL,
    FAX 		VARCHAR(24)         NULL,
    CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUSTOMER_CODE)
);

COMMENT ON COLUMN CUSTOMER.CUSTOMER_CODE IS 'Unique five-character code based on customer name.';
COMMENT ON COLUMN CUSTOMER.ADDRESS IS 'Street or post-office box.';
COMMENT ON COLUMN CUSTOMER.REGION IS 'State or province.';
COMMENT ON COLUMN CUSTOMER.PHONE IS 'Phone number includes country code or area code.';
COMMENT ON COLUMN CUSTOMER.FAX IS 'Phone number includes country code or area code.';                  

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE EMPLOYEE
(
    EMPLOYEE_ID		NUMBER(9)	NOT NULL,
    LASTNAME 		VARCHAR(20) 	NOT NULL,
    FIRSTNAME 		VARCHAR(10) 	NOT NULL,
    TITLE 		VARCHAR(30)         NULL,
    TITLE_OF_COURTESY 	VARCHAR(25)         NULL,
    BIRTHDATE 		DATE                NULL,
    HIREDATE 		DATE                NULL,
    ADDRESS 		VARCHAR(60)         NULL,
    CITY 		VARCHAR(15)         NULL,
    REGION 		VARCHAR(15)         NULL,
    POSTAL_CODE 	VARCHAR(10)         NULL,
    COUNTRY 		VARCHAR(15)         NULL,
    HOME_PHONE 		VARCHAR(24)         NULL,
    EXTENSION 		VARCHAR(4)          NULL,
    PHOTO 		VARCHAR(255)        NULL,
    NOTES 		VARCHAR(2000)       NULL,
    REPORTS_TO 		NUMBER(9)           NULL,
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EMPLOYEE_ID)
);

COMMENT ON COLUMN EMPLOYEE.EMPLOYEE_ID IS 'Number assigned to new employee.';
COMMENT ON COLUMN EMPLOYEE.TITLE IS 'Employee''s title.';
COMMENT ON COLUMN EMPLOYEE.TITLE_OF_COURTESY IS 'Title used in salutations.';
COMMENT ON COLUMN EMPLOYEE.ADDRESS IS 'Street or post-office box.';
COMMENT ON COLUMN EMPLOYEE.REGION IS 'State or province.';
COMMENT ON COLUMN EMPLOYEE.HOME_PHONE IS 'Phone number includes country code or area code.';
COMMENT ON COLUMN EMPLOYEE.EXTENSION IS 'Internal telephone extension number.';
COMMENT ON COLUMN EMPLOYEE.PHOTO IS 'Picture of employee.';
COMMENT ON COLUMN EMPLOYEE.NOTES IS 'General information about employee''s background.';
COMMENT ON COLUMN EMPLOYEE.REPORTS_TO IS 'Employee''s supervisor.';						  

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE SUPPLIER
(
    COMPANY_NAME 	VARCHAR(40)	NOT NULL,
    CONTACT_NAME 	VARCHAR(30)         NULL,
    CONTACT_TITLE 	VARCHAR(30)         NULL,
    ADDRESS 		VARCHAR(60)         NULL,
    CITY 		VARCHAR(15)         NULL,
    REGION 		VARCHAR(15)         NULL,
    POSTAL_CODE 	VARCHAR(10)         NULL,
    COUNTRY 		VARCHAR(15)         NULL,
    PHONE 		VARCHAR(24)         NULL,
    FAX 		VARCHAR(24)         NULL,
    HOME_PAGE 		VARCHAR(500)        NULL,
    CONSTRAINT PK_SUPPLIER PRIMARY KEY (COMPANY_NAME)  
);

COMMENT ON COLUMN SUPPLIER.COMPANY_NAME IS 'Name of supplying company.';
COMMENT ON COLUMN SUPPLIER.ADDRESS IS 'Street or post-office box.';
COMMENT ON COLUMN SUPPLIER.REGION IS 'State or province.';
COMMENT ON COLUMN SUPPLIER.PHONE IS 'Phone number includes country code or area code.';
COMMENT ON COLUMN SUPPLIER.FAX IS 'Phone number includes country code or area code.';
COMMENT ON COLUMN SUPPLIER.HOME_PAGE IS 'Supplier''s home page on World Wide Web.';				    

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
CREATE TABLE SHIPPER
(
    COMPANY_NAME 	VARCHAR(40)	NOT NULL,
    PHONE 		VARCHAR(24)         NULL,
    CONSTRAINT PK_SHIPPER PRIMARY KEY (COMPANY_NAME),
    CONSTRAINT CK_SHIPPER UNIQUE (PHONE)
);

COMMENT ON COLUMN SHIPPER.COMPANY_NAME IS 'Name of shipping company.';
COMMENT ON COLUMN SHIPPER.PHONE IS 'Phone number includes country code or area code.';                         

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE PRODUCT
(
    PRODUCT_NAME 	VARCHAR(40) 	NOT NULL,
    SUPPLIER_NAME	VARCHAR(40) 	NOT NULL,
    CATEGORY_NAME	VARCHAR(30)	NOT NULL,
    QUANTITY_PER_UNIT 	VARCHAR(20)         NULL,
    UNIT_PRICE 		NUMBER(10,2)	DEFAULT 0,
    UNITS_IN_STOCK 	NUMBER(9) 	DEFAULT 0,
    UNITS_ON_ORDER 	NUMBER(9) 	DEFAULT 0,
    REORDER_LEVEL 	NUMBER(9) 	DEFAULT 0,
    DISCONTINUED 	CHAR(1)		DEFAULT 'N',
    CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_NAME),
    CONSTRAINT FK_CATEGORY_NAME FOREIGN KEY (CATEGORY_NAME) REFERENCES CATEGORY(CATEGORY_NAME),
    CONSTRAINT FK_SUPPLIER_NAME FOREIGN KEY (SUPPLIER_NAME) REFERENCES SUPPLIER(COMPANY_NAME),
    CONSTRAINT CK_PRODUCT_UNIT_PRICE CHECK (UNIT_PRICE >= 0),
    CONSTRAINT CK_PRODUCT_UNITS_IN_STOCK CHECK (UNITS_IN_STOCK >= 0),
    CONSTRAINT CK_PRODUCT_UNITS_ON_ORDER CHECK (UNITS_ON_ORDER >= 0),
    CONSTRAINT CK_PRODUCT_REORDER_LEVEL CHECK (REORDER_LEVEL >= 0),
    CONSTRAINT CK_PRODUCT_DISCONTINUED CHECK (DISCONTINUED in ('Y','N'))
);
  
COMMENT ON COLUMN PRODUCT.SUPPLIER_NAME IS 'Same entry as in Suppliers table.';
COMMENT ON COLUMN PRODUCT.CATEGORY_NAME IS 'Same entry as in Categories table.';
COMMENT ON COLUMN PRODUCT.QUANTITY_PER_UNIT IS '(e.g., 24-count case, 1-liter bottle).';
COMMENT ON COLUMN PRODUCT.REORDER_LEVEL IS 'Minimum units to maintain in stock.';
COMMENT ON COLUMN PRODUCT.DISCONTINUED IS 'Yes means item is no longer available.';			


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
CREATE TABLE ORDERS
(
    ORDER_ID		NUMBER(9)	NOT NULL,
    CUSTOMER_CODE 	VARCHAR(5) 	NOT NULL,
    EMPLOYEE_ID 	NUMBER(9) 	NOT NULL,
    ORDER_DATE 		DATE 	   	NOT NULL,
    REQUIRED_DATE 	DATE,
    SHIPPED_DATE 	DATE,
    SHIP_VIA 		VARCHAR(40),
    FREIGHT 		NUMBER(10,2)	DEFAULT 0,
    SHIP_NAME 		VARCHAR(40),
    SHIP_ADDRESS 	VARCHAR(60),
    SHIP_CITY 		VARCHAR(15),
    SHIP_REGION 	VARCHAR(15),
    SHIP_POSTAL_CODE 	VARCHAR(10),
    SHIP_COUNTRY 	VARCHAR(15),
    CONSTRAINT PK_ORDERS PRIMARY KEY (ORDER_ID),
    CONSTRAINT FK_CUSTOMER_CODE FOREIGN KEY (CUSTOMER_CODE) REFERENCES CUSTOMER(CUSTOMER_CODE),  
    CONSTRAINT FK_EMPLOYEE_ID FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),  
    CONSTRAINT FK_SHIP_VIA FOREIGN KEY (SHIP_VIA) REFERENCES SHIPPER(COMPANY_NAME)  
);

COMMENT ON COLUMN ORDERS.ORDER_ID IS 'Unique order number.';
COMMENT ON COLUMN ORDERS.CUSTOMER_CODE IS 'Same entry as in Customers table.';
COMMENT ON COLUMN ORDERS.EMPLOYEE_ID IS 'Same entry as in Employees table.';
COMMENT ON COLUMN ORDERS.SHIP_VIA IS 'Same as Company name in Shippers table.';
COMMENT ON COLUMN ORDERS.SHIP_NAME IS 'Name of person or company to receive the shipment.';
COMMENT ON COLUMN ORDERS.SHIP_ADDRESS IS 'Street address only -- no post-office box allowed.';
COMMENT ON COLUMN ORDERS.SHIP_REGION IS 'State or province.';						  

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE ORDER_DETAIL
(
    ORDER_ID		 NUMBER(9)	NOT NULL,
    PRODUCT_NAME         VARCHAR(40) 	NOT NULL,
    UNIT_PRICE 		 NUMBER(10,2)   DEFAULT 0.0,
    QUANTITY 		 NUMBER(9)	DEFAULT 1,
    DISCOUNT 		 NUMBER(4,2)	DEFAULT 0.0,
    CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (ORDER_ID, PRODUCT_NAME),
    CONSTRAINT FK_ORDER_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
    CONSTRAINT FK_PRODUCT_NAME FOREIGN KEY (PRODUCT_NAME) REFERENCES PRODUCT (PRODUCT_NAME),
    CONSTRAINT CK_ORDER_DETAIL_UNIT_PRICE CHECK (UNIT_PRICE >= 0), 
    CONSTRAINT CK_ORDER_DETAIL_QUANTITY CHECK (QUANTITY > 0),
    CONSTRAINT CK_ORDER_DETAIL_DISCOUNT CHECK (DISCOUNT between 0 and 1) 
);

COMMENT ON COLUMN ORDER_DETAIL.UNIT_PRICE IS 'Unit price of product';
COMMENT ON COLUMN ORDER_DETAIL.QUANTITY IS 'Quantity ordered.';
COMMENT ON COLUMN ORDER_DETAIL.QUANTITY IS 'Discount applied.';					

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

spool off
