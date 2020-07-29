spool solution1
set echo on
set feedback on
set linesize 200
set pagesize 500

CREATE TABLE Department (
	DName		VARCHAR2(30)	NOT NULL, /* Department name		                        */
	Manager	        VARCHAR2(30)	NOT NULL, /* Department manager name	                        */
	MSDate		DATE, 			  /* Manager start date     	                        */
	CONSTRAINT Department_PK PRIMARY KEY(DName) );

CREATE TABLE DeptLocation (
	DName		VARCHAR(32)	NOT NULL, /* Department name		                        */
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
	CONSTRAINT Employee_FK2 FOREIGN KEY (DName) REFERENCES Department (DName));

INSERT INTO Department VALUES ('Product Development Department', 'Eugene N. Betts', TO_DATE('12-12-2013', 'DD-MM-YYYY') );

INSERT INTO DeptLocation VALUES ('Product Development Department', 'Atlanta');
INSERT INTO DeptLocation VALUES ('Product Development Department', 'Portland');

INSERT INTO Employee VALUES('AE798', 'Connie N. Seager', TO_DATE('05-01-1984', 'DD-MM-YYYY'), NULL, 'Product Development Department');
INSERT INTO Employee VALUES('TX987', 'Lynn J. Skinner', TO_DATE('06-10-1992', 'DD-MM-YYYY'), 'AE798', 'Product Development Department');
spool off
