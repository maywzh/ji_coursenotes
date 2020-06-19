/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* Human Resources (HR) database						*/
/* Created by Janusz R. Getta, 8 November 2016 from Oracle's HR sample database */
/* 	      	     	       	 	       	    	     	 	      	*/
/* dbdrop.sql script for bridging subject of CSCI835, Spring 2018		*/
/* dbdrop.sql script drops all tables in a sample database	  	 	*/
/*										*/
/* To create all tables run a script dbcreate.sql				*/
/* To load sample data run a script dbload.sql					*/
/*										*/
INSERT INTO REGION VALUES
        ( 'Europe' );
INSERT INTO REGION VALUES
        ( 'Americas' );
INSERT INTO REGION VALUES
       ( 'Asia' );
INSERT INTO REGION VALUES
       ( 'Middle East and Africa' );
INSERT INTO REGION VALUES
       ( 'Australia and Oceania' );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
INSERT INTO COUNTRY VALUES
        ( 'Italy'
       	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Japan'
	, 'Asia' );
INSERT INTO COUNTRY VALUES
        ( 'United States of America'
	, 'Americas' );
INSERT INTO COUNTRY VALUES
        ( 'Canada'
        , 'Americas' );
INSERT INTO COUNTRY VALUES
        ( 'China'
	, 'Asia' );
INSERT INTO COUNTRY VALUES
        ( 'India'
        , 'Asia' );
INSERT INTO COUNTRY VALUES
        ( 'Australia'
	, 'Australia and Oceania' );
INSERT INTO COUNTRY VALUES
        ( 'New Zealand'
	, 'Australia and Oceania' );
INSERT INTO COUNTRY VALUES
        ( 'Fiji'
	, 'Australia and Oceania' );
INSERT INTO COUNTRY VALUES
        ( 'Vanuatu'
        , 'Australia and Oceania' ); 
