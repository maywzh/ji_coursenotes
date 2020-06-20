CREATE TABLE DEPARTMENT(
 DNAME        VARCHAR(14)       NOT NULL,
 BUDGET       DECIMAL(3)            NULL,
 CHAIRMAN     VARCHAR(30)       NOT NULL,
  CONSTRAINT DEPARTMENT_PKEY PRIMARY KEY(DNAME),
  CONSTRAINT DEPARTMENT_CKEY UNIQUE(CHAIRMAN),
  CONSTRAINT BUDGET CHECK (BUDGET >0 AND BUDGET <= 700) );

CREATE TABLE DEPTLOC(
 DNAME           VARCHAR(14)    NOT NULL,
 CITY            VARCHAR(13)    NOT NULL,
 STREET          DECIMAL(3)     NOT NULL,
 BLDG            DECIMAL(4)     NOT NULL,
 BLEVEL          DECIMAL(2)     NOT NULL,
  CONSTRAINT DEPTLOC_PKEY PRIMARY KEY(DNAME, CITY, STREET, BLDG, BLEVEL),
  CONSTRAINT DEPTLOC_FKEY FOREIGN KEY(DNAME) REFERENCES DEPARTMENT(DNAME) );

CREATE TABLE EMPLOYEE(
 ENUM            DECIMAL(4)     NOT NULL,
 ENAME           VARCHAR(10)    NOT NULL,
 MANAGER         DECIMAL(4)         NULL,
 HIREDATE        DATE           NOT NULL,
 SALARY          DECIMAL(7,2)   NOT NULL,
 COMM            DECIMAL(7,2)       NULL,
 DNAME           VARCHAR(14)        NULL,
 CITY            VARCHAR(13)        NULL,
 STREET          DECIMAL(3)         NULL,
 BLDG            DECIMAL(4)         NULL,
 BLEVEL          DECIMAL(2)         NULL,
  CONSTRAINT EMPLOYEE_PKEY PRIMARY KEY(ENUM),
  CONSTRAINT EMPLOYEE_FKEY1 FOREIGN KEY(DNAME) REFERENCES DEPARTMENT(DNAME),
  CONSTRAINT EMPLOYEE_FKEY2 FOREIGN KEY(DNAME,CITY,STREET,BLDG,BLEVEL) 
   REFERENCES DEPTLOC(DNAME,CITY,STREET,BLDG,BLEVEL) );
