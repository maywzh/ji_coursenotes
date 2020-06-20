SPOOL dbcreate
SET ECHO OFF
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Title:          Sample database
   Script name:    dbcreate.sql
   Task:           To create and to load a sample database for CSCI835 Test pereparations
   Created by:	   Janusz R. Getta     
   Created on:	   23 June 2018
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

SET ECHO ON
SET LINESIZE 200
SET WRAP OFF

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
/* Lookup tables                                                        */
/*									*/

CREATE TABLE SKILL(
sname	      VARCHAR(30)     NOT NULL, /* Skill name          		*/
	CONSTRAINT SKILL_pkey PRIMARY KEY ( sname ) );

INSERT INTO SKILL VALUES ( 'CORBA programming' );
INSERT INTO SKILL VALUES ( 'C++ programming' );
INSERT INTO SKILL VALUES ( 'C programming' );
INSERT INTO SKILL VALUES ( 'Java programming' );
INSERT INTO SKILL VALUES ( 'database design' );
INSERT INTO SKILL VALUES ( 'SQL programming' );
INSERT INTO SKILL VALUES ( 'database administration' );
INSERT INTO SKILL VALUES ( 'painting' );
INSERT INTO SKILL VALUES ( 'cooking' );
INSERT INTO SKILL VALUES ( 'driving' );
INSERT INTO SKILL VALUES ( 'network administration' );
INSERT INTO SKILL VALUES ( 'Web design' );
INSERT INTO SKILL VALUES ( 'PHP programming' );
INSERT INTO SKILL VALUES ( 'accounting' );
INSERT INTO SKILL VALUES ( 'bricklaying' );
INSERT INTO SKILL VALUES ( 'concreting' );
INSERT INTO SKILL VALUES ( 'reading' );
INSERT INTO SKILL VALUES ( 'writing' );
INSERT INTO SKILL VALUES ( 'thinking' );

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
CREATE TABLE SREQUIRED(
sname	      VARCHAR(30)     NOT NULL, /* Skill name          		*/
requires      VARCHAR(30)     NOT NULL, /* Skill required		*/
slevel        NUMBER(2)	      NOT NULL, /* Level required		*/
	CONSTRAINT SREQUIRED_pkey PRIMARY KEY ( sname, requires ),
	CONSTRAINT SREQUIRED_fkey1 FOREIGN KEY ( sname)
		REFERENCES SKILL( sname ),
	CONSTRAINT SREQUIRED_fkey2 FOREIGN KEY ( requires )
		REFERENCES SKILL( sname ) );

INSERT INTO SREQUIRED VALUES ( 'CORBA programming', 'C++ programming', 5);
INSERT INTO SREQUIRED VALUES ( 'C++ programming', 'C programming', 5);
INSERT INTO SREQUIRED VALUES ( 'Java programming', 'C programming', 5);
INSERT INTO SREQUIRED VALUES ( 'PHP programming', 'C programming', 5);
INSERT INTO SREQUIRED VALUES ( 'C programming', 'reading', 10);
INSERT INTO SREQUIRED VALUES ( 'C programming', 'writing', 10);
INSERT INTO SREQUIRED VALUES ( 'database administration', 'SQL programming', 8 );
INSERT INTO SREQUIRED VALUES ( 'network administration', 'reading', 10);
INSERT INTO SREQUIRED VALUES ( 'network administration', 'writing', 10);
INSERT INTO SREQUIRED VALUES ( 'accounting', 'reading', 10);
INSERT INTO SREQUIRED VALUES ( 'accounting', 'writing', 10);
INSERT INTO SREQUIRED VALUES ( 'SQL programming', 'reading', 5 );
INSERT INTO SREQUIRED VALUES ( 'SQL programming', 'writing', 5 );
INSERT INTO SREQUIRED VALUES ( 'SQL programming', 'thinking', 10 );

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
/* Relational tables implementing classes of objects			*/
/*									*/
CREATE TABLE APPLICANT(			  /* Applicants			*/
anumber         NUMBER(6)       NOT NULL, /* Applicant number           */
fname           VARCHAR(20)     NOT NULL, /* First name                 */
lname		VARCHAR(30)	NOT NULL, /* Last name			*/
dob         	DATE     	NOT NULL, /* Date of birth		*/
city		VARCHAR(30)	NOT NULL, /* City			*/
state		VARCHAR(20)	NOT NULL, /* State			*/
phone		NUMBER(10)	NOT NULL, /* Phone number		*/
fax		NUMBER(10)		, /* Fax number			*/
email		VARCHAR(50)		, /* E-mail address		*/
	CONSTRAINT APPLICANT_pkey PRIMARY KEY ( anumber ) );

