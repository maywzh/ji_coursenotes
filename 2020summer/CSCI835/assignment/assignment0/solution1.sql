spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment0/solution1.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON

CREATE TABLE traveller(
pnum	      VARCHAR(30)     NOT NULL, /* passport number  */
nationality   VARCHAR(30)     NOT NULL, /* nationality		*/
fname        VARCHAR(30)	      NOT NULL, /* first name		*/
lname        VARCHAR(30)	      NOT NULL, /* last name		*/
birthdate    DATE        NOT NULL, /* date of birth	*/
    CONSTRAINT traveller_pkey PRIMARY KEY ( pnum, nationality ));

CREATE TABLE hotel(
hname	      VARCHAR(30)     NOT NULL, /* hotel name  */
country      VARCHAR(30)     NOT NULL, /* country it is located in		*/
city       VARCHAR(30) 	      NOT NULL, /* city		*/
street        VARCHAR(30)       NOT NULL, /* street name		*/
bnum    VARCHAR(30)       NOT NULL, /* building number	*/
star    INTEGER       NOT NULL, /* building number	*/
    CONSTRAINT hotel_pk PRIMARY KEY ( hname, city ),
    CONSTRAINT hotel_uq UNIQUE (country, city, street, bnum));

CREATE TABLE visit(
pnum	      VARCHAR(30)     NOT NULL, /* passport number  */
nationality   VARCHAR(30)     NOT NULL, /* nationality		*/
hname	      VARCHAR(30)     NOT NULL, /* hotel name  */
hcity       VARCHAR(30) 	      NOT NULL, /* hotel city		*/
arrival_date  DATE  NOT NULL, /* arrival  date 	*/
departure_date  DATE NULL,  /* departure  date 	*/
    CONSTRAINT VISIT_FK1 FOREIGN KEY(pnum, nationality)
        REFERENCES traveller(pnum, nationality),
    CONSTRAINT VISIT_FK2 FOREIGN KEY(hname, hcity)
        REFERENCES hotel(hname, city));


COMMIT;

PROMPT solution1.sql done.


spool off