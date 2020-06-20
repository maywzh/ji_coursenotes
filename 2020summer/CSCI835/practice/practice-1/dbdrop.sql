spool dbdrop
SET ECHO OFF
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Title:          Sample database
   Script name:    dbdrop.sql
   Task:           To drop a sample database for CSCI835 Test preparations
   Created by:	   Janusz R. Getta     
   Created on:	   23 June 2018
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

SET ECHO ON
SET LINESIZE 200
SET WRAP OFF

DROP TABLE SREQUIRED PURGE;
DROP TABLE APPLIES PURGE;
DROP TABLE SNEEDED PURGE;
DROP TABLE POSITION PURGE;
DROP TABLE SPOSSESSED PURGE;
DROP TABLE EMPLBY PURGE;
DROP TABLE EMPLOYER PURGE;
DROP TABLE APPLICANT PURGE;
DROP TABLE SKILL PURGE;

PROMPT Done.

spool off
