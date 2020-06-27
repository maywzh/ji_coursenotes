SPOOL insert1

SET ECHO ON
SET LINESIZE 200
SET WRAP OFF


INSERT INTO student VALUES ( '152483045685', 'Wayne', 'Wong', 'CS108');
INSERT INTO student VALUES ( '152483045685', 'Wayne', 'Wong', 'CS290');
INSERT INTO student VALUES ( '459910233225', 'Lucas', 'Smith', 'CS108');


INSERT INTO hotel VALUES ('Kyono Yurinsha', 'Kyoto', 100, '3045685', 3000);
INSERT INTO hotel VALUES ('Kyono Yurinsha', 'Kyoto', 100, '5991233', 3500);
INSERT INTO hotel VALUES ('Delta Hotel', 'Toronto', 150, '10233225', 4500);
INSERT INTO hotel VALUES ('Delta Hotel', 'Toronto', 150, '24830458', 4200);

INSERT INTO building VALUES ('39840', 'Rotana Plaza', 'A1210', 'Alpha Zone', '3045685');
INSERT INTO building VALUES ('39840', 'Rotana Plaza', 'D3048', 'Delta Zone', '5991233');
INSERT INTO building VALUES ('189834', 'The Exchange 106', 'R4209', '4th Floor', '10233225');
INSERT INTO building VALUES ('189834', 'The Exchange 106', 'R4209', '4th Floor', '24830458');

INSERT INTO hotel VALUES ('FC Beijing', 'Boyi Wang', 'Nike');
INSERT INTO hotel VALUES ('FC Beijing', 'Boyi Wang', 'Adidas');
INSERT INTO hotel VALUES ('FC Beijing', 'Ronaldo Cris', 'Nike');
INSERT INTO hotel VALUES ('FC Beijing', 'Ronaldo Cris', 'Adidas');


COMMIT;

PROMPT insert1.sql done.


spool off