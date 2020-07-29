/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*                                        Sample database                                               */
/*                                 Companies, Locations, Employees                                      */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
spool dbcreate
set echo on
set feedback on
set linesize 200
set pagesize 500

CREATE TABLE Department (
	DName		VARCHAR2(30)	NOT NULL, /* Department name		                        */
	Manager	        VARCHAR2(30)	NOT NULL, /* Department manager name	                        */
	MSDate		DATE, 			  /* Manager start date     	                        */
	E#              CHAR(5)         NOT NULL, /* A number of employee who is a member of department */
	CONSTRAINT Department_PK PRIMARY KEY(DName) );

CREATE TABLE DeptLocation (
	DName		VARCHAR(32)	NOT NULL, /* Department name		                        */
	Manager	        VARCHAR2(30)	NOT NULL, /* Department manager name	                        */	
	Address		VARCHAR2(50)	NOT NULL, /* Department location	                        */
	CONSTRAINT DeptLocation_PK PRIMARY KEY(DName, Address),
	CONSTRAINT DeptLocation_FK1 FOREIGN KEY(DName)
	                            REFERENCES Department(DName) );

CREATE TABLE Employee (
	E#		CHAR(5)		NOT NULL, /* Employee number    	                        */
	Name		VARCHAR2(30)	NOT NULL, /* Employee name		                        */
	DOB		Date            NOT NULL, /* Date of birth		                        */
	Supervisor#	CHAR(5),		  /* Supervisor number		                        */
	DName		VARCHAR(32), 		  /* Department number		                        */
	CONSTRAINT Employee_PK PRIMARY KEY(E#),
	CONSTRAINT Employee_FK1 FOREIGN KEY (Supervisor#) REFERENCES Employee(E#),
	CONSTRAINT Employee_FK2 FOREIGN KEY (DName) REFERENCES Department (DName) );

spool off
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