INSERT INTO COUNTRY VALUES
        ( 'Zimbabwe'
	, 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
        ( 'Singapore'
	, 'Asia' );
INSERT INTO COUNTRY VALUES
        ( 'United Kingdom'
	, 'Europe');
INSERT INTO COUNTRY VALUES
        ( 'France'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Germany'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Zambia'
	, 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
        ( 'Egypt'
	, 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
       	( 'Brazil'
	, 'Americas');
INSERT INTO COUNTRY VALUES
        ( 'Switzerland'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Netherlands'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Mexico'
        , 'Americas' );
INSERT INTO COUNTRY VALUES
        ( 'Kuwait'
        , 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
        ( 'Israel'
        , 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
        ( 'Denmark'
        , 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Nigeria'
	, 'Middle East and Africa' );
INSERT INTO COUNTRY VALUES
        ( 'Argentina'
	, 'Americas' );
INSERT INTO COUNTRY VALUES
        ( 'Belgium'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Lithuania'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Latvia'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Slovenia'
	, 'Europe' );
INSERT INTO COUNTRY VALUES
        ( 'Slovakia'
	, 'Europe' );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
INSERT INTO LOCATION VALUES
        ( '1297 Via Cola di Rie'
	, '00989'
	, 'Roma'
	, NULL
	, 'Italy' );
INSERT INTO LOCATION VALUES
        ( '93091 Calle della Testa'
	, '10934'
	, 'Venice'
	, NULL
	, 'Italy' );
INSERT INTO LOCATION VALUES
        ( '2017 Shinjuku-ku'
	, '1689'
	, 'Tokyo'
	, 'Tokyo Prefecture'
	, 'Japan' );
INSERT INTO LOCATION VALUES
        ( '9450 Kamiya-cho'
	, '6823'
	, 'Hiroshima'
	, NULL
	, 'Japan' );
INSERT INTO LOCATION VALUES
        ( '2014 Jabberwocky Rd'
	, '26192'
	, 'Southlake'
	, 'Texas'
	, 'United States of America' );
INSERT INTO LOCATION VALUES
         ( '2011 Interiors Blvd'
	, '99236'
	, 'South San Francisco'
	, 'California'
	, 'United States of America' );
INSERT INTO LOCATION VALUES
        ( '2007 Zagora St'
	, '50090'
	, 'South Brunswick'
	, 'New Jersey'
	, 'United States of America' );
INSERT INTO LOCATION VALUES
        ( '2004 Charade Rd'
	, '98199'
	, 'Seattle'
	, 'Washington'
	, 'United States of America' );
INSERT INTO LOCATION VALUES
        ( '147 Spadina Ave'
	, 'M5V 2L7'
        , 'Toronto'
        , 'Ontario'
	, 'Canada' );
INSERT INTO LOCATION VALUES
        ( '6092 Boxwood St'
	, 'YSW 9T2'
	, 'Whitehorse'
	, 'Yukon'
	, 'Canada' );
INSERT INTO LOCATION VALUES
        ( '40-5-12 Laogianggen'
	, '190518'
	, 'Beijing'
	, NULL
	, 'China' );
INSERT INTO LOCATION VALUES
        ( '1298 Vileparle (E)'
	, '490231'
	, 'Bombay'
	, 'Maharashtra'
	, 'India' );
INSERT INTO LOCATION VALUES
        ( '12-98 Victoria Street'
	, '2901'
	, 'Sydney'
	, 'New South Wales'
	, 'Australia' );
INSERT INTO LOCATION VALUES
        ( '198 Clementi North'
	, '540198'
	, 'Singapore'
	, 'Clementi'
	, 'Singapore' );
INSERT INTO LOCATION VALUES
        ( '8204 Arthur St'
	, 'AB2 7RT'
	, 'London'
	, NULL
	, 'United Kingdom' );
INSERT INTO LOCATION VALUES
        ( 'Magdalen Centre The Oxford Science Park'
	, 'OX9 9ZB'
	, 'Oxford'
	, 'Oxford'
	, 'United Kingdom' );
INSERT INTO LOCATION VALUES
        ( '9702 Chester Road'
	, '09629850293'
	, 'Stretford'
	, 'Manchester'
	, 'United Kingdom' );
INSERT INTO LOCATION VALUES
        ( 'Schwanthalerstr. 7031'
	, '80925'
	, 'Munich'
	, 'Bavaria'
	, 'Germany' );
INSERT INTO LOCATION VALUES
        ( 'Rua Frei Caneca 1360 '
	, '01307-002'
	, 'Sao Paulo'
	, NULL
	, 'Brazil' );
INSERT INTO LOCATION VALUES
        ( '20 Rue des Corps-Saints'
	, '1730'
	, 'Geneva'
	, NULL
	, 'Switzerland' );
INSERT INTO LOCATION VALUES
        ( 'Murtenstrasse 921'
	, '3095'
	, 'Bern'
	, 'BE'
	, 'Switzerland' );
INSERT INTO LOCATION VALUES
        ( 'Pieter Breughelstraat 837'
	, '3029SK'
	, 'Utrecht'
	, NULL
	, 'Netherlands' );
INSERT INTO LOCATION VALUES
        ( 'Mariano Escobedo 9991'
	, '11932'
	, 'Mexico City'
	, 'Distrito Federal'
	, 'Mexico');
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
ALTER TABLE DEPARTMENT DROP CONSTRAINT DEPARTMENT_FK2;

INSERT INTO DEPARTMENT VALUES
        ( 'Administration'
	, '12-98 Victoria Street'
	, '2901'
	, 'Sydney'
	, 'Australia'
	, 200);
INSERT INTO DEPARTMENT VALUES 
	( 'Marketing'
	, '1298 Vileparle (E)'
	, '490231'
	, 'Bombay'
	, 'India'
	, 201 );
INSERT INTO DEPARTMENT VALUES 
	( 'Purchasing'
	, '40-5-12 Laogianggen'
	, '190518'
	, 'Beijing'
	, 'China'
	, 114 );
INSERT INTO DEPARTMENT VALUES 
	( 'Human Resources'
	, '9450 Kamiya-cho'
	, '6823'
	, 'Hiroshima'
	, 'Japan'
	, 203 );
INSERT INTO DEPARTMENT VALUES 
	( 'Shipping'
	, '2011 Interiors Blvd'
	, '99236'
	, 'South San Francisco'
	, 'United States of America'
	, 120 );
INSERT INTO DEPARTMENT VALUES 
	( 'Information Technology'
	, '93091 Calle della Testa'
	, '10934'
	, 'Venice'
	, 'Italy'
	, 104 );
INSERT INTO DEPARTMENT VALUES 
	( 'Public Relations'
	, '93091 Calle della Testa'
	, '10934'
	, 'Venice'
	, 'Italy'
	, 204 );
INSERT INTO DEPARTMENT VALUES 
	( 'Sales'
	, '20 Rue des Corps-Saints'
	, '1730'
	, 'Geneva'
	, 'Switzerland'
	, 145 );
INSERT INTO DEPARTMENT VALUES 
	( 'Executive'
	, 'Mariano Escobedo 9991'
	, '11932'
	, 'Mexico City'
	, 'Mexico'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Finance'
	, '6092 Boxwood St'
	, 'YSW 9T2'
	, 'Whitehorse'
	, 'Canada'
	, 108 );
INSERT INTO DEPARTMENT VALUES 
	( 'Accounting'
	, '20 Rue des Corps-Saints'
	, '1730'
	, 'Geneva'
	, 'Switzerland'
	, 109 );
INSERT INTO DEPARTMENT VALUES 
	( 'Treasury'
	, '198 Clementi North'
	, '540198'
	, 'Singapore'
	, 'Singapore'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Corporate Tax'
	, '2011 Interiors Blvd'
	, '99236'
	, 'South San Francisco'
	, 'United States of America'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Control And Credit'
	, '2014 Jabberwocky Rd'
	, '26192'
	, 'Southlake'
	, 'United States of America'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Shareholder Services'
	, 'Mariano Escobedo 9991'
	, '11932'
	, 'Mexico City'
	, 'Mexico'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Benefits'
	, '1298 Vileparle (E)'
	, '490231'
	, 'Bombay'
	, 'India'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Manufacturing'
	, '40-5-12 Laogianggen'
	, '190518'
	, 'Beijing'
	, 'China'
	, 104 );
INSERT INTO DEPARTMENT VALUES 
	( 'Construction'
	, '40-5-12 Laogianggen'
	, '190518'
	, 'Beijing'
	, 'China'
	, 104 );
INSERT INTO DEPARTMENT VALUES 
	( 'Contracting'
	, '2017 Shinjuku-ku'
	, '1689'
	, 'Tokyo'
	, 'Japan' 
	, 105 );
INSERT INTO DEPARTMENT VALUES 
	( 'Operations'
	, '8204 Arthur St'
	, 'AB2 7RT'
	, 'London'
	, 'United Kingdom' 
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Government Sales'
	, '93091 Calle della Testa'
	, '10934'
	, 'Venice'
	, 'Italy'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Retail Sales'
	, '93091 Calle della Testa'
	, '10934'
	, 'Venice'
	, 'Italy'
	, 145 );
INSERT INTO DEPARTMENT VALUES 
	( 'Recruiting'
	,'198 Clementi North'
	, '540198'
	, 'Singapore'
	, 'Singapore'
	, 100 );
INSERT INTO DEPARTMENT VALUES 
	( 'Payroll'
	, '12-98 Victoria Street'
	, '2901'
	, 'Sydney'
	, 'Australia'
        , 112 );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
INSERT INTO JOB VALUES
        ( 'President'
	, 20000
	, 40000 );
INSERT INTO JOB VALUES
        ( 'Administration Vice President'
	, 15000
	, 30000 );
INSERT INTO JOB VALUES
        ( 'Administration Assistant'
	, 3000
	, 6000 );
INSERT INTO JOB VALUES
        ( 'Finance Manager'
	, 8200
	, 16000 );
INSERT INTO JOB VALUES
        ( 'Accountant'
	, 4200
	, 9000 );
INSERT INTO JOB VALUES
        ( 'Accounting Manager'
	, 8200
	, 16000 );
INSERT INTO JOB VALUES
        ( 'Public Accountant'
	, 4200
	, 9000 );
INSERT INTO JOB VALUES 
	( 'Sales Manager'
	, 10000
	, 20000 );
INSERT INTO JOB VALUES 
	( 'Sales Representative'
	, 6000
	, 12000 );
INSERT INTO JOB VALUES 
	( 'Purchasing Manager'
	, 8000
	, 15000 );
INSERT INTO JOB VALUES 
	( 'Purchasing Clerk'
	, 2500
	, 5500 );
INSERT INTO JOB VALUES 
	( 'Stock Manager'
	, 5500
	, 8500 );
INSERT INTO JOB VALUES 
	( 'Stock Clerk'
	, 2000
	, 5000 );
INSERT INTO JOB VALUES 
	( 'Shipping Clerk'
	, 2500
	, 5500 );
INSERT INTO JOB VALUES 
	( 'Programmer'
	, 7500
	, 8499 );
INSERT INTO JOB VALUES 
	( 'Marketing Manager'
	, 9000
	, 15000 );
INSERT INTO JOB VALUES
        ( 'Marketing Representative'
	, 4000
	, 9000 );
INSERT INTO JOB VALUES
       	( 'Human Resources Representative'
	, 4000
	, 9000 );
INSERT INTO JOB VALUES
        ( 'Public Relations Representative'
	, 4500
	, 10500 );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
INSERT INTO EMPLOYEE VALUES 
        ( 100
        , 'Steven'
        , 'King'
        , 'SKING'
        , '515.123.4567'
        , TO_DATE('17-06-1987', 'DD-MM-YYYY')
        , 'President'
        , 24000
        , NULL
        , NULL
        , 'Executive'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 101
        , 'Neena'
        , 'Kochhar'
        , 'NKOCHHAR'
        , '515.123.4568'
        , TO_DATE('21-09-1998', 'DD-MM-YYYY')
        , 'Administration Vice President'
        , 17000
        , NULL
        , 100
        , 'Executive'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 102
        , 'Lex'
        , 'De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , TO_DATE('13-01-1999', 'DD-MM-YYYY')
        , 'Administration Vice President'
        , 17000
        , NULL
        , 100
        , 'Executive'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 103
        , 'Alexander'
        , 'Hunold'
        , 'AHUNOLD'
        , '590.423.4567'
        , TO_DATE('03-01-1990', 'DD-MM-YYYY')
        , 'Programmer'
        , 9000
        , NULL
        , 102
        , 'Information Technology'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 104
        , 'Bruce'
        , 'Ernst'
        , 'BERNST'
        , '590.423.4568'
        , TO_DATE('21-05-1991', 'DD-MM-YYYY')
        , 'Programmer'
        , 6000
        , NULL
        , 103
        , 'Information Technology'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 105
        , 'David'
        , 'Austin'
        , 'DAUSTIN'
        , '590.423.4569'
        , TO_DATE('25-06-1997', 'DD-MM-YYYY')
        , 'Programmer'
        , 4800
        , NULL
        , 103
        , 'Information Technology'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 106
        , 'Valli'
        , 'Pataballa'
        , 'VPATABAL'
        , '590.423.4560'
        , TO_DATE('05-02-1998', 'DD-MM-YYYY')
        , 'Programmer'
        , 4800
        , NULL
        , 103
        , 'Information Technology'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 107
        , 'Diana'
        , 'Lorentz'
        , 'DLORENTZ'
        , '590.423.5567'
        , TO_DATE('07-02-1999', 'DD-MM-YYYY')
        , 'Programmer'
        , 4200
        , NULL
        , 103
        , 'Information Technology'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 108
        , 'Nancy'
        , 'Greenberg'
        , 'NGREENBE'
        , '515.124.4569'
        , TO_DATE('17-09-1994', 'DD-MM-YYYY')
        , 'Finance Manager'
        , 12000
        , NULL
        , 101
        , 'Finance'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 109
        , 'Daniel'
        , 'Faviet'
        , 'DFAVIET'
        , '515.124.4169'
        , TO_DATE('16-10-1999', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 9000
        , NULL
        , 108
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 110
        , 'John'
        , 'Chen'
        , 'JCHEN'
        , '515.124.4269'
        , TO_DATE('05-01-2000', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 8200
        , NULL
        , 108
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 111
        , 'Ismael'
        , 'Sciarra'
        , 'ISCIARRA'
        , '515.124.4369'
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 7700
        , NULL
        , 108
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 112
        , 'Jose Manuel'
        , 'Urman'
        , 'JMURMAN'
        , '515.124.4469'
        , TO_DATE('07-03-1998', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 7800
        , NULL
        , 108
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 113
        , 'Luis'
        , 'Popp'
        , 'LPOPP'
        , '515.124.4567'
        , TO_DATE('07-12-1999', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 6900
        , NULL
        , 108
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 114
        , 'Den'
        , 'Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , TO_DATE('01-01-2000', 'DD-MM-YYYY')
        , 'Purchasing Manager'
        , 11000
        , NULL
        , 100
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 115
        , 'Alexander'
        , 'Khoo'
        , 'AKHOO'
        , '515.127.4562'
        , TO_DATE('18-05-1995', 'DD-MM-YYYY')
        , 'Purchasing Clerk'
        , 3100
        , NULL
        , 114
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 116
        , 'Shelli'
        , 'Baida'
        , 'SBAIDA'
        , '515.127.4563'
        , TO_DATE('24-12-1997', 'DD-MM-YYYY')
        , 'Purchasing Clerk'
        , 2900
        , NULL
        , 114
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 117
        , 'Sigal'
        , 'Tobias'
        , 'STOBIAS'
        , '515.127.4564'
        , TO_DATE('24-07-1997', 'DD-MM-YYYY')
        , 'Purchasing Clerk'
        , 2800
        , NULL
        , 114
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 118
        , 'Guy'
        , 'Himuro'
        , 'GHIMURO'
        , '515.127.4565'
        , TO_DATE('15-11-1998', 'DD-MM-YYYY')
        , 'Purchasing Clerk'
        , 2600
        , NULL
        , 114
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 119
        , 'Karen'
        , 'Colmenares'
        , 'KCOLMENA'
        , '515.127.4566'
        , TO_DATE('10-08-1999', 'DD-MM-YYYY')
        , 'Purchasing Clerk'
        , 2500
        , NULL
        , 114
        , 'Purchasing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 120
        , 'Matthew'
        , 'Weiss'
        , 'MWEISS'
        , '650.123.1234'
        , TO_DATE('18-07-1996', 'DD-MM-YYYY')
        , 'Stock Manager'
        , 8000
        , NULL
        , 100
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 121
        , 'Adam'
        , 'Fripp'
        , 'AFRIPP'
        , '650.123.2234'
        , TO_DATE('10-04-1997', 'DD-MM-YYYY')
        , 'Stock Manager'
        , 8200
        , NULL
        , 100
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 122
        , 'Payam'
        , 'Kaufling'
        , 'PKAUFLIN'
        , '650.123.3234'
        , TO_DATE('01-05-1995', 'DD-MM-YYYY')
        , 'Stock Manager'
        , 7900
        , NULL
        , 100
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 123
        , 'Shanta'
        , 'Vollman'
        , 'SVOLLMAN'
        , '650.123.4234'
        , TO_DATE('10-10-1997', 'DD-MM-YYYY')
        , 'Stock Manager'
        , 6500
        , NULL
        , 100
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 124
        , 'Kevin'
        , 'Mourgos'
        , 'KMOURGOS'
        , '650.123.5234'
        , TO_DATE('16-11-1999', 'DD-MM-YYYY')
        , 'Stock Manager'
        , 5800
        , NULL
        , 100
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 125
        , 'Julia'
        , 'Nayer'
        , 'JNAYER'
        , '650.124.1214'
        , TO_DATE('16-07-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3200
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 126
        , 'Irene'
        , 'Mikkilineni'
        , 'IMIKKILI'
        , '650.124.1224'
        , TO_DATE('28-09-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2700
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 127
        , 'James'
        , 'Landry'
        , 'JLANDRY'
        , '650.124.1334'
        , TO_DATE('14-01-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2400
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 128
        , 'Steven'
        , 'Markle'
        , 'SMARKLE'
        , '650.124.1434'
        , TO_DATE('08-03-2000', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2200
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 129
        , 'Laura'
        , 'Bissot'
        , 'LBISSOT'
        , '650.124.5234'
        , TO_DATE('20-08-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3300
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 130
        , 'Mozhe'
        , 'Atkinson'
        , 'MATKINSO'
        , '650.124.6234'
        , TO_DATE('30-10-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2800
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 131
        , 'James'
        , 'Marlow'
        , 'JAMRLOW'
        , '650.124.7234'
        , TO_DATE('16-02-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2500
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 132
        , 'TJ'
        , 'Olson'
        , 'TJOLSON'
        , '650.124.8234'
        , TO_DATE('10-04-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2100
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 133
        , 'Jason'
        , 'Mallin'
        , 'JMALLIN'
        , '650.127.1934'
        , TO_DATE('14-06-1996', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3300
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 134
        , 'Michael'
        , 'Rogers'
        , 'MROGERS'
        , '650.127.1834'
        , TO_DATE('26-08-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2900
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 135
        , 'Ki'
        , 'Gee'
        , 'KGEE'
        , '650.127.1734'
        , TO_DATE('12-12-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2400
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 136
        , 'Hazel'
        , 'Philtanker'
        , 'HPHILTAN'
        , '650.127.1634'
        , TO_DATE('06-02-2000', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2200
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 137
        , 'Renske'
        , 'Ladwig'
        , 'RLADWIG'
        , '650.121.1234'
        , TO_DATE('14-07-1995', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3600
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 138
        , 'Stephen'
        , 'Stiles'
        , 'SSTILES'
        , '650.121.2034'
        , TO_DATE('26-10-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3200
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 139
        , 'John'
        , 'Seo'
        , 'JSEO'
        , '650.121.2019'
        , TO_DATE('12-02-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2700
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 140
        , 'Joshua'
        , 'Patel'
        , 'JPATEL'
        , '650.121.1834'
        , TO_DATE('06-04-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2500
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 141
        , 'Trenna'
        , 'Rajs'
        , 'TRAJS'
        , '650.121.8009'
        , TO_DATE('17-10-1995', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3500
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 142
        , 'Curtis'
        , 'Davies'
        , 'CDAVIES'
        , '650.121.2994'
        , TO_DATE('29-01-1997', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 3100
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 143
        , 'Randall'
        , 'Matos'
        , 'RMATOS'
        , '650.121.2874'
        , TO_DATE('15-03-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2600
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 144
        , 'Peter'
        , 'Vargas'
        , 'PVARGAS'
        , '650.121.2004'
        , TO_DATE('09-07-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 2500
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 145
        , 'John'
        , 'Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , TO_DATE('01-10-1996', 'DD-MM-YYYY')
        , 'Sales Manager'
        , 14000
        , .4
        , 100
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 146
        , 'Karen'
        , 'Partners'
        , 'KPARTNER'
        , '011.44.1344.467268'
        , TO_DATE('05-01-1997', 'DD-MM-YYYY')
        , 'Sales Manager'
        , 13500
        , .3
        , 100
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 147
        , 'Alberto'
        , 'Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , TO_DATE('10-03-1997', 'DD-MM-YYYY')
        , 'Sales Manager'
        , 12000
        , .3
        , 100
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 148
        , 'Gerald'
        , 'Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , TO_DATE('15-10-1999', 'DD-MM-YYYY')
        ,'Sales Manager'
        , 11000
        , .3
        , 100
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 149
        , 'Eleni'
        , 'Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , TO_DATE('29-01-2000', 'DD-MM-YYYY')
        , 'Sales Manager'
        , 10500
        , .2
        , 100
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 150
        , 'Peter'
        , 'Tucker'
        , 'PTUCKER'
        , '011.44.1344.129268'
        , TO_DATE('30-01-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 10000
        , .3
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 151
        , 'David'
        , 'Bernstein'
        , 'DBERNSTE'
        , '011.44.1344.345268'
        , TO_DATE('24-03-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9500
        , .25
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 152
        , 'Peter'
        , 'Hall'
        , 'PHALL'
        , '011.44.1344.478968'
        , TO_DATE('20-08-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9000
        , .25
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 153
        , 'Christopher'
        , 'Olsen'
        , 'COLSEN'
        , '011.44.1344.498718'
        , TO_DATE('30-03-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 8000
        , .2
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 154
        , 'Nanette'
        , 'Cambrault'
        , 'NCAMBRAU'
        , '011.44.1344.987668'
        , TO_DATE('09-12-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7500
        , .2
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 155
        , 'Oliver'
        , 'Tuvault'
        , 'OTUVAULT'
        , '011.44.1344.486508'
        , TO_DATE('23-11-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7000
        , .15
        , 145
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 156
        , 'Janette'
        , 'King'
        , 'JKING'
        , '011.44.1345.429268'
        , TO_DATE('30-01-1996', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 10000
        , .35
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 157
        , 'Patrick'
        , 'Sully'
        , 'PSULLY'
        , '011.44.1345.929268'
        , TO_DATE('04-03-1996', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9500
        , .35
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 158
        , 'Allan'
        , 'McEwen'
        , 'AMCEWEN'
        , '011.44.1345.829268'
        , TO_DATE('01-08-1996', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9000
        , .35
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 159
        , 'Lindsey'
        , 'Smith'
        , 'LSMITH'
        , '011.44.1345.729268'
        , TO_DATE('10-03-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 8000
        , .3
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 160
        , 'Louise'
        , 'Doran'
        , 'LDORAN'
        , '011.44.1345.629268'
        , TO_DATE('01-01-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7500
        , .3
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 161
        , 'Sarath'
        , 'Sewall'
        , 'SSEWALL'
        , '011.44.1345.529268'
        , TO_DATE('01-12-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7000
        , .25
        , 146
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 162
        , 'Clara'
        , 'Vishney'
        , 'CVISHNEY'
        , '011.44.1346.129268'
        , TO_DATE('11-11-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 10500
        , .25
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 163
        , 'Danielle'
        , 'Greene'
        , 'DGREENE'
        , '011.44.1346.229268'
        , TO_DATE('19-03-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9500
        , .15
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 164
        , 'Mattea'
        , 'Marvins'
        , 'MMARVINS'
        , '011.44.1346.329268'
        , TO_DATE('24-01-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7200
        , .10
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 165
        , 'David'
        , 'Lee'
        , 'DLEE'
        , '011.44.1346.529268'
        , TO_DATE('23-02-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 6800
        , .1
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 166
        , 'Sundar'
        , 'Ande'
        , 'SANDE'
        , '011.44.1346.629268'
        , TO_DATE('24-03-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 6400
        , .10
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 167
        , 'Amit'
        , 'Banda'
        , 'ABANDA'
        , '011.44.1346.729268'
        , TO_DATE('21-04-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 6200
        , .10
        , 147
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 168
        , 'Lisa'
        , 'Ozer'
        , 'LOZER'
        , '011.44.1343.929268'
        , TO_DATE('11-03-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 11500
        , .25
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 169  
        , 'Harrison'
        , 'Bloom'
        , 'HBLOOM'
        , '011.44.1343.829268'
        , TO_DATE('23-03-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 10000
        , .20
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 170
        , 'Tayler'
        , 'Fox'
        , 'TFOX'
        , '011.44.1343.729268'
        , TO_DATE('24-01-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 9600
        , .20
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 171
        , 'William'
        , 'Smith'
        , 'WSMITH'
        , '011.44.1343.629268'
        , TO_DATE('23-02-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7400
        , .15
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 172
        , 'Elizabeth'
        , 'Bates'
        , 'EBATES'
        , '011.44.1343.529268'
        , TO_DATE('24-03-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7300
        , .15
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 173
        , 'Sundita'
        , 'Kumar'
        , 'SKUMAR'
        , '011.44.1343.329268'
        , TO_DATE('21-04-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 6100
        , .10
        , 148
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 174
        , 'Ellen'
        , 'Abel'
        , 'EABEL'
        , '011.44.1644.429267'
        , TO_DATE('11-05-1996', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 11000
        , .30
        , 149
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 175
        , 'Alyssa'
        , 'Hutton'
        , 'AHUTTON'
        , '011.44.1644.429266'
        , TO_DATE('19-03-1997', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 8800
        , .25
        , 149
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 176
        , 'Jonathon'
        , 'Taylor'
        , 'JTAYLOR'
        , '011.44.1644.429265'
        , TO_DATE('24-03-2000', 'DD-MM-YYYY')
        , 'Sales Manager'
        , 8600
        , .20
        , 149
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 177
        , 'Jack'
        , 'Livingston'
        , 'JLIVINGS'
        , '011.44.1644.429264'
        , TO_DATE('23-04-1998', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 8400
        , .20
        , 149
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 178
        , 'Kimberely'
        , 'Grant'
        , 'KGRANT'
        , '011.44.1644.429263'
        , TO_DATE('24-05-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 7000
        , .15
        , 149
        , NULL
        );

INSERT INTO EMPLOYEE VALUES 
        ( 179
        , 'Charles'
        , 'Johnson'
        , 'CJOHNSON'
        , '011.44.1644.429262'
        , TO_DATE('04-01-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 6200
        , .10
        , 149
        , 'Sales'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 180
        , 'Winston'
        , 'Taylor'
        , 'WTAYLOR'
        , '650.507.9876'
        , TO_DATE('24-01-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3200
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 181
        , 'Jean'
        , 'Fleaur'
        , 'JFLEAUR'
        , '650.507.9877'
        , TO_DATE('23-02-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3100
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 182
        , 'Martha'
        , 'Sullivan'
        , 'MSULLIVA'
        , '650.507.9878'
        , TO_DATE('21-06-1999', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2500
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 183
        , 'Girard'
        , 'Geoni'
        , 'GGEONI'
        , '650.507.9879'
        , TO_DATE('03-02-2000', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2800
        , NULL
        , 120
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 184
        , 'Nandita'
        , 'Sarchand'
        , 'NSARCHAN'
        , '650.509.1876'
        , TO_DATE('27-01-1996', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 4200
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 185
        , 'Alexis'
        , 'Bull'
        , 'ABULL'
        , '650.509.2876'
        , TO_DATE('20-02-1997', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 4100
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 186
        , 'Julia'
        , 'Dellinger'
        , 'JDELLING'
        , '650.509.3876'
        , TO_DATE('24-06-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3400
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 187
        , 'Anthony'
        , 'Cabrio'
        , 'ACABRIO'
        , '650.509.4876'
        , TO_DATE('07-02-1999', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3000
        , NULL
        , 121
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 188
        , 'Kelly'
        , 'Chung'
        , 'KCHUNG'
        , '650.505.1876'
        , TO_DATE('14-06-1997', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3800
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 189
        , 'Jennifer'
        , 'Dilly'
        , 'JDILLY'
        , '650.505.2876'
        , TO_DATE('13-08-1997', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3600
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 190
        , 'Timothy'
        , 'Gates'
        , 'TGATES'
        , '650.505.3876'
        , TO_DATE('11-07-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2900
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 191
        , 'Randall'
        , 'Perkins'
        , 'RPERKINS'
        , '650.505.4876'
        , TO_DATE('19-12-1999', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2500
        , NULL
        , 122
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 192
        , 'Sarah'
        , 'Bell'
        , 'SBELL'
        , '650.501.1876'
        , TO_DATE('04-02-1996', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 4000
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 193
        , 'Britney'
        , 'Everett'
        , 'BEVERETT'
        , '650.501.2876'
        , TO_DATE('03-03-1997', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3900
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 194
        , 'Samuel'
        , 'McCain'
        , 'SMCCAIN'
        , '650.501.3876'
        , TO_DATE('01-07-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3200
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 195
        , 'Vance'
        , 'Jones'
        , 'VJONES'
        , '650.501.4876'
        , TO_DATE('17-03-1999', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2800
        , NULL
        , 123
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 196
        , 'Alana'
        , 'Walsh'
        , 'AWALSH'
        , '650.507.9811'
        , TO_DATE('24-04-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3100
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 197
        , 'Kevin'
        , 'Feeney'
        , 'KFEENEY'
        , '650.507.9822'
        , TO_DATE('23-05-1998', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 3000
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 198
        , 'Donald'
        , 'OConnell'
        , 'DOCONNEL'
        , '650.507.9833'
        , TO_DATE('21-06-1999', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2600
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 199
        , 'Douglas'
        , 'Grant'
        , 'DGRANT'
        , '650.507.9844'
        , TO_DATE('13-01-2000', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 2600
        , NULL
        , 124
        , 'Shipping'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 200
        , 'Jennifer'
        , 'Whalen'
        , 'JWHALEN'
        , '515.123.4444'
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , 'Administration Assistant'
        , 4400
        , NULL
        , 101
        , 'Administration'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 201
        , 'Michael'
        , 'Hartstein'
        , 'MHARTSTE'
        , '515.123.5555'
        , TO_DATE('20-12-1999', 'DD-MM-YYYY')
        , 'Marketing Manager'
        , 13000
        , NULL
        , 100
        , 'Marketing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 202
        , 'Pat'
        , 'Fay'
        , 'PFAY'
        , '603.123.6666'
        , TO_DATE('17-08-1997', 'DD-MM-YYYY')
        , 'Marketing Representative'
        , 6000
        , NULL
        , 201
        , 'Marketing'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 203
        , 'Susan'
        , 'Mavris'
        , 'SMAVRIS'
        , '515.123.7777'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'Human Resources Representative'
        , 6500
        , NULL
        , 101
        , 'Human Resources'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 204
        , 'Hermann'
        , 'Baer'
        , 'HBAER'
        , '515.123.8888'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'Public Relations Representative'
        , 10000
        , NULL
        , 101
        , 'Public Relations'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 205
        , 'Shelley'
        , 'Higgins'
        , 'SHIGGINS'
        , '515.123.8080'
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 12000
        , NULL
        , 101
        , 'Accounting'
        );

INSERT INTO EMPLOYEE VALUES 
        ( 206
        , 'William'
        , 'Gietz'
        , 'WGIETZ'
        , '515.123.8181'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'Accountant'
        , 8300
        , NULL
        , 105
        , 'Accounting'
        );

ALTER TABLE DEPARTMENT
ADD ( CONSTRAINT DEPARTMENT_FK2 FOREIGN KEY(manager_id)
      		  REFERENCES EMPLOYEE(employee_id) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
INSERT INTO JOBHISTORY
VALUES ( 101
       , TO_DATE('21-09-1989', 'DD-MM-YYYY')
       , TO_DATE('27-10-1993', 'DD-MM-YYYY')
       , 'Accountant'
       , 'Accounting');

INSERT INTO JOBHISTORY
VALUES ( 101
       , TO_DATE('28-10-1993', 'DD-MM-YYYY')
       , TO_DATE('15-03-1997', 'DD-MM-YYYY')
       , 'Accounting Manager'
       , 'Accounting');

INSERT INTO JOBHISTORY
VALUES ( 102
       , TO_DATE('13-01-1993', 'DD-MM-YYYY')
       , TO_DATE('24-07-1998', 'DD-MM-YYYY')
       , 'Programmer'
       , 'Information Technology');

INSERT INTO JOBHISTORY
VALUES  ( 114
        , TO_DATE('24-03-1998', 'DD-MM-YYYY')
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Purchasing'
        );

INSERT INTO JOBHISTORY
VALUES  ( 176
        , TO_DATE('24-03-1998', 'DD-MM-YYYY')
        , TO_DATE('31-12-1998', 'DD-MM-YYYY')
        , 'Programmer'
        , 'Information Technology'
        );

INSERT INTO JOBHISTORY
VALUES  ( 176
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 'Sales'
        );

INSERT INTO JOBHISTORY
VALUES  ( 206
        , TO_DATE('18-06-1993', 'DD-MM-YYYY')
        , TO_DATE('31-12-1998', 'DD-MM-YYYY')
        , 'Accounting Manager'
        , 'Accounting'
        );

INSERT INTO JOBHISTORY
VALUES  ( 206
        , TO_DATE('17-09-1987', 'DD-MM-YYYY')
        , TO_DATE('17-06-1993', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY
VALUES ( 201
       , TO_DATE('17-02-1996', 'DD-MM-YYYY')
       , TO_DATE('19-12-1999', 'DD-MM-YYYY')
       , 'Programmer'
       , 'Information Technology');


INSERT INTO JOBHISTORY
VALUES  ( 205
	, TO_DATE('01-07-1994', 'DD-MM-YYYY')
	, TO_DATE('31-12-1998', 'DD-MM-YYYY')
	, 'Programmer'
	, 'Information Technology' );

INSERT INTO JOBHISTORY VALUES 
        ( 108
        , TO_DATE('10-07-1991', 'DD-MM-YYYY')
        , TO_DATE('16-08-1994', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 109
        , TO_DATE('01-01-1992', 'DD-MM-YYYY')
	, TO_DATE('15-08-1994', 'DD-MM-YYYY')
        , 'Accountant'
        , 'Accounting'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 110
        , TO_DATE('01-01-1996', 'DD-MM-YYYY')
        , TO_DATE('27-09-1997', 'DD-MM-YYYY')
        , 'Accountant'
        , 'Accounting'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 160
        , TO_DATE('01-12-1994', 'DD-MM-YYYY')
	, TO_DATE('10-11-1997', 'DD-MM-YYYY')
        , 'Shipping Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 161
        , TO_DATE('03-11-1997', 'DD-MM-YYYY')
	, TO_DATE('02-11-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 162
        , TO_DATE('11-11-1990', 'DD-MM-YYYY')
	, TO_DATE('11-11-1996', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 163
        , TO_DATE('19-03-1997', 'DD-MM-YYYY')
	, TO_DATE('11-11-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 164
        , TO_DATE('24-01-1999', 'DD-MM-YYYY')
	, TO_DATE('11-11-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 165
        , TO_DATE('23-02-1998', 'DD-MM-YYYY')
	, TO_DATE('23-02-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 166
        , TO_DATE('24-03-1996', 'DD-MM-YYYY')
	, TO_DATE('23-02-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 167
        , TO_DATE('21-04-1999', 'DD-MM-YYYY')
	, TO_DATE('23-12-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 168
        , TO_DATE('11-03-1995', 'DD-MM-YYYY')
	, TO_DATE('23-02-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 169  
        , TO_DATE('23-03-1997', 'DD-MM-YYYY')
	, TO_DATE('01-01-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 170
        , TO_DATE('24-01-1997', 'DD-MM-YYYY')
	, TO_DATE('01-01-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 171
        , TO_DATE('23-02-1998', 'DD-MM-YYYY')
	, TO_DATE('22-02-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 172
        , TO_DATE('24-03-1997', 'DD-MM-YYYY')
	, TO_DATE('23-03-1999', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 'Sales'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 173
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
	, TO_DATE('20-04-2000', 'DD-MM-YYYY')
        , 'Sales Representative'
        , 'Sales'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 174
        , TO_DATE('11-05-1995', 'DD-MM-YYYY')
	, TO_DATE('10-05-1996', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 175
        , TO_DATE('19-03-1995', 'DD-MM-YYYY')
	, TO_DATE('19-03-1996', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 177
        , TO_DATE('23-04-1996', 'DD-MM-YYYY')
	, TO_DATE('22-04-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 178
        , TO_DATE('24-05-1998', 'DD-MM-YYYY')
	, TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 179
        , TO_DATE('01-01-1997', 'DD-MM-YYYY')
	, TO_DATE('02-01-2000', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

INSERT INTO JOBHISTORY VALUES 
        ( 180
        , TO_DATE('24-01-1998', 'DD-MM-YYYY')
	, TO_DATE('12-12-1998', 'DD-MM-YYYY')
        , 'Stock Clerk'
        , 'Shipping'
        );

COMMIT;
/*										*/
/* End of dbload.sql script							*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
