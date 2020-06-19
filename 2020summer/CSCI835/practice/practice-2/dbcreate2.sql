CREATE TABLE Bank (
	BSB		CHAR(6)		NOT NULL, 
	Name		VARCHAR(40)	NOT NULL, 
	Address		VARCHAR(50)	NOT NULL, 
	Manager		CHAR(5)		NOT NULL, 
	MSDate		DATE,
	Phone		VARCHAR(15)	NOT NULL,
	CONSTRAINT Bank_PK PRIMARY KEY(BSB),
	CONSTRAINT Bank_CK1 UNIQUE(Name)
);

CREATE TABLE Employee (
	BSB		CHAR(6), 
	Eno		CHAR(5)		NOT NULL,
	Name		VARCHAR(30)	NOT NULL,
	DOB		Date,
	Address		VARCHAR(50),
	Sex		CHAR,
	Salary		DECIMAL(7,2),
	Supervisor	CHAR(5),
	CONSTRAINT Employee_PK PRIMARY KEY(BSB, Eno),
	CONSTRAINT Employee_FK1 FOREIGN KEY (BSB) REFERENCES Bank (BSB)
);

CREATE TABLE Customer (
	BSB		CHAR(6)		NOT NULL, 
	Customerno	DECIMAL(10,0)	NOT NULL, 
	Name		VARCHAR(30)	NOT NULL, 
	DOB		Date,
	Sex		CHAR,
	Address		VARCHAR(50)	NOT NULL, 
	Phone		VARCHAR(15), 
	CONSTRAINT Customer_PK PRIMARY KEY(BSB, Customerno),
	CONSTRAINT Customer_FK FOREIGN KEY (BSB) REFERENCES Bank(BSB)
);

CREATE TABLE Account (
	BSB		CHAR(6)		NOT NULL, 
	Customerno	DECIMAL(10,0)	NOT NULL, 
	Accountno	DECIMAL(10,0)	NOT NULL, 
	Type		VARCHAR(20)	NOT NULL, 
	Balance		DECIMAL(8,2)	NOT NULL, 
	CONSTRAINT WorksOn_PK PRIMARY KEY(BSB, Accountno),
	CONSTRAINT WorksOn_FK1 FOREIGN KEY(BSB, Customerno) REFERENCES Customer(BSB, Customerno)
);


CREATE TABLE Dependent (
	BSB		CHAR(6)		NOT NULL, 
	Eno		CHAR(5)		NOT NULL, 
	DName		VARCHAR(30)	NOT NULL, 
	Sex		CHAR,
	DOB		DATE,
	Relationship	VARCHAR(10),
	CONSTRAINT Dependent_PK PRIMARY KEY(BSB, Eno, DName),
	CONSTRAINT Dependent_FK FOREIGN KEY(BSB, Eno) REFERENCES Employee(BSB, Eno),
	CONSTRAINT Dependent_Check CHECK (Relationship IN ('CHILD', 'SPOUSE', 'PARENT'))
);

