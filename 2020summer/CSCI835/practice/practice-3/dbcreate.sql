CREATE TABLE EMPLOYEE(
ENUM 	 DECIMAL(12)	NOT NULL,
FNAME	 VARCHAR(50)	NOT NULL,
INITIALS VARCHAR(5)	    NULL,
LNAME    VARCHAR(50)    NOT NULL,
DOB 	 DATE		    NULL,
BLDG     DECIMAL(3) 	NOT NULL,
STREET   VARCHAR(50)	NOT NULL,
SUBURB   VARCHAR(50)	NOT NULL,
STATE	 VARCHAR(5)	NOT NULL,
ZIPCODE  DECIMAL(4)	NOT NULL,
	 CONSTRAINT EMPLOYEE_PKEY PRIMARY KEY(ENUM) );

INSERT INTO EMPLOYEE VALUES( 1, 'John', NULL, 'Smith', NULL, 42, 'Victoria St.', 'Hurstville', 'NSW', 2456 );
INSERT INTO EMPLOYEE VALUES( 2, 'Peter', NULL, 'Taylor', TO_DATE('1970-01-12','YYYY-MM-DD'), 42, 'Victoria St.', 'Hurstville', 'NSW', 2456 );
INSERT INTO EMPLOYEE VALUES( 3, 'John', NULL, 'Doe', TO_DATE('1966-03-23','YYYY-MM-DD'), 12, 'Station St.', 'Dapto', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 4, 'John', NULL, 'Gray', TO_DATE('1988-05-05','YYYY-MM-DD'), 16, 'Station St.', 'Dapto', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 5, 'Adam', NULL, 'Taylor', TO_DATE('1980-01-01','YYYY-MM-DD'), 42, 'Church St.', 'City', 'NSW', 2300 );
INSERT INTO EMPLOYEE VALUES( 6, 'Michael', NULL, 'Jones', TO_DATE('1975-03-05','YYYY-MM-DD'), 23, 'Waterloo Ave.', 'Surry Hills', 'NSW', 2502 );
INSERT INTO EMPLOYEE VALUES( 7, 'Frederic', NULL, 'Jones', NULL, 3, 'Victoria St.', 'Redfern', 'NSW', 2420 );
INSERT INTO EMPLOYEE VALUES( 8, 'Peter', NULL, 'O''Brien', TO_DATE('1983-02-28','YYYY-MM-DD'), 19, 'Lucas Dr.', 'Horsley', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 9, 'John', NULL, 'Lucas', TO_DATE('1966-12-16','YYYY-MM-DD'), 20, 'Huxley St.', 'Horsley', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 10, 'John', NULL, 'Fox', TO_DATE('1975-10-15','YYYY-MM-DD'), 18, 'Victoria St.', 'Hurstville', 'NSW', 2456 );
INSERT INTO EMPLOYEE VALUES( 11, 'Adam', NULL, 'Fox', NULL, 45, 'Victoria St.', 'Hurstville', 'NSW', 2456 );
INSERT INTO EMPLOYEE VALUES( 12, 'Phillip', NULL, ',Cox', TO_DATE('1984-12-12','YYYY-MM-DD'), 5, 'The Avenue', 'Rockdale', 'NSW', 2300 );
INSERT INTO EMPLOYEE VALUES( 13, 'Andrew', 'K', 'Smith', TO_DATE('1969-04-04','YYYY-MM-DD'), 42, 'Bambaramba Ave.', 'Pennant Hills', 'NSW', 2556 );
INSERT INTO EMPLOYEE VALUES( 14, 'Andrew', 'R', 'Smith', TO_DATE('1992-04-01','YYYY-MM-DD'), 67, 'King Cr.', 'Hurstville', 'NSW', 2456 );
INSERT INTO EMPLOYEE VALUES( 15, 'Michael', NULL, 'Potter', TO_DATE('1995-04-01','YYYY-MM-DD'), 568, 'Bong Bong St.', 'Horsley', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 16, 'Harry', NULL, 'Potter', TO_DATE('1995-04-01','YYYY-MM-DD'), 568, 'Bong Bong St.', 'Horsley', 'NSW', 2530 );
INSERT INTO EMPLOYEE VALUES( 17, 'James', NULL, 'Bond', NULL, 007, 'Alan Bond St.', 'Perth', 'WA', 6000 );
INSERT INTO EMPLOYEE VALUES( 18, 'Paris', NULL, 'Hilton', NULL, 1, 'Hilton St.', 'Melbourne', 'Vic', 3000 );
INSERT INTO EMPLOYEE VALUES( 19, 'Lady', NULL, 'Gaga', NULL, 3, 'Pork st.', 'Hobart', 'Tas', 7000 );
INSERT INTO EMPLOYEE VALUES( 20, 'Robin', NULL, 'Hood', NULL, 6, 'Nottingham Pl.', 'Sydney', 'NSW', 2000 );

