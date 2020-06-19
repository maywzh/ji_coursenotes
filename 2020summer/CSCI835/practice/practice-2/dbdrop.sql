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
ALTER TABLE DEPARTMENT DROP CONSTRAINT DEPARTMENT_FK2;
DROP TABLE JOBHISTORY PURGE;
DROP TABLE EMPLOYEE PURGE;
DROP TABLE JOB PURGE;
DROP TABLE DEPARTMENT PURGE;
DROP TABLE LOCATION PURGE;
DROP TABLE COUNTRY PURGE;
DROP TABLE REGION PURGE;
/*										*/
/* End of dbdrop.sql script							*/
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