INSERT INTO APPLICANT VALUES ( 000001, 'Harry', 'Potter', TO_DATE('12-DEC-1980', 'DD-MON-YYYY'), 'Perth', 'Western Australia', 645278453, NULL, 'jones@gmail.com' );
INSERT INTO APPLICANT VALUES ( 000002, 'Johnny', 'Walker', TO_DATE('13-FEB-1990', 'DD-MON-YYYY'), 'Geelong', 'Victoria', 63569784, 63569785, 'blunder@hotmail.com' );
INSERT INTO APPLICANT VALUES ( 000003, 'Mary', 'Poppins', TO_DATE('01-JAN-1950', 'DD-MON-YYYY'), 'Melbourne', 'Victoria', 62389541, NULL, NULL );
INSERT INTO APPLICANT VALUES ( 000004, 'Michael', 'Collins', TO_DATE('25-MAY-1960', 'DD-MON-YYYY'), 'Brisbane', 'Queensland', 63336666, NULL, 'mike@hotmail.com');
INSERT INTO APPLICANT VALUES ( 000005, 'Margaret', 'Finch', TO_DATE('07-DEC-1953', 'DD-MON-YYYY'), 'Sydney','New South Wales', 64573489, NULL, 'mf@163.com');
INSERT INTO APPLICANT VALUES ( 000006, 'Claudia', 'Kowalewski', TO_DATE('03-MAY-1959', 'DD-MON-YYYY'), 'Hobart', 'Tasmania', 64577744, NULL, 'cch@cs.odmg.org');
INSERT INTO APPLICANT VALUES ( 000007, 'James', 'Bond', TO_DATE('01-JAN-1960','DD-MON-YYYY'),'Perth', 'Western Australia', 645278434, NULL, 'james@bigpond.com');
INSERT INTO APPLICANT VALUES ( 000008, 'Stephen', 'Staunton', TO_DATE('23-OCT-1977', 'DD-MON-YYYY'), 'Freemantle', 'Western Australia', 623778453, NULL, 'stephen@gmail.com');
INSERT INTO APPLICANT VALUES ( 000009, 'Joseph', 'Staunton', TO_DATE('23-OCT-1977', 'DD-MON-YYYY'), 'Newcastle', 'New South Wales', 623778453, NULL, 'joseph@gmail.com' );
INSERT INTO APPLICANT VALUES ( 0000010, 'John', 'Spiderman', TO_DATE('21-JUN-1990', 'DD-MON-YYYY'), 'Sydney', 'New South Wales', 24256789, 12345679, 'spider@yahoo.com');
INSERT INTO APPLICANT VALUES ( 0000011, 'George', 'TheFirst', TO_DATE('12-OCT-1991', 'DD-MON-YYYY'), 'Melbourne', 'Victoria', 2345987, NULL, 'g1st@hotmail.com');
INSERT INTO APPLICANT VALUES ( 0000012, 'Homer', 'Simpson', TO_DATE('24-MAY-1957', 'DD-MON-YYYY'), 'Adelaide', 'South Australia', 6134569876, NULL, 'homer@gmail.com');
INSERT INTO APPLICANT VALUES ( 0000013, 'Neil', 'Superman', TO_DATE('20-JUL-1960', 'DD-MON-YYYY'), 'Perth', 'Western Australia', 4567892345, 61343568, 'superneil@gmail.com');
INSERT INTO APPLICANT VALUES ( 0000014, 'Ivan', 'TheTerrible', TO_DATE('11-MAY-1969', 'DD-MON-YYYY'), 'Brisbane', 'Queensland', 1234567898, NULL, 'ivan@yahoo.com');
INSERT INTO APPLICANT VALUES ( 0000015, 'Penelope', 'Princess', TO_DATE('23-OCT-1977', 'DD-MON-YYYY'), 'Hobart', 'Tasmania', 4007678911, NULL, 'pprincess@163.com');
INSERT INTO APPLICANT VALUES ( 0000016, 'Zhi Chao', 'Zhong', TO_DATE('21-JUN-1971', 'DD-MON-YYYY'), 'Horsley', 'New South Wales', 8615016189, NULL, 'suezhong@163.com');
INSERT INTO APPLICANT VALUES ( 0000017, 'Richard', 'TheLionheart', TO_DATE('02-JUN-1981', 'DD-MON-YYYY'), 'Waga Waga', 'New South Wales', 6134234567, NULL, 'rlion@hotmail.com');
INSERT INTO APPLICANT VALUES ( 0000018, 'Sherlock', 'Holmes', TO_DATE('13-JUN-1935', 'DD-MON-YYYY'), 'Bundaberg', 'Queensland', 4667667701, NULL, 'holmes@162.com');
INSERT INTO APPLICANT VALUES ( 0000019, 'Robin', 'Hood', TO_DATE('21-AUG-1951', 'DD-MON-YYYY'), 'Horsley', 'New South Wales', 86150329, NULL, 'robinhood@163.com');
INSERT INTO APPLICANT VALUES ( 0000020, 'Janusz', 'Getta', TO_DATE('03-OCT-1953', 'DD-MON-YYYY'), 'Horsley', 'New South Wales', 12345678, 12345679, 'jrg@uow.edu.au');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
CREATE TABLE EMPLOYER(			  /* Employers			*/
ename        	VARCHAR(100)    NOT NULL, /* Employer name              */
city            VARCHAR(30)     NOT NULL, /* City                       */
state           VARCHAR(20)     NOT NULL, /* State                      */
phone           NUMBER(10)      NOT NULL, /* Phone number               */
fax             NUMBER(10)              , /* Fax number                 */
email           VARCHAR(50)             , /* E-mail address             */
web             VARCHAR(50)             , /* Web site address           */
        CONSTRAINT EMPLOYER_pkey PRIMARY KEY ( ename ) );

