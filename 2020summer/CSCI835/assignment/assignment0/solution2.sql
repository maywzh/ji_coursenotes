spool /Users/maywzh/Workspace/ji_coursenotes/2020summer/CSCI835/assignment/assignment0/solution2.lst

SET ECHO ON
SET FEEDBACK ON 
SET LINESIZE 100 
SET PAGESIZE 200 
SET SERVEROUTPUT ON


INSERT INTO traveller VALUES ( '152483045685', 'China', 'Rui', 'Yang', TO_DATE('12-12-1990', 'DD-MM-YYYY'));
INSERT INTO traveller VALUES ( '284123045234', 'Australia', 'Dimitri', 'Williams', TO_DATE('11-MAY-1993', 'DD-MON-YYYY'));
INSERT INTO traveller VALUES ( '459910233225', 'United Kingdom', 'Lucas', 'Smith', TO_DATE('01-JAN-1984', 'DD-MON-YYYY'));

INSERT INTO hotel VALUES ('Kyono Mori Yurinsha', 'Japan', 'Kyoto', 'Shimogyo-ku Street', '603', 4);
INSERT INTO hotel VALUES ('Delta Hotel', 'Canada', 'Toronto', '15 Lower Simcoe St', 'A01', 5);
INSERT INTO hotel VALUES ('The Omni Grove Park Inn', 'US', 'Asheville', '290 Macon Ave,', '28804', 4);

INSERT INTO visit VALUES ('152483045685', 'China', 'Kyono Mori Yurinsha', 'Kyoto', TO_DATE('25-DEC-2018', 'DD-MON-YYYY'), TO_DATE('27-DEC-2018', 'DD-MON-YYYY'));
INSERT INTO visit VALUES ('284123045234', 'Australia', 'Delta Hotel', 'Toronto', TO_DATE('31-MAR-2019', 'DD-MON-YYYY'), TO_DATE('3-APR-2019', 'DD-MON-YYYY'));
INSERT INTO visit VALUES ('152483045685', 'China', 'Kyono Mori Yurinsha', 'Kyoto', TO_DATE('3-JUNE-2019', 'DD-MON-YYYY'), TO_DATE('6-JUNE-2019', 'DD-MON-YYYY'));
INSERT INTO visit VALUES ('459910233225', 'United Kingdom', 'Delta Hotel', 'Toronto', TO_DATE('18-JUNE-2020', 'DD-MON-YYYY'), NULL);

COMMIT;

PROMPT solution2.sql done.

spool off