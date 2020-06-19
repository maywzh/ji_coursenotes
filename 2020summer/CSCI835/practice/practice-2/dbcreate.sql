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
CREATE TABLE REGION(
region_name    VARCHAR(25) 	NOT NULL,
 CONSTRAINT REGION_PK PRIMARY KEY(region_name) );

CREATE TABLE COUNTRY(
country_name    VARCHAR(40) 	NOT NULL,
region_name     VARCHAR(25)     NOT NULL,
 CONSTRAINT COUNTRY_PK PRIMARY KEY(country_name),
 CONSTRAINT COUNTRY_FK FOREIGN KEY(region_name)
 	    REFERENCES REGION(region_name) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
CREATE TABLE LOCATION(
street_address VARCHAR(40)	NOT NULL,
postal_code    VARCHAR(12)	NOT NULL,
city           VARCHAR(30)	NOT NULL,
state_province VARCHAR(25)	    NULL,
country_name   VARCHAR(40)	NOT NULL,
 CONSTRAINT LOCATION_PK PRIMARY KEY(street_address, postal_code, city, country_name),
 CONSTRAINT LOCATION_CK UNIQUE(street_address, city, state_province, country_name),
 CONSTRAINT LOCATION_FK FOREIGN KEY(country_name)
 	    REFERENCES COUNTRY(country_name) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
CREATE TABLE DEPARTMENT(
department_name VARCHAR(30)	NOT NULL,
street_address VARCHAR(40)	NOT NULL,
postal_code    VARCHAR(12)	NOT NULL,
city           VARCHAR(30)	NOT NULL,
country_name   VARCHAR(40)	NOT NULL,
manager_id     DECIMAL(6)	    NULL,
 CONSTRAINT DEPARTMENT_PK PRIMARY KEY(department_name),
 CONSTRAINT DEPARTMENT_FK1 FOREIGN KEY(street_address, postal_code, city, country_name)
 	    REFERENCES LOCATION(street_address, postal_code, city, country_name) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
CREATE TABLE JOB(
job_title      VARCHAR(35)	NOT NULL,
min_salary     DECIMAL(6)	    NULL,
max_salary     DECIMAL(6)	    NULL,
 CONSTRAINT JOB_PK PRIMARY KEY(job_title) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
CREATE TABLE EMPLOYEE(
employee_id    DECIMAL(6)	NOT NULL,
first_name     VARCHAR(20)	NOT NULL,
last_name      VARCHAR(25)	NOT NULL,
email          VARCHAR(25)	    NULL,
phone_number   VARCHAR(20)	    NULL,
hire_date      DATE		NOT NULL,
job_title      VARCHAR(35)	NOT NULL,
salary         DECIMAL(8,2)	    NULL,
commission_pct DECIMAL(2,2)	    NULL,
supervisor_id     DECIMAL(6)	    NULL,
department_name VARCHAR(30)	    NULL,
 CONSTRAINT EMPLOYEE_PK PRIMARY KEY(employee_id),
 CONSTRAINT EMPLOYEE_CK1 UNIQUE(email),
 CONSTRAINT EMPLOYEE_CK2 UNIQUE(phone_number),
 CONSTRAINT EMPLOYEE_FK1 FOREIGN KEY(department_name)
 	    REFERENCES DEPARTMENT(department_name),
 CONSTRAINT EMPLOYEE_FK2 FOREIGN KEY(supervisor_id)
 	    REFERENCES EMPLOYEE(employee_id),
 CONSTRAINT EMPLOYEE_FK3 FOREIGN KEY(job_title)
 	    REFERENCES JOB(job_title),
CONSTRAINT EMPLOYEE_CH1 CHECK (salary > 0) );

ALTER TABLE DEPARTMENT
ADD ( CONSTRAINT DEPARTMENT_FK2 FOREIGN KEY(manager_id)
      		  REFERENCES EMPLOYEE(employee_id) );
/*										*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/*										*/
CREATE TABLE JOBHISTORY(
employee_id   DECIMAL(6)	NOT NULL,
start_date    DATE		NOT NULL,
end_date      DATE		    NULL,
job_title     VARCHAR(35)	NOT NULL,
department_name VARCHAR(30)	    NULL,
 CONSTRAINT JOBHISTORY_PK PRIMARY KEY (employee_id, start_date),
 CONSTRAINT JOBHISTORY_FK1 FOREIGN KEY(job_title)
 	    REFERENCES JOB(job_title),
 CONSTRAINT JOBHISTORY_FK2 FOREIGN KEY(employee_id)
 	    REFERENCES EMPLOYEE(employee_id),
 CONSTRAINT JOBHISTORY_FK3 FOREIGN KEY(department_name)
 	    REFERENCES DEPARTMENT(department_name),
 CONSTRAINT JOBHISTORY_CH CHECK (end_date > start_date) );
/*										*/
/* End of dbreate.sql script							*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