INSERT INTO EMPLOYER VALUES ( 'University of Sydney', 'Sydney', 'New South Wales', 612345678, NULL, 'admin@uos.edu', 'www.uos.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Western Sydney', 'Western Sydney', 'New South Wales', 612345678, NULL, 'muws@uws.edu.au', 'www.uws.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Wollongong', 'Wollongong', 'New South Wales', 6124243689, 6124234569, 'admin@uow.edu.au', 'www.uow.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of New South Wales', 'Sydney', 'New South Wales', 6129874574, 6123454445, 'adm@unsw.edu.au', 'www.unsw.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Technology, Sydney', 'Sydney', 'New South Wales', 6125646872, NULL, 'postmaster@uts.edu.au', 'www.uts.edu.au');
INSERT INTO EMPLOYER VALUES ( 'Macquarie University', 'Sydney', 'New South Wales', 6125646346, NULL, 'main@mcq.edu.au', 'www.mcq.edu.au');
INSERT INTO EMPLOYER VALUES ( 'Monash University', 'Melbourne', 'Victoria', 6134567932, NULL, 'admin@monash.edu.au', 'www.monash.edu.au');
INSERT INTO EMPLOYER VALUES ( 'La Trobe University', 'Melbourne', 'Victoria', 6136677899, NULL, NULL, 'www.latrobe.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Melbourne', 'Melbourne', 'Victoria', 6131234567, 6132345678, 'admin@uom.edu.au', 'www.uom.edu.au');
INSERT INTO EMPLOYER VALUES ( 'RMIT', 'Melbourne', 'Victoria', 6135050607, NULL, NULL, 'www.rmit.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Queensland', 'Brisbane', 'Queeensland', 615333445, 6154465678, 'admin@uq.edu.au', 'www.uq.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Adelaide', 'Adelaide', 'South Australia', 6172222567, 6172341278, 'main@uoa.edu.au', 'www.uoa.edu.au');
INSERT INTO EMPLOYER VALUES ( 'Murdoch University', 'Perth', 'Western Australia', 6182234588, NULL, 'admin@murdoch.edu.au', 'www.murdoch.edu.au');
INSERT INTO EMPLOYER VALUES ( 'Curtin University', 'Perth', 'Western Australia', 6182222567, NULL, 'main@curtin.edu.au', 'www.uoa.edu.au');
INSERT INTO EMPLOYER VALUES ( 'University of Western Australia','Perth', 'Western Australia', 6189876543, 6133341278, 'main@uowa.edu.au', 'www.uowa.edu.au');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
CREATE TABLE EMPLBY(			  /* Former employers		*/
anumber         NUMBER(6)       NOT NULL, /* Applicant number           */
ename		VARCHAR(100)	NOT NULL, /* Employer name		*/
fromdate	DATE		NOT NULL, /* Employed from		*/
todate		DATE			, /* Employed to		*/
	CONSTRAINT EMPLBY_pkey PRIMARY KEY ( anumber, ename, fromdate ),
	CONSTRAINT EMPLBY_fkey1 FOREIGN KEY ( anumber ) 
		REFERENCES APPLICANT( anumber ),
	CONSTRAINT EMPLBY_fkey2 FOREIGN KEY ( ename ) 
		REFERENCES EMPLOYER( ename ) );