CREATE TABLE DRIVER(
ENUM 	DECIMAL(12)      NOT NULL,
LNUM 	DECIMAL(8) 	NOT NULL,
STATUS 	VARCHAR(10) 	NOT NULL,
	CONSTRAINT DRIVER_PKEY PRIMARY KEY(ENUM),
        CONSTRAINT DRIVER_UNIQUE UNIQUE(LNUM),
        CONSTRAINT DRIVER_FKEY FOREIGN KEY(ENUM) REFERENCES EMPLOYEE(ENUM),
	CONSTRAINT DRIVER_STATUS CHECK ( STATUS IN ('AVAILABLE', 'BUSY', 'ON LEAVE')) );

INSERT INTO DRIVER VALUES( 1, 10001, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 2, 10008, 'ON LEAVE' );
INSERT INTO DRIVER VALUES( 3, 10002, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 4, 10004, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 5, 10003, 'ON LEAVE' );
INSERT INTO DRIVER VALUES( 6, 10012, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 7, 20002, 'BUSY' );
INSERT INTO DRIVER VALUES( 8, 20003, 'BUSY' );
INSERT INTO DRIVER VALUES( 9, 30005, 'BUSY' );
INSERT INTO DRIVER VALUES( 10, 40002, 'BUSY' );
INSERT INTO DRIVER VALUES( 11, 20045, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 12, 20055, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 13, 20065, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 14, 10305, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 15, 10345, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 16, 10705, 'AVAILABLE' );
INSERT INTO DRIVER VALUES( 17, 40005, 'AVAILABLE' );


CREATE TABLE ADMIN(
ENUM 	 DECIMAL(12)      NOT NULL,
POSITION VARCHAR(50) 	 NOT NULL,
	CONSTRAINT ADMIN_PKEY PRIMARY KEY(ENUM),
        CONSTRAINT ADMIN_FKEY FOREIGN KEY(ENUM) REFERENCES EMPLOYEE(ENUM) );

INSERT INTO ADMIN VALUES( 18, 'SUPPORT' );
INSERT INTO ADMIN VALUES( 19, 'DIRECTOR' );
INSERT INTO ADMIN VALUES( 20, 'CEO' );


CREATE TABLE TRUCK(
REGNUM 	VARCHAR(10) 	NOT NULL,
CAPACITY DECIMAL(7) 	NOT NULL,
WEIGHT 	DECIMAL(5) 	NOT NULL,
STATUS 	VARCHAR(10) 	NOT NULL,
	CONSTRAINT TRUCK_PKEY PRIMARY KEY(REGNUM),
	CONSTRAINT TRUCK_STATUS CHECK ( STATUS IN ('AVAILABLE', 'USED', 'MAINTAINED')) );

INSERT INTO TRUCK VALUES( 'PKR768', 1234, 3000, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'SST005', 12000, 50000, 'USED' );
INSERT INTO TRUCK VALUES( 'QRT834', 5550, 400, 'USED' );
INSERT INTO TRUCK VALUES( 'LUCY01', 100, 300, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'KKK007', 10000, 3000, 'MAINTAINED' );
INSERT INTO TRUCK VALUES( 'SYF777', 3333, 4566, 'MAINTAINED' );
INSERT INTO TRUCK VALUES( 'PKR008', 22000, 8800, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'XCF003', 30000, 10000, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'GFT008', 40000, 15000, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'LUCY02', 43000, 3000, 'AVAILABLE' );
INSERT INTO TRUCK VALUES( 'AL08UK', 50000, 5000, 'AVAILABLE' );


CREATE TABLE TRIP(
TNUM 	DECIMAL(10) 	NOT NULL,
LNUM 	DECIMAL(8) 	NOT NULL,
REGNUM 	VARCHAR(10) 	NOT NULL,
TRIP_DATE DATE 		NOT NULL,
	CONSTRAINT TRIP_PKEY PRIMARY KEY (TNUM),
	CONSTRAINT TRIP_FKEY1 FOREIGN KEY (LNUM) REFERENCES DRIVER(LNUM),
	CONSTRAINT TRIP_FKEY2 FOREIGN KEY (REGNUM) REFERENCES TRUCK(REGNUM) );

