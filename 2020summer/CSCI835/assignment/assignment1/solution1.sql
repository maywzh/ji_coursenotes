spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment1/solution1.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON

CREATE TABLE student(
snumber	        VARCHAR(15)     NOT NULL, /* student number  */
first_name      VARCHAR(30)     NOT NULL, /* first name		*/
last_name       VARCHAR(30)	    NOT NULL, /* last name		*/
ccode           VARCHAR(30)	    NOT NULL /* course		*/
);

CREATE TABLE hotel(
name	        VARCHAR(50)     NOT NULL, /* hotel name  */
city            VARCHAR(30)     NOT NULL, /* city		*/
capacity        INTEGER         NOT NULL, /* 	capacity	*/
enumber         VARCHAR(15)     NOT NULL, /* employee number	*/
salary          DECIMAL(6)      NOT NULL /* salary	*/
);

CREATE TABLE BUILDING(
bnumber	        VARCHAR(30)     NOT NULL, /* building number */
bname           VARCHAR(30)     NOT NULL, /* building name 		*/
rnumber	        VARCHAR(50)     NOT NULL, /* room number  */
area            VARCHAR(30) 	NOT NULL, /* area	*/
enumber         VARCHAR(15)     NOT NULL  /* employee number	*/
);

CREATE TABLE team(
tname	        VARCHAR(30)     NOT NULL, /* team name */
player          VARCHAR(50)     NOT NULL, /* player name */
supporter	    VARCHAR(50)     NOT NULL /* support name  */
);

COMMIT;

PROMPT solution1.sql done.


spool off