INSERT INTO EMPLBY VALUES ( 000001, 'University of Sydney', TO_DATE('01-FEB-2000', 'DD-MON-YYYY'),TO_DATE('05-JUN-2008', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000001, 'Curtin University', TO_DATE('01-FEB-2000', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000002, 'University of Western Sydney', TO_DATE('20-FEB-2009', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000003, 'University of Wollongong', TO_DATE('01-JAN-1977', 'DD-MON-YYYY'), TO_DATE('31-DEC-1980', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000003, 'University of New South Wales', TO_DATE('01-JAN-1981', 'DD-MON-YYYY'), TO_DATE('31-DEC-1990', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000003, 'Monash University', TO_DATE('01-JAN-1991', 'DD-MON-YYYY'), TO_DATE('31-AUG-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000003, 'RMIT', TO_DATE('21-JUN-2000', 'DD-MON-YYYY'), NULL ); 
INSERT INTO EMPLBY VALUES ( 000004, 'University of New South Wales', TO_DATE('01-MAY-1985', 'DD-MON-YYYY'), TO_DATE('22-APR-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000004, 'La Trobe University', TO_DATE('01-MAY-2005', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000005, 'University of Technology, Sydney', TO_DATE('01-DEC-1977', 'DD-MON-YYYY'), TO_DATE('01-JUN-1980', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000005, 'University of Adelaide', TO_DATE('01-JULY-1980', 'DD-MON-YYYY'), TO_DATE('31-DEC-1990', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000005, 'University of Queensland', TO_DATE('01-JAN-1991', 'DD-MON-YYYY'), TO_DATE('30-MAR-1996', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000005, 'RMIT', TO_DATE('01-DEC-1996', 'DD-MON-YYYY'), TO_DATE('01-JUN-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000005, 'University of Queensland', TO_DATE('01-DEC-2005', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000006, 'University of Technology, Sydney', TO_DATE('01-DEC-1979', 'DD-MON-YYYY'), TO_DATE('01-JUN-1985', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000006, 'University of Adelaide', TO_DATE('01-APR-1986', 'DD-MON-YYYY'), TO_DATE('01-JUN-1987', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000006, 'University of Queensland', TO_DATE('01-DEC-1987', 'DD-MON-YYYY'), TO_DATE('07-JUN-2001', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000006, 'RMIT', TO_DATE('31-DEC-2001', 'DD-MON-YYYY'), TO_DATE('01-JUN-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000006, 'University of Queensland', TO_DATE('01-JUL-2010', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000007, 'Macquarie University', TO_DATE('01-JAN-1980','DD-MON-YYYY'), TO_DATE('31-JAN-2000','DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000007, 'Monash University', TO_DATE('03-MAY-2001', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 000008, 'La Trobe University', TO_DATE('01-OCT-1990', 'DD-MON-YYYY'), TO_DATE('30-MAY-1995', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000008, 'University of Adelaide', TO_DATE('01-MAY-1997', 'DD-MON-YYYY'), TO_DATE('31-OCT-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000008, 'Murdoch University', TO_DATE('01-JAN-2000', 'DD-MON-YYYY'), TO_DATE('31-OCT-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000008, 'Curtin University', TO_DATE('01-MAY-2005', 'DD-MON-YYYY'), TO_DATE('31-DEC-2009', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000009, 'La Trobe University', TO_DATE('01-OCT-1990', 'DD-MON-YYYY'), TO_DATE('30-MAY-1995', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000009, 'University of Adelaide', TO_DATE('01-MAY-1997', 'DD-MON-YYYY'), TO_DATE('31-OCT-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000009, 'Murdoch University', TO_DATE('01-JAN-2000', 'DD-MON-YYYY'), TO_DATE('31-OCT-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000009, 'Curtin University', TO_DATE('01-MAY-2005', 'DD-MON-YYYY'), TO_DATE('31-DEC-2009', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 000009, 'La Trobe University', TO_DATE('01-OCT-2010', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000010, 'RMIT', TO_DATE('01-JAN-2011', 'DD-MON-YYYY'), TO_DATE('31-JAN-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000010, 'Murdoch University', TO_DATE('01-FEB-2011', 'DD-MON-YYYY'), TO_DATE('31-MAR-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000010, 'RMIT', TO_DATE('01-APR-2011', 'DD-MON-YYYY'), TO_DATE('31-MAY-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000010, 'Murdoch University', TO_DATE('01-JUN-2011', 'DD-MON-YYYY'), TO_DATE('30-NOV-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000010, 'RMIT', TO_DATE('01-DEC-2011', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000011, 'University of Queensland', TO_DATE('01-OCT-2010', 'DD-MON-YYYY'), TO_DATE('31-DEC-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Adelaide', TO_DATE('01-APR-1999', 'DD-MON-YYYY'), TO_DATE('01-JUN-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Queensland', TO_DATE('01-JUL-1999', 'DD-MON-YYYY'), TO_DATE('10-JUL-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'RMIT', TO_DATE('01-AUG-1999', 'DD-MON-YYYY'), TO_DATE('31-AUG-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'Macquarie University', TO_DATE('01-SEP-1999','DD-MON-YYYY'), TO_DATE('31-DEC-1999','DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'Monash University', TO_DATE('01-JAN-2001', 'DD-MON-YYYY'), TO_DATE('02-JAN-2001', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'La Trobe University', TO_DATE('03-JAN-2001', 'DD-MON-YYYY'), TO_DATE('30-MAY-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Adelaide', TO_DATE('01-APR-2006', 'DD-MON-YYYY'), TO_DATE('08-JUN-2006', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Queensland', TO_DATE('31-DEC-2006', 'DD-MON-YYYY'), TO_DATE('07-JUN-2007', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'RMIT', TO_DATE('31-DEC-2008', 'DD-MON-YYYY'), TO_DATE('01-JUN-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Queensland', TO_DATE('01-JUL-2011', 'DD-MON-YYYY'), TO_DATE('31-JUL-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'Macquarie University', TO_DATE('01-AUG-2011','DD-MON-YYYY'), TO_DATE('31-OCT-2011','DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'Monash University', TO_DATE('01-NOV-2011', 'DD-MON-YYYY'), TO_DATE('03-NOV-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000012, 'University of Adelaide', TO_DATE('05-DEC-2011', 'DD-MON-YYYY'), TO_DATE('31-DEC-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000013, 'Murdoch University', TO_DATE('20-JUL-1985', 'DD-MON-YYYY'), TO_DATE('31-DEC-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000014, 'Curtin University', TO_DATE('01-MAY-1991', 'DD-MON-YYYY'), TO_DATE('31-DEC-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000014, 'Murdoch University', TO_DATE('01-JAN-2010', 'DD-MON-YYYY'), TO_DATE('30-MAY-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000014, 'University of Adelaide', TO_DATE('01-JUN-2010', 'DD-MON-YYYY'), TO_DATE('31-OCT-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000014, 'Murdoch University', TO_DATE('01-JAN-2011', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000015, 'University of Western Australia', TO_DATE('01-OCT-2007', 'DD-MON-YYYY'), TO_DATE('01-OCT-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000015, 'University of Technology, Sydney', TO_DATE('01-DEC-2010', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000016, 'Curtin University', TO_DATE('01-JUN-2001', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000017, 'La Trobe University', TO_DATE('01-JUN-2009', 'DD-MON-YYYY'), TO_DATE('01-JUL-2009', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000017, 'University of New South Wales', TO_DATE('01-DEC-2009', 'DD-MON-YYYY'), TO_DATE('31-DEC-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000017, 'University of Technology, Sydney', TO_DATE('01-JAN-2011', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000018, 'Monash University', TO_DATE('01-JUN-1965', 'DD-MON-YYYY'), TO_DATE('01-JUN-1975', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'RMIT', TO_DATE('01-SEP-1975', 'DD-MON-YYYY'), TO_DATE('01-APR-1980', 'DD-MON-YYYY') ); 
INSERT INTO EMPLBY VALUES ( 0000018, 'University of New South Wales', TO_DATE('01-MAY-1982', 'DD-MON-YYYY'), TO_DATE('20-SEP-1983', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'La Trobe University', TO_DATE('21-SEP-1983', 'DD-MON-YYYY'), TO_DATE('01-JUN-1985', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Technology, Sydney', TO_DATE('02-JUN-1985', 'DD-MON-YYYY'), TO_DATE('01-DEC-1990', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Adelaide', TO_DATE('01-JULY-1991', 'DD-MON-YYYY'), TO_DATE('31-DEC-1992', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Queensland', TO_DATE('01-JAN-1993', 'DD-MON-YYYY'), TO_DATE('30-MAR-1996', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'RMIT', TO_DATE('01-DEC-1996', 'DD-MON-YYYY'), TO_DATE('01-JUN-1997', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Sydney', TO_DATE('01-FEB-1998', 'DD-MON-YYYY'),TO_DATE('07-JUN-1999', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'Curtin University', TO_DATE('01-FEB-2000', 'DD-MON-YYYY'), TO_DATE('01-JUN-2001', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Western Sydney', TO_DATE('20-FEB-2002', 'DD-MON-YYYY'), TO_DATE('01-JUN-2003', 'DD-MON-YYYY'));
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Wollongong', TO_DATE('01-JAN-2004', 'DD-MON-YYYY'), TO_DATE('31-DEC-2004', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of New South Wales', TO_DATE('01-JAN-2005', 'DD-MON-YYYY'), TO_DATE('31-DEC-2005', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'Monash University', TO_DATE('01-JAN-2006', 'DD-MON-YYYY'), TO_DATE('31-AUG-2007', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'RMIT', TO_DATE('21-JUN-2008', 'DD-MON-YYYY'), TO_DATE('30-JUN-2008', 'DD-MON-YYYY') ); 
INSERT INTO EMPLBY VALUES ( 0000018, 'University of New South Wales', TO_DATE('01-MAY-2009', 'DD-MON-YYYY'), TO_DATE('13-APR-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'La Trobe University', TO_DATE('20-APR-2010', 'DD-MON-YYYY'), TO_DATE('01-JUN-2010', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Technology, Sydney', TO_DATE('01-DEC-2010', 'DD-MON-YYYY'), TO_DATE('02-JAN-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Queensland', TO_DATE('05-JAN-2011', 'DD-MON-YYYY'), TO_DATE('01-JUN-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Technology, Sydney', TO_DATE('15-JUN-2011', 'DD-MON-YYYY'), TO_DATE('01-AUG-2011', 'DD-MON-YYYY') );
INSERT INTO EMPLBY VALUES ( 0000018, 'University of Wollongong', TO_DATE('25-NOV-2011', 'DD-MON-YYYY'), NULL );
INSERT INTO EMPLBY VALUES ( 0000020, 'University of Wollongong', TO_DATE('01-JUN-1991', 'DD-MON-YYYY'), NULL );

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
CREATE TABLE POSITION(			  /* Advertised positions	*/
pnumber         NUMBER(8)       NOT NULL, /* Position number            */
title           VARCHAR(30)     NOT NULL, /* Position title             */
salary		NUMBER(9,2)	NOT NULL, /* Salary			*/
extras		VARCHAR(50)	        , /* Extras			*/
bonus		NUMBER(9,2)		, /* End of year bonus		*/
specification   VARCHAR(2000)	NOT NULL, /* Specification		*/
ename		VARCHAR(100)	NOT NULL, /* Employer name		*/
	CONSTRAINT POSITION_pkey PRIMARY KEY ( pnumber ),
	CONSTRAINT POSITION_fkey FOREIGN KEY ( ename) 
		REFERENCES EMPLOYER( ename ) );

INSERT INTO POSITION VALUES ( 00000001, 'lecturer', 45000.00, 'computer', NULL, 'teaching', 'University of New South Wales');
INSERT INTO POSITION VALUES ( 00000002, 'lecturer', 450000.00, 'mouse pad', 500000.0, 'research', 'University of Wollongong');
INSERT INTO POSITION VALUES ( 00000003, 'senior lecturer', 50000.00, 'a lot of red markers', NULL, 'a lot of hard work', 'University of Technology, Sydney'  );
INSERT INTO POSITION VALUES ( 00000004, 'associate professor', 200000.00, 'silver pen', NULL, 'teaching', 'University of Wollongong');
INSERT INTO POSITION VALUES ( 00000005, 'professor', 200000.00, 'chair', NULL, 'research', 'University of Queensland' );
INSERT INTO POSITION VALUES ( 00000006, 'professor', 100000.00, 'chair and desk', NULL, 'research', 'University of New South Wales' );
INSERT INTO POSITION VALUES ( 00000007, 'professor', 800000.00, 'chair', NULL, 'teaching and research', 'University of Wollongong');
INSERT INTO POSITION VALUES ( 00000008, 'senior lecturer', 45000.00, 'computer', 100000.00, 'teaching', 'University of Wollongong');
INSERT INTO POSITION VALUES ( 00000009, 'lecturer', 450000.00, 'mouse pad', 500000.00, 'research', 'University of Wollongong');
INSERT INTO POSITION VALUES ( 00000010, 'associate professor', 50000.00, 'a lot of red markers', NULL, 'a lot of hard work', 'University of Technology, Sydney' );


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
/* Relational tables implementing associations				*/
/*									*/
CREATE TABLE SPOSSESSED(
anumber        	NUMBER(6) 	NOT NULL, /* Applicant number           */
sname		VARCHAR(30)	NOT NULL, /* Skill name                 */
slevel		NUMBER(2)	NOT NULL, /* Skill level                */
	CONSTRAINT SPOSSESSED_pkey PRIMARY KEY ( anumber, sname ), 
	CONSTRAINT SPOSSESSED_fkey1 FOREIGN KEY ( anumber )
				REFERENCES APPLICANT ( anumber )
				ON DELETE CASCADE,
	CONSTRAINT SPOSSESSED_fkey2 FOREIGN KEY ( sname )
				REFERENCES SKILL ( sname ),
	CONSTRAINT SPOSSESSED_check1 CHECK ( slevel IN 
					( 1,2,3,4,5,6,7,8,9,10 ) ) );

INSERT INTO SPOSSESSED VALUES ( 000001, 'Java programming', 9 );
INSERT INTO SPOSSESSED VALUES ( 000001, 'C programming', 4 );
INSERT INTO SPOSSESSED VALUES ( 000001, 'cooking', 9 );
INSERT INTO SPOSSESSED VALUES ( 000002, 'Java programming', 9 );
INSERT INTO SPOSSESSED VALUES ( 000002, 'driving', 9 );
INSERT INTO SPOSSESSED VALUES ( 000003, 'C++ programming', 10 );
INSERT INTO SPOSSESSED VALUES ( 000003, 'Java programming', 9 );
INSERT INTO SPOSSESSED VALUES ( 000003, 'painting', 5 );
INSERT INTO SPOSSESSED VALUES ( 000005, 'SQL programming', 6 );
INSERT INTO SPOSSESSED VALUES ( 000006, 'SQL programming', 8 );
INSERT INTO SPOSSESSED VALUES ( 000007, 'SQL programming', 9 );
INSERT INTO SPOSSESSED VALUES ( 000007, 'cooking', 10 );
INSERT INTO SPOSSESSED VALUES ( 000008, 'SQL programming', 3 );
INSERT INTO SPOSSESSED VALUES ( 000008, 'cooking', 9 );
INSERT INTO SPOSSESSED VALUES ( 0000010, 'database design', 10 );
INSERT INTO SPOSSESSED VALUES ( 0000010, 'cooking', 1 );
INSERT INTO SPOSSESSED VALUES ( 0000010, 'painting', 9 );
INSERT INTO SPOSSESSED VALUES ( 0000010, 'SQL programming', 10 );
INSERT INTO SPOSSESSED VALUES ( 0000011, 'network administration', 10 );
INSERT INTO SPOSSESSED VALUES ( 0000011, 'C programming', 5 );
INSERT INTO SPOSSESSED VALUES ( 0000012, 'cooking', 1 );
INSERT INTO SPOSSESSED VALUES ( 0000012, 'Java programming', 9 );
INSERT INTO SPOSSESSED VALUES ( 0000012, 'driving', 3 );
INSERT INTO SPOSSESSED VALUES ( 0000013, 'network administration', 7 );
INSERT INTO SPOSSESSED VALUES ( 0000013, 'database administration', 6 );
INSERT INTO SPOSSESSED VALUES ( 0000014, 'painting', 5 );
INSERT INTO SPOSSESSED VALUES ( 0000015, 'database administration', 4 );
INSERT INTO SPOSSESSED VALUES ( 0000016, 'SQL programming', 4 );
INSERT INTO SPOSSESSED VALUES ( 0000017, 'database administration', 7 );
INSERT INTO SPOSSESSED VALUES ( 0000017, 'cooking', 9 );
INSERT INTO SPOSSESSED VALUES ( 0000018, 'network administration', 5 );
INSERT INTO SPOSSESSED VALUES ( 0000018, 'bricklaying', 6 );
INSERT INTO SPOSSESSED VALUES ( 0000018, 'database design', 9 );
INSERT INTO SPOSSESSED VALUES ( 0000018, 'database administration', 3 );
INSERT INTO SPOSSESSED VALUES ( 0000019, 'database administration', 8 );
INSERT INTO SPOSSESSED VALUES ( 0000020, 'SQL programming', 10 );

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
CREATE TABLE SNEEDED(
pnumber        	NUMBER(8) 	NOT NULL, /* Position number            */
sname		VARCHAR(30)	NOT NULL, /* Skill name                 */
slevel		NUMBER(2)	NOT NULL, /* Skill level                */
	CONSTRAINT SNEEDED_pkey PRIMARY KEY ( pnumber, sname ), 
	CONSTRAINT SNEEDED_fkey1 FOREIGN KEY ( pnumber )
				REFERENCES POSITION ( pnumber )
				ON DELETE CASCADE,
	CONSTRAINT SNEEDED_fkey2 FOREIGN KEY ( sname )
				REFERENCES SKILL ( sname ),
	CONSTRAINT SNEEDED_check1 CHECK ( slevel IN 
					( 1,2,3,4,5,6,7,8,9,10 ) ) );

INSERT INTO SNEEDED VALUES ( 00000001, 'Java programming', 8 );
INSERT INTO SNEEDED VALUES ( 00000001, 'cooking', 9 );
INSERT INTO SNEEDED VALUES ( 00000002, 'Java programming', 3 );
INSERT INTO SNEEDED VALUES ( 00000002, 'driving', 9 );
INSERT INTO SNEEDED VALUES ( 00000003, 'C++ programming', 7 );
INSERT INTO SNEEDED VALUES ( 00000003, 'Java programming', 10 );
INSERT INTO SNEEDED VALUES ( 00000003, 'painting', 4 );
INSERT INTO SNEEDED VALUES ( 00000005, 'cooking', 10 );
INSERT INTO SNEEDED VALUES ( 00000001, 'C programming', 4 );
INSERT INTO SNEEDED VALUES ( 00000006, 'cooking', 2 );
INSERT INTO SNEEDED VALUES ( 00000005, 'painting', 6 );
INSERT INTO SNEEDED VALUES ( 00000007, 'SQL programming', 10 );
INSERT INTO SNEEDED VALUES ( 00000004, 'SQL programming', 6 );
INSERT INTO SNEEDED VALUES ( 00000005, 'SQL programming', 3 );
INSERT INTO SNEEDED VALUES ( 00000007, 'painting', 5 );
INSERT INTO SNEEDED VALUES ( 00000001, 'SQL programming', 3 );
INSERT INTO SNEEDED VALUES ( 00000002, 'database design', 10 );
INSERT INTO SNEEDED VALUES ( 00000007, 'cooking', 8 );


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
CREATE TABLE APPLIES(
anumber		NUMBER(6)	NOT NULL, /* Applicant number		*/
pnumber		NUMBER(8)	NOT NULL, /* Position number		*/
appdate		DATE		NOT NULL, /* Application date 		*/
	CONSTRAINT APPLIES_pkey PRIMARY KEY ( anumber, pnumber ), 
	CONSTRAINT APPLIES_fkey1 FOREIGN KEY ( anumber )
				REFERENCES APPLICANT ( anumber )
				ON DELETE CASCADE,
	CONSTRAINT APPLIES_fkey2 FOREIGN KEY ( pnumber )
				REFERENCES POSITION ( pnumber ) 
				ON DELETE CASCADE);

INSERT INTO APPLIES VALUES( 000001, 00000001, TO_DATE('13-DEC-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000002, 00000001, TO_DATE('13-DEC-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000003, 00000002, TO_DATE('14-NOV-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000004, 00000002, TO_DATE('20-JAN-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000005, 00000002, TO_DATE('22-JAN-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000005, 00000003, TO_DATE('09-MAY-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000006, 00000003, TO_DATE('17-JUN-1999','DD-MON-YYYY') ); 
INSERT INTO APPLIES VALUES( 000007, 00000003, TO_DATE('18-JUN-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000007, 00000004, TO_DATE('13-APR-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000008, 00000004, TO_DATE('13-APR-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000009, 00000004, TO_DATE('14-APR-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000010, 00000005, TO_DATE('23-SEP-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000001, 00000006, TO_DATE('26-OCT-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000002, 00000006, TO_DATE('27-OCT-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000003, 00000006, TO_DATE('28-OCT-1999','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000004, 00000007, TO_DATE('01-JAN-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000005, 00000007, TO_DATE('03-JAN-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000006, 00000007, TO_DATE('04-JAN-2000','DD-MON-YYYY') );
INSERT INTO APPLIES VALUES( 000007, 00000007, TO_DATE('07-JAN-2000','DD-MON-YYYY') );

COMMIT;

PROMPT dbcreate.sql done.
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */ 
/* End of script                                                        */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