INSERT INTO TRIP VALUES( 1, 10001, 'PKR768', TO_DATE('2015-01-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 2, 10001, 'SYF777', TO_DATE('2015-02-20','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 3, 10001, 'KKK007', TO_DATE('2015-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 4, 10001, 'PKR768', TO_DATE('2015-06-29','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 5, 20002, 'PKR768', TO_DATE('2015-01-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 6, 10002, 'SYF777', TO_DATE('2015-02-20','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 7, 30005, 'KKK007', TO_DATE('2015-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 8, 10001, 'PKR768', TO_DATE('2015-01-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES( 9, 10002, 'QRT834', TO_DATE('2015-09-17','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(10, 30005, 'KKK007', TO_DATE('2015-12-15','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(11, 10003, 'SST005', TO_DATE('2016-01-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(12, 10002, 'PKR768', TO_DATE('2016-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(13, 20002, 'QRT834', TO_DATE('2015-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(14, 20002, 'PKR008', TO_DATE('2015-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(15, 30005, 'PKR768', TO_DATE('2015-05-24','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(16, 30005, 'SST005', TO_DATE('2014-08-02','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(17, 20002, 'QRT834', TO_DATE('2014-09-17','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(18, 10001, 'KKK007', TO_DATE('2014-12-15','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(19, 30005, 'SST005', TO_DATE('2016-01-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(20, 10003, 'PKR768', TO_DATE('2016-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(21, 10001, 'QRT834', TO_DATE('2012-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(22, 30005, 'PKR008', TO_DATE('2012-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(23, 10003, 'PKR768', TO_DATE('2012-05-25','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(24, 20002, 'SST005', TO_DATE('2012-08-02','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(25, 10001, 'PKR768', TO_DATE('2014-01-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(26, 10001, 'SYF777', TO_DATE('2013-02-20','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(27, 20002, 'KKK007', TO_DATE('2013-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(28, 30005, 'PKR768', TO_DATE('2010-06-29','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(29, 10001, 'QRT834', TO_DATE('2010-09-17','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(30, 10002, 'KKK007', TO_DATE('2010-12-15','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(31, 10003, 'SST005', TO_DATE('2010-01-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(32, 20002, 'PKR768', TO_DATE('2010-03-12','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(33, 30005, 'QRT834', TO_DATE('2003-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(34, 30005, 'PKR008', TO_DATE('2004-04-23','YYYY-MM-DD'));
INSERT INTO TRIP VALUES(35, 10001, 'PKR768', TO_DATE('2016-05-24','YYYY-MM-DD'));



CREATE TABLE TRIPLEG(
TNUM 	DECIMAL(10) 	NOT NULL,
LEGNUM 	DECIMAL(2) 	NOT NULL,
DEPARTURE VARCHAR(30) 	NOT NULL,
DESTINATION VARCHAR(30) NOT NULL,
CONSTRAINT TRIPLEG_PKEY PRIMARY KEY (TNUM, LEGNUM),
        CONSTRAINT TRIPLEG_UNIQUE UNIQUE(TNUM, DEPARTURE, DESTINATION),
	CONSTRAINT TRIPLEG_FKEY1 FOREIGN KEY (TNUM) REFERENCES TRIP(TNUM) );

INSERT INTO TRIPLEG VALUES( 1, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES( 1, 2, 'Melbourne', 'Hobart');
INSERT INTO TRIPLEG VALUES( 1, 3, 'Hobart', 'Perth');
INSERT INTO TRIPLEG VALUES( 1, 4, 'Perth', 'Adelaide');
INSERT INTO TRIPLEG VALUES( 1, 5, 'Adelaide', 'Wollongong');
INSERT INTO TRIPLEG VALUES( 2, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES( 3, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES( 4, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES( 5, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES( 6, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES( 7, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES( 8, 1, 'Sydney', 'Newcastle');
INSERT INTO TRIPLEG VALUES( 8, 2, 'Newcastle', 'Brisbane');
INSERT INTO TRIPLEG VALUES( 8, 3, 'Brisbane', 'Perth');
INSERT INTO TRIPLEG VALUES( 9, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(10, 1, 'Sydney', 'Wollongong');
INSERT INTO TRIPLEG VALUES(11, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(12, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(13, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(13, 2, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(14, 1, 'Wollongong', 'Sydney');
INSERT INTO TRIPLEG VALUES(15, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(16, 1, 'Sydney', 'Wollongong');
INSERT INTO TRIPLEG VALUES(17, 1, 'Sydney', 'Wollongong');
INSERT INTO TRIPLEG VALUES(17, 2, 'Wollongong', 'Sydney');
INSERT INTO TRIPLEG VALUES(18, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(19, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(20, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(21, 1, 'Wollongong', 'Sydney');
INSERT INTO TRIPLEG VALUES(22, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(23, 1, 'Wollongong', 'Sydney');
INSERT INTO TRIPLEG VALUES(24, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(25, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(25, 2, 'Sydney', 'Perth');
INSERT INTO TRIPLEG VALUES(25, 3, 'Perth', 'Sydney');
INSERT INTO TRIPLEG VALUES(25, 4, 'Sydney', 'Brisbane');
INSERT INTO TRIPLEG VALUES(26, 1, 'Brisbane', 'Sydney'); 
INSERT INTO TRIPLEG VALUES(27, 1, 'Sydney', 'Wollongong');
INSERT INTO TRIPLEG VALUES(28, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(28, 2, 'Melbourne', 'Perth');
INSERT INTO TRIPLEG VALUES(29, 1, 'Sydney', 'Perth');
INSERT INTO TRIPLEG VALUES(30, 1, 'Melbourne', 'Sydney');
INSERT INTO TRIPLEG VALUES(30, 2, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(31, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(32, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(33, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(34, 1, 'Wollongong', 'Sydney');
INSERT INTO TRIPLEG VALUES(35, 1, 'Sydney', 'Melbourne');
INSERT INTO TRIPLEG VALUES(35, 2, 'Melbourne', 'Adelaide');
INSERT INTO TRIPLEG VALUES(35, 3, 'Adelaide', 'Perth');
INSERT INTO TRIPLEG VALUES(35, 4, 'Perth', 'Sydney');

COMMIT;
