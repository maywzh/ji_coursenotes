set echo on
set feedback on
set linesize 300

spool dbload

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Beverages', 'Soft drinks, coffees, teas, beers, and ales', 'beverages.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings', 'condiments.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Confections', 'Desserts, candies, and sweet breads', 'confections.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Dairy Products', 'Cheeses', 'diary.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Grains/Cereals', 'Breads, crackers, pasta, and cereal', 'cereals.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Meat/Poultry', 'Prepared meats', 'meat.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Produce', 'Dried fruit and bean curd', 'produce.gif');

INSERT INTO CATEGORY(CATEGORY_NAME, DESCRIPTION, PICTURE)
VALUES('Seafood', 'Seaweed and fish', 'seafood.gif');


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 
    'Obere Str. 57', 'Berlin', '12209', 'Germany', 
    '030-0074321', '030-0076545');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 
    'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico', 
    '(5) 555-4729', '(5) 555-3745');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 
    'Mataderos  2312', 'México D.F.', '05023', 'Mexico', '(5) 555-3932');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('AROUT', 'Around the Horn', 'Thomas Hardy', 'Sales Representative', 
    '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK', 
    '(171) 555-7788', '(171) 555-6750');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BERGS', 'Berglunds snabbkop', 'Christina Berglund', 'Order Administrator', 
    'Berguvsvagen  8', 'Lulea', 'S-958 22', 'Sweden', 
    '0921-12 34 65', '0921-12 34 67');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BLAUS', 'Blauer See Delikatessen', 'Hanna Moos', 'Sales Representative', 
    'Forsterstr. 57', 'Mannheim', '68306', 'Germany', 
    '0621-08460', '0621-08924');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BLONP', 'Blondel pere et fils', 'Frederique Citeaux', 'Marketing Manager', 
    '24, Place Kleber', 'Strasbourg', '67000', 'France', 
    '88.60.15.31', '88.60.15.32');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BOLID', 'Bolido Comidas preparadas', 'Martin Sommer', 'Owner', 
    'C/ Araquil, 67', 'Madrid', '28023', 'Spain', 
    '(91) 555 22 82', '(91) 555 91 99');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BONAP', 'Bon app''', 'Laurence Lebihan', 'Owner', 
    '12, rue des Bouchers', 'Marseille', '13008', 'France', 
    '91.24.45.40', '91.24.45.41');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('BOTTM', 'Bottom-Dollar Markets', 'Elizabeth Lincoln', 'Accounting Manager', 
    '23 Tsawassen Blvd.', 'Tsawassen', 'BC', 'T2F 8M4', 'Canada', 
    '(604) 555-4729', '(604) 555-3745');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('BSBEV', 'B''s Beverages', 'Victoria Ashworth', 'Sales Representative', 
    'Fauntleroy Circus', 'London', 'EC2 5NT', 'UK', '(171) 555-1212');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('CACTU', 'Cactus Comidas para llevar', 'Patricio Simpson', 'Sales Agent', 
    'Cerrito 333', 'Buenos Aires', '1010', 'Argentina', 
    '(1) 135-5555', '(1) 135-4892');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('CENTC', 'Centro comercial Moctezuma', 'Francisco Chang', 'Marketing Manager', 
    'Sierras de Granada 9993', 'Mexico D.F.', '05022', 'Mexico', 
    '(5) 555-3392', '(5) 555-7293');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('CHOPS', 'Chop-suey Chinese', 'Yang Wang', 'Owner', 
    'Hauptstr. 29', 'Bern', '3012', 'Switzerland', '0452-076545');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('COMMI', 'Comercio Mineiro', 'Pedro Afonso', 'Sales Associate', 
    'Av. dos Lusiadas, 23', 'São Paulo', 'SP', '05432-043', 'Brazil', 
    '(11) 555-7647');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('CONSH', 'Consolidated Holdings', 'Elizabeth Brown', 'Sales Representative', 
    'Berkeley Gardens 12  Brewery ', 'London', 'WX1 6LT', 'UK', 
    '(171) 555-2282', '(171) 555-9199');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('DRACD', 'Drachenblut Delikatessen', 'Sven Ottlieb', 'Order Administrator', 
    'Walserweg 21', 'Aachen', '52066', 'Germany', 
    '0241-039123', '0241-059428');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('DUMON', 'Du monde entier', 'Janine Labrune', 'Owner', 
    '67, rue des Cinquante Otages', 'Nantes', '44000', 'France', 
    '40.67.88.88', '40.67.89.89');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('EASTC', 'Eastern Connection', 'Ann Devon', 'Sales Agent', 
    '35 King George', 'London', 'WX3 6FW', 'UK', 
    '(171) 555-0297', '(171) 555-3373');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('ERNSH', 'Ernst Handel', 'Roland Mendel', 'Sales Manager', 
    'Kirchgasse 6', 'Graz', '8010', 'Austria', 
    '7675-3425', '7675-3426');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('FAMIA', 'Familia Arquibaldo', 'Aria Cruz', 'Marketing Assistant', 
    'Rua Oros, 92', 'São Paulo', 'SP', '05442-030', 'Brazil', 
    '(11) 555-9857');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FISSA', 'FISSA Fabrica Inter. Salchichas S.A.', 'Diego Roel', 'Accounting Manager', 
    'C/ Moralzarzal, 86', 'Madrid', '28034', 'Spain', 
    '(91) 555 94 44', '(91) 555 55 93');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FOLIG', 'Folies gourmandes', 'Martine Rance', 'Assistant Sales Agent', 
    '184, chaussée de Tournai', 'Lille', '59000', 'France', 
    '20.16.10.16', '20.16.10.17');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('FOLKO', 'Folk och fa HB', 'Maria Larsson', 'Owner', 
    'Åkergatan 24', 'Bräcke', 'S-844 67', 'Sweden', '0695-34 67 21');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FRANK', 'Frankenversand', 'Peter Franken', 'Marketing Manager', 
    'Berliner Platz 43', 'München', '80805', 'Germany', 
    '089-0877310', '089-0877451');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FRANR', 'France restauration', 'Carine Schmitt', 'Marketing Manager', 
    '54, rue Royale', 'Nantes', '44000', 'France', 
    '40.32.21.21', '40.32.21.20');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FRANS', 'Franchi S.p.A.', 'Paolo Accorti', 'Sales Representative', 
    'Via Monte Bianco 34', 'Torino', '10100', 'Italy', 
    '011-4988260', '011-4988261');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('FURIB', 'Furia Bacalhau e Frutos do Mar', 'Lino Rodriguez ', 'Sales Manager', 
    'Jardim das rosas n. 32', 'Lisboa', '1675', 'Portugal', 
    '(1) 354-2534', '(1) 354-2535');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('GALED', 'Galería del gastrónomo', 'Eduardo Saavedra', 'Marketing Manager', 
    'Rambla de Cataluña, 23', 'Barcelona', '08022', 'Spain', 
    '(93) 203 4560', '(93) 203 4561');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('GODOS', 'Godos Cocina Típica', 'Jose Pedro Freyre', 'Sales Manager', 
    'C/ Romero, 33', 'Sevilla', '41101', 'Spain', '(95) 555 82 82');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('GOURL', 'Gourmet Lanchonetes', 'André Fonseca', 'Sales Associate', 
    'Av. Brasil, 442', 'Campinas', 'SP', '04876-786', 'Brazil', 
    '(11) 555-9482');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('GREAL', 'Great Lakes Food Market', 'Howard Snyder', 'Marketing Manager', 
    '2732 Baker Blvd.', 'Eugene', 'OR', '97403', 'USA', 
    '(503) 555-7555');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('GROSR', 'GROSELLA-Restaurante', 'Manuel Pereira', 'Owner', 
    '5ª Ave. Los Palos Grandes', 'Caracas', 'DF', '1081', 'Venezuela', 
    '(2) 283-2951', '(2) 283-3397');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('HANAR', 'Hanari Carnes', 'Mario Pontes', 'Accounting Manager', 
    'Rua do Paco, 67', 'Rio de Janeiro', 'RJ', '05454-876', 'Brazil', 
    '(21) 555-0091', '(21) 555-8765');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('HILAA', 'HILARION-Abastos', 'Carlos Hernandez', 'Sales Representative', 
    'Carrera 22 con Ave. Carlos Soublette #8-35', 'San Cristobal', 'Tachira', '5022', 'Venezuela', 
    '(5) 555-1340', '(5) 555-1948');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('HUNGC', 'Hungry Coyote Import Store', 'Yoshi Latimer', 'Sales Representative', 
    'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', 'USA', 
    '(503) 555-6874', '(503) 555-2376');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, COUNTRY, PHONE, FAX)
 VALUES
   ('HUNGO', 'Hungry Owl All-Night Grocers', 'Patricia McKenna', 'Sales Associate', 
    '8 Johnstown Road', 'Cork', 'Co. Cork', 'Ireland', 
    '2967 542', '2967 3333');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('ISLAT', 'Island Trading', 'Helen Bennett', 'Marketing Manager', 
    'Garden House Crowther Way', 'Cowes', 'Isle of Wight', 'PO31 7PJ', 'UK', 
    '(198) 555-8888');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('KOENE', 'Koniglich Essen', 'Philip Cramer', 'Sales Associate', 
    'Maubelstr. 90', 'Brandenburg', '14776', 'Germany', '0555-09876');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LACOR', 'La corne d''abondance', 'Daniel Tonini', 'Sales Representative', 
    '67, avenue de l''Europe', 'Versailles', '78000', 'France', 
    '30.59.84.10', '30.59.85.11');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LAMAI', 'La maison d''Asie', 'Annette Roulet', 'Sales Manager', 
    '1 rue Alsace-Lorraine', 'Toulouse', '31000', 'France', 
    '61.77.61.10', '61.77.61.11');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LAUGB', 'Laughing Bacchus Wine Cellars', 'Yoshi Tannamuri', 'Marketing Assistant', 
    '1900 Oak St.', 'Vancouver', 'BC', 'V3F 2K1', 'Canada', 
    '(604) 555-3392', '(604) 555-7293');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LAZYK', 'Lazy K Kountry Store', 'John Steel', 'Marketing Manager', 
    '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', 'USA', 
    '(509) 555-7969', '(509) 555-6221');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LEHMS', 'Lehmanns Marktstand', 'Renate Messner', 'Sales Representative', 
    'Magazinweg 7', 'Frankfurt a.M. ', '60528', 'Germany', 
    '069-0245984', '069-0245874');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('LETSS', 'Let''s Stop N Shop', 'Jaime Yorres', 'Owner', 
    '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', 'USA', 
    '(415) 555-5938');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LILAS', 'LILA-Supermercado', 'Carlos Gonzalez', 'Accounting Manager', 
    'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 'Barquisimeto', 'Lara', '3508', 'Venezuela', 
    '(9) 331-6954', '(9) 331-7256');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LINOD', 'LINO-Delicateses', 'Felipe Izquierdo', 'Owner', 
    'Ave. 5 de Mayo Porlamar', 'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela', 
    '(8) 34-56-12', '(8) 34-93-93');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('LONEP', 'Lonesome Pine Restaurant', 'Fran Wilson', 'Sales Manager', 
    '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', 'USA', 
    '(503) 555-9573', '(503) 555-9646');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('MAGAA', 'Magazzini Alimentari Riuniti', 'Giovanni Rovelli', 'Marketing Manager', 
    'Via Ludovico il Moro 22', 'Bergamo', '24100', 'Italy', 
    '035-640230', '035-640231');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('MAISD', 'Maison Dewey', 'Catherine Dewey', 'Sales Agent', 
    'Rue Joseph-Bens 532', 'Bruxelles', 'B-1180', 'Belgium', 
    '(02) 201 24 67', '(02) 201 24 68');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('MEREP', 'Mere Paillarde', 'Jean Fresniere', 'Marketing Assistant', 
    '43 rue St. Laurent', 'Montreal', 'Quebec', 'H1J 1C3', 'Canada', 
    '(514) 555-8054', '(514) 555-8055');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('MORGK', 'Morgenstern Gesundkost', 'Alexander Feuer', 'Marketing Assistant', 
    'Heerstr. 22', 'Leipzig', '04179', 'Germany', '0342-023176');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('NORTS', 'North/South', 'Simon Crowther', 'Sales Associate', 
    'South House 300 Queensbridge', 'London', 'SW7 1RZ', 'UK', 
    '(171) 555-7733', '(171) 555-2530');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('OCEAN', 'Océano Atlantico Ltda.', 'Yvonne Moncada', 'Sales Agent', 
    'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '1010', 'Argentina', 
    '(1) 135-5333', '(1) 135-5535');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('OLDWO', 'Old World Delicatessen', 'Rene Phillips', 'Sales Representative', 
    '2743 Bering St.', 'Anchorage', 'AK', '99508', 'USA', 
    '(907) 555-7584', '(907) 555-2880');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('OTTIK', 'Ottilies Kaseladen', 'Henriette Pfalzheim', 'Owner', 
    'Mehrheimerstr. 369', 'Koln', '50739', 'Germany', 
    '0221-0644327', '0221-0765721');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('PARIS', 'Paris specialites', 'Marie Bertrand', 'Owner', 
    '265, Boulevard Charonne', 'Paris', '75012', 'France', 
    '(1) 42.34.22.66', '(1) 42.34.22.77');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('PERIC', 'Pericles Comidas clasicas', 'Guillermo Fernandez', 'Sales Representative', 
    'Calle Dr. Jorge Cash 321', 'Mexico D.F.', '05033', 'Mexico', 
    '(5) 552-3745', '(5) 545-3745');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('PICCO', 'Piccolo und mehr', 'Georg Pipps', 'Sales Manager', 
    'Geislweg 14', 'Salzburg', '5020', 'Austria', 
    '6562-9722', '6562-9723');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('PRINI', 'Princesa Isabel Vinhos', 'Isabel de Castro', 'Sales Representative', 
    'Estrada da saúde n. 58', 'Lisboa', '1756', 'Portugal', '(1) 356-5634');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('QUEDE', 'Que Delícia', 'Bernardo Batista', 'Accounting Manager', 
    'Rua da Panificadora, 12', 'Rio de Janeiro', 'RJ', '02389-673', 'Brazil', 
    '(21) 555-4252', '(21) 555-4545');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('QUEEN', 'Queen Cozinha', 'Lúcia Carvalho', 'Marketing Assistant', 
    'Alameda dos Canàrios, 891', 'São Paulo', 'SP', '05487-020', 'Brazil', 
    '(11) 555-1189');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('QUICK', 'QUICK-Stop', 'Horst Kloss', 'Accounting Manager', 
    'Taucherstraße 10', 'Cunewalde', '01307', 'Germany', '0372-035188');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('RANCH', 'Rancho grande', 'Sergio Gutierrez', 'Sales Representative', 
    'Av. del Libertador 900', 'Buenos Aires', '1010', 'Argentina', 
    '(1) 123-5555', '(1) 123-5556');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('RATTC', 'Rattlesnake Canyon Grocery', 'Paula Wilson', 'Assistant Sales Representative', 
    '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA', 
    '(505) 555-5939', '(505) 555-3620');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('REGGC', 'Reggiani Caseifici', 'Maurizio Moroni', 'Sales Associate', 
    'Strada Provinciale 124', 'Reggio Emilia', '42100', 'Italy', 
    '0522-556721', '0522-556722');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('RICAR', 'Ricardo Adocicados', 'Janete Limeira', 'Assistant Sales Agent', 
    'Av. Copacabana, 267', 'Rio de Janeiro', 'RJ', '02389-890', 'Brazil', 
    '(21) 555-3412');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('RICSU', 'Richter Supermarkt', 'Michael Holz', 'Sales Manager', 
    'Grenzacherweg 237', 'Geneve', '1203', 'Switzerland', '0897-034214');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('ROMEY', 'Romero y tomillo', 'Alejandra Camino', 'Accounting Manager', 
    'Gran Via, 1', 'Madrid', '28001', 'Spain', 
    '(91) 745 6200', '(91) 745 6210');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SANTG', 'Santé Gourmet', 'Jonas Bergulfsen', 'Owner', 
    'Erling Skakkes gate 78', 'Stavern', '4110', 'Norway', 
    '07-98 92 35', '07-98 92 47');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('SAVEA', 'Save-a-lot Markets', 'Jose Pavarotti', 'Sales Representative', 
    '187 Suffolk Ln.', 'Boise', 'ID', '83720', 'USA', 
    '(208) 555-8097');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SEVES', 'Seven Seas Imports', 'Hari Kumar', 'Sales Manager', 
    '90 Wadhurst Rd.', 'London', 'OX15 4NB', 'UK', 
    '(171) 555-1717', '(171) 555-5646');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SIMOB', 'Simons bistro', 'Jytte Petersen', 'Owner', 
    'Vinbæltet 34', 'Kobenhavn', '1734', 'Denmark', 
    '31 12 34 56', '31 13 35 57');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SPECD', 'Specialites du monde', 'Dominique Perrier', 'Marketing Manager', 
    '25, rue Lauriston', 'Paris', '75016', 'France', 
    '(1) 47.55.60.10', '(1) 47.55.60.20');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SPLIR', 'Split Rail Beer And Ale', 'Art Braunschweiger', 'Sales Manager', 
    'P.O. Box 555', 'Lander', 'WY', '82520', 'USA', 
    '(307) 555-4680', '(307) 555-6525');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('SUPRD', 'Supremes delices', 'Pascale Cartrain', 'Accounting Manager', 
    'Boulevard Tirou, 255', 'Charleroi', 'B-6000', 'Belgium', 
    '(071) 23 67 22 20', '(071) 23 67 22 21');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('THEBI', 'The Big Cheese', 'Liz Nixon', 'Marketing Manager', 
    '89 Jefferson Way Suite 2', 'Portland', 'OR', '97201', 'USA', 
    '(503) 555-3612');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('THECR', 'The Cracker Box', 'Liu Wong', 'Marketing Assistant', 
    '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', 'USA', 
    '(406) 555-5834', '(406) 555-8083');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('TOMSP', 'Toms Spezialitaten', 'Karin Josephs', 'Marketing Manager', 
    'Luisenstr. 48', 'Munster', '44087', 'Germany', 
    '0251-031259', '0251-035695');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('TORTU', 'Tortuga Restaurante', 'Miguel Angel Paolino', 'Owner', 
    'Avda. Azteca 123', 'México D.F.', '05033', 'Mexico', '(5) 555-2933');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('TRADH', 'Tradicao Hipermercados', 'Anabela Domingues', 'Sales Representative', 
    'Av. Ines de Castro, 414', 'Sao Paulo', 'SP', '05634-030', 'Brazil', 
    '(11) 555-2167', '(11) 555-2168');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('TRAIH', 'Trail''s Head Gourmet Provisioners', 'Helvetius Nagy', 'Sales Associate', 
    '722 DaVinci Blvd.', 'Kirkland', 'WA', '98034', 'USA', 
    '(206) 555-8257', '(206) 555-2174');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('VAFFE', 'Vaffeljernet', 'Palle Ibsen', 'Sales Manager', 
    'Smagsløget 45', 'Århus', '8200', 'Denmark', 
    '86 21 32 43', '86 22 33 44');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('VICTE', 'Victuailles en stock', 'Mary Saveley', 'Sales Agent', 
    '2, rue du Commerce', 'Lyon', '69004', 'France', 
    '78.32.54.86', '78.32.54.87');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('VINET', 'Vins et alcools Chevalier', 'Paul Henriot', 'Accounting Manager', 
    '59 rue de l''Abbaye', 'Reims', '51100', 'France', 
    '26.47.15.10', '26.47.15.11');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('WANDK', 'Die Wandernde Kuh', 'Rita Müller', 'Sales Representative', 
    'Adenauerallee 900', 'Stuttgart', '70563', 'Germany', 
    '0711-020361', '0711-035428');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('WARTH', 'Wartian Herkku', 'Pirkko Koskitalo', 'Accounting Manager', 
    'Torikatu 38', 'Oulu', '90110', 'Finland', 
    '981-443655', '981-443655');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
 VALUES
   ('WELLI', 'Wellington Importadora', 'Paula Parente', 'Sales Manager', 
    'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil', 
    '(14) 555-8122');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('WHITC', 'White Clover Markets', 'Karl Jablonski', 'Owner', 
    '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', 'USA', 
    '(206) 555-4112', '(206) 555-4115');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('WILMK', 'Wilman Kala', 'Matti Karttunen', 'Owner/Marketing Assistant', 
    'Keskuskatu 45', 'Helsinki', '21240', 'Finland', 
    '90-224 8858', '90-224 8858');

INSERT INTO CUSTOMER
   (CUSTOMER_CODE, COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
 VALUES
   ('WOLZA', 'Wolski  Zajazd', 'Zbyszek Piestrzeniewicz', 'Owner', 
    'ul. Filtrowa 68', 'Warszawa', '01-012', 'Poland', 
    '(26) 642-7012', '(26) 642-7012');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(1, 'Davolio', 'Nancy', 'Sales Representative', 'Ms.', TO_DATE('12-08-1968', 'MM-DD-YYYY'), TO_DATE('05-01-1992', 'MM-DD-YYYY'), '507 - 20th Ave. E.Apt. 2A', 'Seattle', 'WA',     '98122', 'USA', '(206) 555-9857', '5467', 'nancy.jpg',     'Education includes a BA in psychology from Colorado State University.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.', 2);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES)
VALUES(2, 'Fuller', 'Andrew', 'Vice President, Sales', 'Dr.', TO_DATE('02-19-1952', 'MM-DD-YYYY'), TO_DATE('08-14-1992', 'MM-DD-YYYY'), '908 W. Capital Way', 'Tacoma', 'WA', '98401', 'USA', '(206) 555-9482', '3457', 'andrew  .jpg', 'Andrew received his BTS commercial and a Ph.D. in international marketing from the University of Dallas.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.');

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(3, 'Leverling', 'Janet', 'Sales Representative', 'Ms.', TO_DATE('08-30-1963', 'MM-DD-YYYY'), TO_DATE('04-01-1992', 'MM-DD-YYYY'), '722 Moss Bay Blvd.', 'Kirkland', 'WA', '98033', 'USA', '(206) 555-3412', '3355', 'janet.jpg', 'Janet has a BS degree in chemistry from Boston College).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate and was promoted to sales representative.', 2);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(4, 'Peacock', 'Margaret', 'Sales Representative', 'Mrs.', TO_DATE('09-19-1958', 'MM-DD-YYYY'), TO_DATE('05-03-1993', 'MM-DD-YYYY'), '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 'USA', '(206) 555-8122', '5176', 'margaret.jpg', 'Margaret holds a BA in English literature from Concordia College and an MA from the American Institute of Culinary Arts. She was temporarily assigned to the London office before returning to her permanent post in Seattle.', 2);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(5, 'Buchanan', 'Steven', 'Sales Manager', 'Mr.', TO_DATE('03-04-1955', 'MM-DD-YYYY'), TO_DATE('10-17-1993', 'MM-DD-YYYY'), '14 Garrett Hill', 'London', 'SW1 8JR', 'UK', '(71) 555-4848', '3453', 'steven.jpg', 'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree.  Upon joining the company as a sales representative, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London, where he was promoted to sales manager.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.', 2);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(6, 'Suyama', 'Michael', 'Sales Representative', 'Mr.', TO_DATE('07-02-1963', 'MM-DD-YYYY'), TO_DATE('10-17-1993', 'MM-DD-YYYY'), 'Coventry House Miner Rd.', 'London', 'EC2 7JR', 'UK', '(71) 555-7773', '428', 'michael.jpg', 'Michael is a graduate of Sussex University (MA, economics) and the University of California at Los Angeles (MBA, marketing).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 5);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(7, 'King', 'Robert', 'Sales Representative', 'Mr.', TO_DATE('05-29-1960', 'MM-DD-YYYY'), TO_DATE('01-02-1994', 'MM-DD-YYYY'), 'Edgeham Hollow Winchester Way', 'London', 'RG1 9SP', 'UK', '(71) 555-5598', '465', 'robert.jpg', 'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan and then joining the company.  After completing a course entitled "Selling in Europe," he was transferred to the London office.', 5);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(8, 'Callahan', 'Laura', 'Inside Sales Coordinator', 'Ms.', TO_DATE('01-09-1958', 'MM-DD-YYYY'), TO_DATE('03-05-1994', 'MM-DD-YYYY'), '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 'USA', '(206) 555-1189', '2344', 'laura.jpg', 'Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.', 2);

INSERT INTO EMPLOYEE(EMPLOYEE_ID, LASTNAME, FIRSTNAME, TITLE, TITLE_OF_COURTESY, BIRTHDATE, HIREDATE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, HOME_PHONE, EXTENSION, PHOTO, NOTES, REPORTS_TO)
VALUES(9, 'Dodsworth', 'Anne', 'Sales Representative', 'Ms.', TO_DATE('07-02-1969', 'MM-DD-YYYY'), TO_DATE('11-15-1994', 'MM-DD-YYYY'), '7 Houndstooth Rd.', 'London', 'WG2 7LT', 'UK', '(71) 555-4444', '452', 'anne.jpg', 'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_REPORTS_TO FOREIGN KEY (REPORTS_TO) REFERENCES EMPLOYEE(EMPLOYEE_ID);

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Exotic Liquids', 'Charlotte Cooper', 'Purchasing Manager', '49 Gilbert St.', 'London', 'EC1 4SD', 'UK', '(171) 555-2222');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
VALUES('New Orleans Cajun Delights', 'Shelley Burke', 'Order Administrator', 'P.O. Box 78934', 'New Orleans', 'LA', '70117', 'USA', '(100) 555-4822');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Grandma Kelly''s Homestead', 'Regina Murphy', 'Sales Representative', '707 Oxford Rd.', 'Ann Arbor', 'MI', '48104', 'USA', '(313) 555-5735', '(313) 555-3349');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Tokyo Traders', 'Yoshi Nagase', 'Marketing Manager', '9-8 SekimaiMusashino-shi', 'Tokyo', '100', 'Japan', '(03) 3555-5011');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Cooperativa de Quesos ''Las Cabras''', 'Antonio del Valle Saavedra ', 'Export Administrator', 'Calle del Rosal 4', 'Oviedo', 'Asturias', '33007', 'Spain', '(98) 598 76 54');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Mayumi''s', 'Mayumi Ohno', 'Marketing Representative', '92 SetsukoChuo-ku', 'Osaka', '545', 'Japan', '(06) 431-7877');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Pavlova, Ltd.', 'Ian Devling', 'Marketing Manager', '74 Rose St.Moonie Ponds', 'Melbourne', 'Victoria', '3058', 'Australia', '(03) 444-2343', '(03) 444-6588');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Specialty Biscuits, Ltd.', 'Peter Wilson', 'Sales Representative', '29 King''s Way', 'Manchester', 'M14 GSD', 'UK', '(161) 555-4448');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('PB Knackebrod AB', 'Lars Peterson', 'Sales Agent', 'Kaloadagatan 13', 'Göteborg', 'S-345 67', 'Sweden ', '031-987 65 43', '031-987 65 91');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Refrescos Americanas LTDA', 'Carlos Diaz', 'Marketing Manager', 'Av. das Americanas 12.890', 'São Paulo', '5442', 'Brazil', '(11) 555 4640');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Heli Susswaren GmbH And Co. KG', 'Petra Winkler', 'Sales Manager', 'Tiergartenstraße 5', 'Berlin', '10785', 'Germany', '(010) 9984510');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Plutzer Lebensmittelgrossmarkte AG', 'Martin Bein', 'International Marketing Mgr.', 'Bogenallee 51', 'Frankfurt', '60439', 'Germany', '(069) 992755');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Nord-Ost-Fisch Handelsgesellschaft mbH', 'Sven Petersen', 'Coordinator Foreign Markets', 'Frahmredder 112a', 'Cuxhaven', '27478', 'Germany', '(04721) 8713', '(04721) 8714');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Formaggi Fortini s.r.l.', 'Elio Rossi', 'Sales Representative', 'Viale Dante, 75', 'Ravenna', '48100', 'Italy', '(0544) 60323', '(0544) 60603');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Norske Meierier', 'Beate Vileid', 'Marketing Manager', 'Hatlevegen 5', 'Sandvika', '1320', 'Norway', '(0)2-953010');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Bigfoot Breweries', 'Cheryl Saylor', 'Regional Account Rep.', '3400 - 8th AvenueSuite 210', 'Bend', 'OR', '97101', 'USA', '(503) 555-9931');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Svensk Sjofoda AB', 'Michael Björn', 'Sales Representative', 'Brovallavägen 231', 'Stockholm', 'S-123 45', 'Sweden', '08-123 45 67');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Aux joyeux ecclesiastiques', 'Guylene Nodier', 'Sales Manager', '203, Rue des Francs-Bourgeois', 'Paris', '75004', 'France', '(1) 03.83.00.68', '(1) 03.83.00.62');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('New England Seafood Cannery', 'Robb Merchant', 'Wholesale Account Agent', 'Order Processing Dept. 2100 Paul Revere Blvd.', 'Boston', 'MA', '02134', 'USA', '(617) 555-3267', '(617) 555-3389');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Leka Trading', 'Chandra Leka', 'Owner', '471 Serangoon Loop, Suite #402', 'Singapore', '0512', 'Singapore', '555-8787');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Lyngbysild', 'Niels Petersen', 'Sales Manager', 'LyngbysildFiskebakken 10', 'Lyngby', '2800', 'Denmark', '43844108', '43844115');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Zaanse Snoepfabriek', 'Dirk Luchte', 'Accounting Manager', 'VerkoopRijnweg 22', 'Zaandam', '9999 ZZ', 'Netherlands', '(12345) 1212', '(12345) 1210');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Karkki Oy', 'Anne Heikkonen', 'Product Manager', 'Valtakatu 12', 'Lappeenranta', '53120', 'Finland', '(953) 10956');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('G''day, Mate', 'Wendy Mackenzie', 'Sales Representative', '170 Prince Edward ParadeHunter''s Hill', 'Sydney', 'NSW', '2042', 'Australia', '(02) 555-5914', '(02) 555-4873');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Ma Maison', 'Jean-Guy Lauzon', 'Marketing Manager', '2960 Rue St. Laurent', 'Montréal', 'Québec', 'H1J 1C3', 'Canada', '(514) 555-9022');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Pasta Buttini s.r.l.', 'Giovanni Giudici', 'Order Administrator', 'Via dei Gelsomini, 153', 'Salerno', '84100', 'Italy', '(089) 6547665', '(089) 6547667');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE)
VALUES('Escargots Nouveaux', 'Marie Delamare', 'Sales Manager', '22, rue H. Voiron', 'Montceau', '71300', 'France', '85.57.00.07');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Gai paturage', 'Eliane Noz', 'Sales Representative', 'Bat. B3, rue des Alpes', 'Annecy', '74000', 'France', '38.76.98.06', '38.76.98.58');

INSERT INTO SUPPLIER(COMPANY_NAME, CONTACT_NAME, CONTACT_TITLE, ADDRESS, CITY, REGION, POSTAL_CODE, COUNTRY, PHONE, FAX)
VALUES('Forets d''erables', 'Chantal Goulet', 'Accounting Manager', '148 rue Chasseur', 'Ste-Hyacinthe', 'Quebec', 'J2S 7S8', 'Canada', '(514) 555-2955', '(514) 555-2921');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

INSERT INTO SHIPPER(COMPANY_NAME, PHONE)
VALUES('Speedy Express', '(503) 555-9831');

INSERT INTO SHIPPER(COMPANY_NAME, PHONE)
VALUES('United Package', '(503) 555-3199');

INSERT INTO SHIPPER(COMPANY_NAME, PHONE)
VALUES('Federal Shipping', '(503) 555-9931');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chai', 'Exotic Liquids', 'Beverages', '10 boxes x 20 bags', 
    18, 39, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chang', 'Exotic Liquids', 'Beverages', '24 - 12 oz bottles', 
    19, 17, 40, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Aniseed Syrup', 'Exotic Liquids', 'Condiments', '12 - 550 ml bottles', 
    10, 13, 70, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chef Anton''s Cajun Seasoning', 'New Orleans Cajun Delights', 'Condiments', '48 - 6 oz jars', 
    25, 53, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chef Anton''s Gumbo Mix', 'New Orleans Cajun Delights', 'Condiments', '36 boxes', 
    21.35, 0, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Grandma''s Boysenberry Spread', 'Grandma Kelly''s Homestead', 'Condiments', '12 - 8 oz jars', 
    25, 120, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Uncle Bob''s Organic Dried Pears', 'Grandma Kelly''s Homestead','Produce', '12 - 1 lb pkgs.', 
    30, 15, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Northwoods Cranberry Sauce', 'Grandma Kelly''s Homestead', 'Condiments', '12 - 12 oz jars', 
    40, 6, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Mishi Kobe Niku', 'Tokyo Traders', 'Meat/Poultry', '18 - 500 g pkgs.', 
    97, 29, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Ikura', 'Tokyo Traders', 'Seafood', '12 - 200 ml jars', 
    31, 31, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Queso Cabrales','Cooperativa de Quesos ''Las Cabras''', 'Dairy Products', '1 kg pkg.', 
    21, 22, 30, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Queso Manchego La Pastora','Cooperativa de Quesos ''Las Cabras''', 'Dairy Products', '10 - 500 g pkgs.', 
    38, 86, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Konbu', 'Mayumi''s', 'Seafood', '2 kg box', 
    6, 24, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Tofu','Mayumi''s','Produce', '40 - 100 g pkgs.', 
    23.25, 35, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Genen Shouyu','Mayumi''s', 'Condiments', '24 - 250 ml bottles', 
    15.5, 39, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Pavlova','Pavlova, Ltd.', 'Confections', '32 - 500 g boxes', 
    17.45, 29, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Alice Mutton','Pavlova, Ltd.', 'Meat/Poultry', '20 - 1 kg tins', 
    39, 0, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Carnarvon Tigers','Pavlova, Ltd.', 'Seafood', '16 kg pkg.', 
    62.5, 42, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Teatime Chocolate Biscuits','Specialty Biscuits, Ltd.', 'Confections', '10 boxes x 12 pieces', 
    9.2, 25, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Sir Rodney''s Marmalade','Specialty Biscuits, Ltd.', 'Confections', '30 gift boxes', 
    81, 40, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Sir Rodney''s Scones','Specialty Biscuits, Ltd.', 'Confections', '24 pkgs. x 4 pieces', 
    10, 3, 40, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gustaf''s Knackebrod','PB Knackebrod AB',  'Confections', '24 - 500 g pkgs.', 
    21, 104, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Tunnbrod','PB Knackebrod AB', 'Grains/Cereals', '12 - 250 g pkgs.', 
    9, 61, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Guarana Fantastica', 'Refrescos Americanas LTDA', 'Beverages', '12 - 355 ml cans', 
    4.5, 20, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('NuNuCa Nuss-Nougat-Creme', 'Heli Susswaren GmbH And Co. KG', 'Confections', '20 - 450 g glasses', 
    14, 76, 0, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gumbar Gummibarchen', 'Heli Susswaren GmbH And Co. KG', 'Confections', '100 - 250 g bags', 
    31.23, 15, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Schoggi Schokolade', 'Heli Susswaren GmbH And Co. KG', 'Confections', '100 - 100 g pieces', 
    43.9, 49, 0, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Rossle Sauerkraut', 'Plutzer Lebensmittelgrossmarkte AG', 'Produce', '25 - 825 g cans', 
    45.6, 26, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Thuringer Rostbratwurst', 'Plutzer Lebensmittelgrossmarkte AG', 'Meat/Poultry', '50 bags x 30 sausgs.', 
    123.79, 0, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Nord-Ost Matjeshering', 'Nord-Ost-Fisch Handelsgesellschaft mbH', 'Seafood', '10 - 200 g glasses', 
    25.89, 10, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gorgonzola Telino','Formaggi Fortini s.r.l.', 'Dairy Products', '12 - 100 g pkgs', 
    12.5, 0, 70, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Mascarpone Fabioli','Formaggi Fortini s.r.l.', 'Dairy Products', '24 - 200 g pkgs.', 
    32, 9, 40, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Geitost', 'Norske Meierier', 'Dairy Products', '500 g', 
    2.5, 112, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Sasquatch Ale', 'Bigfoot Breweries', 'Beverages', '24 - 12 oz bottles', 
    14, 111, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Steeleye Stout', 'Bigfoot Breweries', 'Beverages', '24 - 12 oz bottles', 
    18, 20, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Inlagd Sill', 'Svensk Sjofoda AB', 'Seafood', '24 - 250 g  jars', 
    19, 112, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gravad lax', 'Svensk Sjofoda AB', 'Seafood', '12 - 500 g pkgs.', 
    26, 11, 50, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Côte de Blaye', 'Aux joyeux ecclesiastiques', 'Beverages', '12 - 75 cl bottles', 
    263.5, 17, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chartreuse verte', 'Pavlova, Ltd.', 'Beverages', '750 cc per bottle', 
    102.1, 69, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Boston Crab Meat', 'New England Seafood Cannery', 'Seafood', '24 - 4 oz tins', 
    18.4, 123, 0, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Jack''s New England Clam Chowder', 'New England Seafood Cannery', 'Seafood', '12 - 12 oz cans', 
    9.65, 85, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Singaporean Hokkien Fried Mee', 'Leka Trading', 'Grains/Cereals', '32 - 1 kg pkgs.', 
    14, 26, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Ipoh Coffee', 'Leka Trading', 'Beverages', '16 - 500 g tins', 
    46, 17, 10, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gula Malacca', 'Leka Trading', 'Condiments', '20 - 2 kg bags', 
    19.45, 27, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Rogede sild', 'Lyngbysild', 'Seafood', '1k pkg.', 
    9.5, 5, 70, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Spegesild', 'Lyngbysild', 'Seafood', '4 - 450 g glasses', 
    12, 95, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Zaanse koeken', 'Zaanse Snoepfabriek', 'Confections', '10 - 4 oz boxes', 
    9.5, 36, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Chocolade', 'Zaanse Snoepfabriek', 'Confections', '10 pkgs.', 
    12.75, 15, 70, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Maxilaku', 'Karkki Oy', 'Confections', '24 - 50 g pkgs.', 
    20, 10, 60, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Valkoinen suklaa', 'Karkki Oy', 'Confections', '12 - 100 g bars', 
    16.25, 65, 0, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Manjimup Dried Apples', 'G''day, Mate','Produce', '50 - 300 g pkgs.', 
    53, 20, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Filo Mix', 'G''day, Mate', 'Grains/Cereals', '16 - 2 kg boxes', 
    7, 38, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Perth Pasties', 'G''day, Mate', 'Meat/Poultry', '48 pieces', 
    32.8, 0, 0, 0, 'Y');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Tourtiere', 'Ma Maison', 'Meat/Poultry', '16 pies', 
    7.45, 21, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Pate chinois', 'Ma Maison', 'Meat/Poultry', '24 boxes x 2 pies', 
    24, 115, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gnocchi di nonna Alice', 'Pasta Buttini s.r.l.', 'Grains/Cereals', '24 - 250 g pkgs.', 
    38, 21, 10, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Ravioli Angelo', 'Pasta Buttini s.r.l.', 'Grains/Cereals', '24 - 250 g pkgs.', 
    19.5, 36, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Escargots de Bourgogne', 'Escargots Nouveaux', 'Seafood', '24 pieces', 
    13.25, 62, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Raclette Courdavault',  'Gai paturage', 'Dairy Products', '5 kg pkg.', 
    55, 79, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Camembert Pierrot',  'Gai paturage', 'Dairy Products', '15 - 300 g rounds', 
    34, 19, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Sirop d''erable',  'Forets d''erables', 'Condiments', '24 - 500 ml bottles', 
    28.5, 113, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Tarte au sucre',  'Forets d''erables', 'Confections', '48 pies', 
    49.3, 17, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Vegie-spread','Pavlova, Ltd.', 'Condiments', '15 - 625 g jars', 
    43.9, 24, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Wimmers gute Semmelknodel', 'Plutzer Lebensmittelgrossmarkte AG', 'Grains/Cereals', '20 bags x 4 pieces', 
    33.25, 22, 80, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Louisiana Fiery Hot Pepper Sauce', 'New Orleans Cajun Delights', 'Condiments', '32 - 8 oz bottles', 
    21.05, 76, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Louisiana Hot Spiced Okra', 'New Orleans Cajun Delights', 'Condiments', '24 - 8 oz jars', 
    17, 5, 100, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Laughing Lumberjack Lager', 'Bigfoot Breweries', 'Beverages', '24 - 12 oz bottles', 
    14, 52, 0, 10, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Scottish Longbreads',  'Specialty Biscuits, Ltd.', 'Confections', '10 boxes x 8 pieces', 
    12.5, 4, 10, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Gudbrandsdalsost', 'Norske Meierier', 'Dairy Products', '10 kg pkg.', 
    36, 26, 0, 15, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Outback Lager','Pavlova, Ltd.', 'Beverages', '24 - 355 ml bottles', 
    15, 15, 10, 30, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Flotemysost', 'Norske Meierier', 'Dairy Products', '10 - 500 g pkgs.', 
    21.5, 26, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Mozzarella di Giovanni','Formaggi Fortini s.r.l.', 'Dairy Products', '24 - 200 g pkgs.', 
    34.8, 15, 0, 0, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Rod Kaviar', 'Svensk Sjofoda AB', 'Seafood', '24 - 150 g jars', 
    15, 101, 0, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Longlife Tofu', 'Tokyo Traders','Produce', '5 kg pkg.', 
    10, 4, 20, 5, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Rhonbrau Klosterbier', 'Plutzer Lebensmittelgrossmarkte AG', 'Beverages', '24 - 0.5 l bottles', 
    7.75, 125, 0, 25, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Lakkalikoori', 'Karkki Oy', 'Beverages', '500 ml', 
    18, 57, 0, 20, 'N');
INSERT INTO PRODUCT
   (PRODUCT_NAME, SUPPLIER_NAME, CATEGORY_NAME, QUANTITY_PER_UNIT, UNIT_PRICE, UNITS_IN_STOCK, UNITS_ON_ORDER, REORDER_LEVEL, DISCONTINUED)
 VALUES
   ('Original Frankfurter grune Sosse', 'Plutzer Lebensmittelgrossmarkte AG', 'Condiments', '12 boxes', 
    13, 32, 0, 15, 'N');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (248,'SAVEA', 4, TO_DATE('02/10/1997', 'MM/DD/YYYY'), TO_DATE('03/10/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/28/1997', 'MM/DD/YYYY'), 'United Package', 86.53, 'Old World Delicatessen', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (249,'OLDWO', 3, TO_DATE('02/10/1997', 'MM/DD/YYYY'), TO_DATE('03/24/1997', 'MM/DD/YYYY'), 
    TO_DATE('03/14/1997', 'MM/DD/YYYY'), 'United Package', 73.02, 'Old World Delicatessen', '2743 Bering St.', 
    'Anchorage', 'AK', '99508', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (250,  'ERNSH', 3, TO_DATE('02/11/1997', 'MM/DD/YYYY'), TO_DATE('03/11/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/18/1997', 'MM/DD/YYYY'), 'United Package', 47.94, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (251, 'REGGC', 8, TO_DATE('02/12/1997', 'MM/DD/YYYY'), TO_DATE('03/12/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/14/1997', 'MM/DD/YYYY'), 'Speedy Express', 13.95, 'Reggiani Caseifici', 'Strada Provinciale 124', 
    'Reggio Emilia', '42100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (252, 'BERGS', 3, TO_DATE('02/12/1997', 'MM/DD/YYYY'), TO_DATE('03/12/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/21/1997', 'MM/DD/YYYY'),'Federal Shipping', 3.5, 'Berglunds snabbköp', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (253, 'BERGS', 3, TO_DATE('02/13/1997', 'MM/DD/YYYY'), TO_DATE('03/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/20/1997', 'MM/DD/YYYY'), 'Speedy Express', 9.3, 'Berglunds snabbköp', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (254,  'TOMSP', 6, TO_DATE('02/14/1997', 'MM/DD/YYYY'), TO_DATE('03/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/19/1997', 'MM/DD/YYYY'), 'Speedy Express', 14.68, 'Toms Spezialitäten', 'Luisenstr. 48', 
    'Münster', '44087', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (255, 'RICAR', 4, TO_DATE('02/14/1997', 'MM/DD/YYYY'), TO_DATE('03/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('03/07/1997', 'MM/DD/YYYY'), 'United Package', 68.66, 'Ricardo Adocicados', 'Av. Copacabana, 267', 
    'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (256,  'RANCH', 4, TO_DATE('02/17/1997', 'MM/DD/YYYY'), TO_DATE('03/17/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/24/1997', 'MM/DD/YYYY'), 'United Package', 38.82, 'Rancho grande', 'Av. del Libertador 900', 
    'Buenos Aires', '1010', 'Argentina');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (257,'SAVEA', 8, TO_DATE('02/20/1997', 'MM/DD/YYYY'), TO_DATE('03/20/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/26/1997', 'MM/DD/YYYY'), 'Speedy Express', 140.26, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (258, 'RICAR', 8, TO_DATE('03/20/1997', 'MM/DD/YYYY'), TO_DATE('04/17/1997', 'MM/DD/YYYY'), 
    TO_DATE('03/25/1997', 'MM/DD/YYYY'), 'United Package', 64.33, 'Ricardo Adocicados', 'Av. Copacabana, 267', 
    'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (384,'SAVEA', 6, TO_DATE('04/18/1997', 'MM/DD/YYYY'), TO_DATE('05/16/1997', 'MM/DD/YYYY'), 
    TO_DATE('04/28/1997', 'MM/DD/YYYY'),'Federal Shipping', 367.63, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (385,  'ERNSH', 3, TO_DATE('04/22/1997', 'MM/DD/YYYY'), TO_DATE('05/20/1997', 'MM/DD/YYYY'), 
    TO_DATE('05/16/1997', 'MM/DD/YYYY'), 'United Package', 789.95, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (259, 'BERGS', 1, TO_DATE('05/01/1997', 'MM/DD/YYYY'), TO_DATE('05/29/1997', 'MM/DD/YYYY'), 
    TO_DATE('05/07/1997', 'MM/DD/YYYY'), 'United Package', 244.79, 'Berglunds snabbköp', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (260,  'TOMSP', 3, TO_DATE('05/26/1997', 'MM/DD/YYYY'), TO_DATE('06/23/1997', 'MM/DD/YYYY'), 
    TO_DATE('06/02/1997', 'MM/DD/YYYY'), 'United Package', 1.43, 'Toms Spezialitäten', 'Luisenstr. 48', 
    'Münster', '44087', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (261,'SAVEA', 6, TO_DATE('06/02/1997', 'MM/DD/YYYY'), TO_DATE('06/30/1997', 'MM/DD/YYYY'), 
    TO_DATE('06/04/1997', 'MM/DD/YYYY'),'Federal Shipping', 252.49, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (262,  'TOMSP', 6, TO_DATE('07/05/1996', 'MM/DD/YYYY'), TO_DATE('08/16/1996', 'MM/DD/YYYY'), 
    TO_DATE('07/10/1996', 'MM/DD/YYYY'), 'Speedy Express', 11.61, 'Toms Spezialitäten', 'Luisenstr. 48', 
    'Münster', '44087', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (263,  'ERNSH', 1, TO_DATE('07/17/1996', 'MM/DD/YYYY'), TO_DATE('08/14/1996', 'MM/DD/YYYY'), 
    TO_DATE('07/23/1996', 'MM/DD/YYYY'), 'Speedy Express', 140.51, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (264,  'ERNSH', 9, TO_DATE('07/23/1996', 'MM/DD/YYYY'), TO_DATE('08/20/1996', 'MM/DD/YYYY'), 
    TO_DATE('07/31/1996', 'MM/DD/YYYY'),'Federal Shipping', 146.06, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (265, 'FOLKO', 6, TO_DATE('07/24/1996', 'MM/DD/YYYY'), TO_DATE('08/21/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/23/1996', 'MM/DD/YYYY'),'Federal Shipping', 3.67, 'Folk och fä HB', 'Åkergatan 24', 
    'Bräcke', 'S-844 67', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (266, 'BLONP', 2, TO_DATE('07/25/1996', 'MM/DD/YYYY'), TO_DATE('08/22/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/12/1996', 'MM/DD/YYYY'), 'Speedy Express', 55.28, 'Blondel père et fils', '24, place Kléber', 
    'Strasbourg', '67000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (267, 'FRANK', 4, TO_DATE('07/29/1996', 'MM/DD/YYYY'), TO_DATE('08/26/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/06/1996', 'MM/DD/YYYY'), 'Speedy Express', 208.58, 'Frankenversand', 'Berliner Platz 43', 
    'München', '80805', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (268, 'GROSR', 8, TO_DATE('07/30/1996', 'MM/DD/YYYY'), TO_DATE('08/27/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/02/1996', 'MM/DD/YYYY'),'Federal Shipping', 66.29, 'GROSELLA-Restaurante', '5ª Ave. Los Palos Grandes', 
    'Caracas', 'DF', '1081', 'Venezuela');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (269, 'WHITC', 5, TO_DATE('07/31/1996', 'MM/DD/YYYY'), TO_DATE('08/14/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/09/1996', 'MM/DD/YYYY'), 'Speedy Express', 4.56, 'White Clover Markets', '1029 - 12th Ave. S.', 
    'Seattle', 'WA', '98124', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (270, 'WARTH', 1, TO_DATE('08/01/1996', 'MM/DD/YYYY'), TO_DATE('08/29/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/02/1996', 'MM/DD/YYYY'), 'Speedy Express', 136.54, 'Wartian Herkku', 'Torikatu 38', 
    'Oulu', '90110', 'Finland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (271, 'SPLIR', 6, TO_DATE('08/01/1996', 'MM/DD/YYYY'), TO_DATE('08/29/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/30/1996', 'MM/DD/YYYY'), 'United Package', 4.54, 'Split Rail Beer And Ale', 'P.O. Box 555', 
    'Lander', 'WY', '82520', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (272, 'QUICK', 6, TO_DATE('08/02/1996', 'MM/DD/YYYY'), TO_DATE('08/30/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/06/1996', 'MM/DD/YYYY'), 'United Package', 98.03, 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 
    'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (273, 'RATTC', 3, TO_DATE('08/05/1996', 'MM/DD/YYYY'), TO_DATE('09/02/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/12/1996', 'MM/DD/YYYY'),'Federal Shipping', 76.07, 'QUICK-Stop', 'Taucherstraße 10', 
    'Cunewalde', '01307', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (274, 'VINET', 6, TO_DATE('08/06/1996', 'MM/DD/YYYY'), TO_DATE('09/03/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/16/1996', 'MM/DD/YYYY'), 'Speedy Express', 6.01, 'Vins et alcools Chevalier', '59 rue de l''Abbaye', 
    'Reims', '51100', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (275, 'MAGAA', 1, TO_DATE('08/07/1996', 'MM/DD/YYYY'), TO_DATE('09/04/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/09/1996', 'MM/DD/YYYY'), 'Speedy Express', 26.93, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 
    'Bergamo', '24100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (276, 'TORTU', 8, TO_DATE('08/08/1996', 'MM/DD/YYYY'), TO_DATE('08/22/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/14/1996', 'MM/DD/YYYY'),'Federal Shipping', 13.84, 'Tortuga Restaurante', 'Avda. Azteca 123', 
    'México D.F.', '05033', 'Mexico');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (277, 'TRADH', 2, TO_DATE('08/09/1996', 'MM/DD/YYYY'), TO_DATE('09/06/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/13/1996', 'MM/DD/YYYY'),'Federal Shipping', 125.77, 'Morgenstern Gesundkost', 'Heerstr. 22', 
    'Leipzig', '04179', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (278, 'BERGS', 8, TO_DATE('08/12/1996', 'MM/DD/YYYY'), TO_DATE('09/09/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/16/1996', 'MM/DD/YYYY'), 'United Package', 92.69, 'Berglunds snabbkop', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (279, 'LEHMS', 8, TO_DATE('08/13/1996', 'MM/DD/YYYY'), TO_DATE('09/10/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/16/1996', 'MM/DD/YYYY'), 'United Package', 25.83, 'Lehmanns Marktstand', 'Magazinweg 7', 
    'Frankfurt a.M. ', '60528', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (280, 'BERGS', 2, TO_DATE('08/14/1996', 'MM/DD/YYYY'), TO_DATE('09/11/1996', 'MM/DD/YYYY'), 
    TO_DATE('09/12/1996', 'MM/DD/YYYY'), 'Speedy Express', 8.98, 'Berglunds snakop', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (281, 'BERGS', 2, TO_DATE('08/14/1996', 'MM/DD/YYYY'), TO_DATE('09/11/1996', 'MM/DD/YYYY'), 
    TO_DATE('09/12/1996', 'MM/DD/YYYY'), 'Speedy Express', 8.98, 'Berglunds snabbkop', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');    
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (287, 'RICAR', 8, TO_DATE('08/22/1996', 'MM/DD/YYYY'), TO_DATE('09/19/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/28/1996', 'MM/DD/YYYY'),'Federal Shipping', 12.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 
    'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (288, 'REGGC', 4, TO_DATE('08/23/1996', 'MM/DD/YYYY'), TO_DATE('09/20/1996', 'MM/DD/YYYY'), 
    TO_DATE('09/03/1996', 'MM/DD/YYYY'), 'Speedy Express', 7.45, 'Reggiani Caseifici', 'Strada Provinciale 124', 
    'Reggio Emilia', '42100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (289, 'BONAP', 7, TO_DATE('08/26/1996', 'MM/DD/YYYY'), TO_DATE('09/23/1996', 'MM/DD/YYYY'), 
    TO_DATE('08/28/1996', 'MM/DD/YYYY'),'Federal Shipping', 22.77, 'B''s Beverages', 'Fauntleroy Circus', 
    'London', 'EC2 5NT', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (290, 'RICAR', 4, TO_DATE('09/06/1996', 'MM/DD/YYYY'), TO_DATE('10/04/1996', 'MM/DD/YYYY'), 
    TO_DATE('09/13/1996', 'MM/DD/YYYY'), 'United Package', 29.76, 'Ricardo Adocicados', 'Av. Copacabana, 267', 
    'Rio de Janeiro', 'RJ', '02389-890', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (291,'OLDWO', 8, TO_DATE('09/13/1996', 'MM/DD/YYYY'), TO_DATE('10/11/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/09/1996', 'MM/DD/YYYY'),'Federal Shipping', 257.62, 'Old World Delicatessen', '2743 Bering St.', 
    'Anchorage', 'AK', '99508', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (292,  'ERNSH', 4, TO_DATE('10/09/1997', 'MM/DD/YYYY'), TO_DATE('11/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('10/17/1997', 'MM/DD/YYYY'), 'Speedy Express', 272.47, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (293,'SAVEA', 9, TO_DATE('10/08/1996', 'MM/DD/YYYY'), TO_DATE('11/05/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/10/1996', 'MM/DD/YYYY'), 'Speedy Express', 214.27, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (294, 'KOENE', 1, TO_DATE('10/09/1996', 'MM/DD/YYYY'), TO_DATE('10/23/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/14/1996', 'MM/DD/YYYY'),'Federal Shipping', 64.86, 'Königlich Essen', 'Maubelstr. 90', 
    'Brandenburg', '14776', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (295, 'BOLID', 4, TO_DATE('10/10/1996', 'MM/DD/YYYY'), TO_DATE('11/07/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/14/1996', 'MM/DD/YYYY'), 'United Package', 77.92, 'Bólido Comidas preparadas', 'C/ Araquil, 67', 
    'Madrid', '28023', 'Spain');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (296, 'FOLKO', 2, TO_DATE('10/11/1996', 'MM/DD/YYYY'), TO_DATE('11/08/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/14/1996', 'MM/DD/YYYY'), 'Speedy Express', 63.36, 'Folk och fä HB', 'Åkergatan 24', 
    'Bräcke', 'S-844 67', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (297, 'FURIB', 4, TO_DATE('10/14/1996', 'MM/DD/YYYY'), TO_DATE('11/11/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/17/1996', 'MM/DD/YYYY'),'Federal Shipping', 87.03, 'Furia Bacalhau e Frutos do Mar', 'Jardim das rosas n. 32', 
    'Lisboa', '1675', 'Portugal');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (298, 'SPLIR', 4, TO_DATE('10/15/1996', 'MM/DD/YYYY'), TO_DATE('11/26/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/23/1996', 'MM/DD/YYYY'), 'United Package', 191.67, 'Split Rail Beer And Ale', 'P.O. Box 555', 
    'Lander', 'WY', '82520', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (299, 'LILAS', 3, TO_DATE('10/16/1996', 'MM/DD/YYYY'), TO_DATE('11/13/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/28/1996', 'MM/DD/YYYY'), 'Speedy Express', 12.75, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 
    'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (300, 'BONAP', 9, TO_DATE('10/16/1996', 'MM/DD/YYYY'), TO_DATE('11/27/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/21/1996', 'MM/DD/YYYY'), 'Speedy Express', 10.19, 'Bon app''', '12, rue des Bouchers', 
    'Marseille', '13008', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (301, 'MEREP', 3, TO_DATE('10/17/1996', 'MM/DD/YYYY'), TO_DATE('11/28/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/21/1996', 'MM/DD/YYYY'), 'United Package', 52.84, 'Mère Paillarde', '43 rue St. Laurent', 
    'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (302, 'WARTH', 5, TO_DATE('10/18/1996', 'MM/DD/YYYY'), TO_DATE('11/15/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/25/1996', 'MM/DD/YYYY'),'Federal Shipping', 0.59, 'Wartian Herkku', 'Torikatu 38', 
    'Oulu', '90110', 'Finland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (303, 'VICTE', 8, TO_DATE('10/21/1996', 'MM/DD/YYYY'), TO_DATE('11/18/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/28/1996', 'MM/DD/YYYY'), 'United Package', 8.56, 'Victuailles en stock', '2, rue du Commerce', 
    'Lyon', '69004', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_COUNTRY)
 VALUES
   (304, 'HUNGO', 7, TO_DATE('10/22/1996', 'MM/DD/YYYY'), TO_DATE('11/19/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/24/1996', 'MM/DD/YYYY'), 'United Package', 42.11, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 
    'Cork', 'Co. Cork', 'Ireland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (305,'OLDWO', 4, TO_DATE('10/25/1996', 'MM/DD/YYYY'), TO_DATE('11/22/1996', 'MM/DD/YYYY'), 
    TO_DATE('10/29/1996', 'MM/DD/YYYY'),'Federal Shipping', 84.21, 'Old World Delicatessen', '2743 Bering St.', 
    'Anchorage', 'AK', '99508', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (306,  'ERNSH', 1, TO_DATE('11/11/1996', 'MM/DD/YYYY'), TO_DATE('12/09/1996', 'MM/DD/YYYY'), 
    TO_DATE('11/20/1996', 'MM/DD/YYYY'), 'Speedy Express', 162.33, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (307,  'ERNSH', 2, TO_DATE('11/29/1996', 'MM/DD/YYYY'), TO_DATE('12/27/1996', 'MM/DD/YYYY'), 
    TO_DATE('12/02/1996', 'MM/DD/YYYY'), 'United Package', 101.95, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (308, 'SPLIR', 8, TO_DATE('12/02/1996', 'MM/DD/YYYY'), TO_DATE('12/30/1996', 'MM/DD/YYYY'), 
    TO_DATE('12/09/1996', 'MM/DD/YYYY'), 'United Package', 195.68, 'Split Rail Beer And Ale', 'P.O. Box 555', 
    'Lander', 'WY', '82520', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (309, 'CHOPS', 6, TO_DATE('12/03/1996', 'MM/DD/YYYY'), TO_DATE('12/31/1996', 'MM/DD/YYYY'), 
    TO_DATE('12/27/1996', 'MM/DD/YYYY'), 'United Package', 1.17, 'Chop-suey Chinese', 'Hauptstr. 31', 
    'Bern', '3012', 'Switzerland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (310, 'LAMAI', 1, TO_DATE('12/03/1996', 'MM/DD/YYYY'), TO_DATE('12/31/1996', 'MM/DD/YYYY'), 
    TO_DATE('12/24/1996', 'MM/DD/YYYY'), 'Speedy Express', 0.45, 'La maison d''Asie', '1 rue Alsace-Lorraine', 
    'Toulouse', '31000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (311, 'QUEEN', 5, TO_DATE('12/04/1996', 'MM/DD/YYYY'), TO_DATE('01/01/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/09/1996', 'MM/DD/YYYY'), 'United Package', 890.78, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 
    'São Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (312, 'MAGAA', 2, TO_DATE('03/10/1998', 'MM/DD/YYYY'), TO_DATE('04/07/1998', 'MM/DD/YYYY'), 
    TO_DATE('03/13/1998', 'MM/DD/YYYY'), 'United Package', 76.33, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 
    'Bergamo', '24100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (313, 'BONAP', 8, TO_DATE('03/11/1998', 'MM/DD/YYYY'), TO_DATE('04/08/1998', 'MM/DD/YYYY'), 
    TO_DATE('03/23/1998', 'MM/DD/YYYY'),'Federal Shipping', 19.77, 'Bon app''', '12, rue des Bouchers', 
    'Marseille', '13008', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (314,'SAVEA', 7, TO_DATE('03/11/1998', 'MM/DD/YYYY'), TO_DATE('04/08/1998', 'MM/DD/YYYY'), 
    TO_DATE('03/20/1998', 'MM/DD/YYYY'), 'United Package', 400.81, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_COUNTRY)
 VALUES
   (315,  'HUNGO', 4, TO_DATE('12/05/1996', 'MM/DD/YYYY'), TO_DATE('01/02/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/11/1996', 'MM/DD/YYYY'),'Federal Shipping', 124.12, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 
    'Cork', 'Co. Cork', 'Ireland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (316, 'WOLZA', 1, TO_DATE('12/05/1996', 'MM/DD/YYYY'), TO_DATE('01/02/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/09/1996', 'MM/DD/YYYY'),'Federal Shipping', 3.94, 'Wolski Zajazd', 'ul. Filtrowa 68', 
    'Warszawa', '01-012', 'Poland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (317, 'HUNGC', 3, TO_DATE('12/06/1996', 'MM/DD/YYYY'), TO_DATE('01/03/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/09/1996', 'MM/DD/YYYY'), 'United Package', 20.12, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 
    'Elgin', 'OR', '97827', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (318, 'MEREP', 1, TO_DATE('12/09/1996', 'MM/DD/YYYY'), TO_DATE('01/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/13/1996', 'MM/DD/YYYY'), 'United Package', 20.39, 'Mère Paillarde', '43 rue St. Laurent', 
    'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (319, 'SEVES', 1, TO_DATE('12/09/1996', 'MM/DD/YYYY'), TO_DATE('01/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/13/1996', 'MM/DD/YYYY'),'Federal Shipping', 22.21, 'Seven Seas Imports', '90 Wadhurst Rd.', 
    'London', 'OX15 4NB', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (320, 'FOLKO', 5, TO_DATE('12/10/1996', 'MM/DD/YYYY'), TO_DATE('01/07/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/19/1996', 'MM/DD/YYYY'),'Federal Shipping', 5.44, 'Folk och fä HB', 'Åkergatan 24', 
    'Bräcke', 'S-844 67', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (321, 'QUEDE', 2, TO_DATE('12/11/1996', 'MM/DD/YYYY'), TO_DATE('01/08/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/13/1996', 'MM/DD/YYYY'), 'Speedy Express', 45.03, 'Que Delícia', 'Rua da Panificadora, 12', 
    'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_COUNTRY)
 VALUES
   (322,  'HUNGO', 8, TO_DATE('12/12/1996', 'MM/DD/YYYY'), TO_DATE('01/09/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/16/1997', 'MM/DD/YYYY'),'Federal Shipping', 35.03, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 
    'Cork', 'Co. Cork', 'Ireland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (323, 'LILAS', 3, TO_DATE('12/12/1996', 'MM/DD/YYYY'), TO_DATE('01/09/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/13/1996', 'MM/DD/YYYY'),'Federal Shipping', 7.99, 'LILA-Supermercado', 'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', 
    'Barquisimeto', 'Lara', '3508', 'Venezuela');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (324,  'ERNSH', 4, TO_DATE('12/13/1996', 'MM/DD/YYYY'), TO_DATE('01/10/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/16/1996', 'MM/DD/YYYY'), 'Speedy Express', 94.77, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (325, 'AROUT', 8, TO_DATE('12/16/1996', 'MM/DD/YYYY'), TO_DATE('01/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/18/1996', 'MM/DD/YYYY'),'Federal Shipping', 34.24, 'Around the Horn', 'Brook Farm Stratford St. Mary', 
    'Colchester', 'Essex', 'CO7 6JX', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (326, 'BERGS', 3, TO_DATE('12/16/1996', 'MM/DD/YYYY'), TO_DATE('01/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/20/1996', 'MM/DD/YYYY'),'Federal Shipping', 168.64, 'Berglunds snabbköp', 'Berguvsvägen  8', 
    'Luleå', 'S-958 22', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (327, 'SUPRD',1, TO_DATE('12/17/1996', 'MM/DD/YYYY'), TO_DATE('01/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/23/1996', 'MM/DD/YYYY'), 'United Package', 30.96, 'Split Rail Beer And Ale', 'P.O. Box 555', 
    'Lander', 'WY', '82520', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (328, 'FAMIA', 9, TO_DATE('12/18/1996', 'MM/DD/YYYY'), TO_DATE('01/01/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/25/1996', 'MM/DD/YYYY'),'Federal Shipping', 13.99, 'Familia Arquibaldo', 'Rua Orós, 92', 
    'São Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (329, 'SANTG', 1, TO_DATE('12/18/1996', 'MM/DD/YYYY'), TO_DATE('01/15/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/20/1996', 'MM/DD/YYYY'), 'United Package', 93.63, 'Santé Gourmet', 'Erling Skakkes gate 78', 
    'Stavern', '4110', 'Norway');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (330, 'SEVES', 2, TO_DATE('12/19/1996', 'MM/DD/YYYY'), TO_DATE('01/16/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/20/1996', 'MM/DD/YYYY'), 'Speedy Express', 34.86, 'Seven Seas Imports', '90 Wadhurst Rd.', 
    'London', 'OX15 4NB', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (331, 'BOTTM', 4, TO_DATE('12/20/1996', 'MM/DD/YYYY'), TO_DATE('01/17/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/24/1996', 'MM/DD/YYYY'), 'United Package', 47.42, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 
    'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (332,  'ERNSH', 6, TO_DATE('12/23/1996', 'MM/DD/YYYY'), TO_DATE('01/20/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/26/1996', 'MM/DD/YYYY'), 'Speedy Express', 126.38, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (333, 'DRACD', 3, TO_DATE('12/23/1996', 'MM/DD/YYYY'), TO_DATE('01/20/1997', 'MM/DD/YYYY'), 
    TO_DATE('12/31/1996', 'MM/DD/YYYY'),'Federal Shipping', 5.45, 'Drachenblut Delikatessen', 'Walserweg 21', 
    'Aachen', '52066', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (334, 'PICCO', 2, TO_DATE('12/24/1996', 'MM/DD/YYYY'), TO_DATE('01/21/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/01/1997', 'MM/DD/YYYY'),'Federal Shipping', 122.46, 'Piccolo und mehr', 'Geislweg 14', 
    'Salzburg', '5020', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (335,'SAVEA', 1, TO_DATE('12/25/1996', 'MM/DD/YYYY'), TO_DATE('01/22/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/03/1997', 'MM/DD/YYYY'),'Federal Shipping', 126.56, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (336, 'HUNGC', 1, TO_DATE('12/25/1996', 'MM/DD/YYYY'), TO_DATE('01/22/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/03/1997', 'MM/DD/YYYY'),'Federal Shipping', 30.34, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 
    'Elgin', 'OR', '97827', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (337, 'HILAA', 6, TO_DATE('12/26/1996', 'MM/DD/YYYY'), TO_DATE('01/23/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/03/1997', 'MM/DD/YYYY'), 'Speedy Express', 184.41, 'HILARIÓN-Abastos', 'Carrera 22 con Ave. Carlos Soublette #8-35', 
    'San Cristóbal', 'Táchira', '5022', 'Venezuela');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (338, 'FRANK', 1, TO_DATE('12/27/1996', 'MM/DD/YYYY'), TO_DATE('01/10/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/06/1997', 'MM/DD/YYYY'),'Federal Shipping', 135.35, 'Frankenversand', 'Berliner Platz 43', 
    'München', '80805', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (339, 'PRINI', 5, TO_DATE('12/27/1996', 'MM/DD/YYYY'), TO_DATE('01/24/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/02/1997', 'MM/DD/YYYY'), 'Speedy Express', 60.26, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 
    'Lisboa', '1756', 'Portugal');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (340,'SAVEA', 2, TO_DATE('12/30/1996', 'MM/DD/YYYY'), TO_DATE('01/27/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/09/1997', 'MM/DD/YYYY'),'Federal Shipping', 89.16, 'Save-a-lot Markets', '187 Suffolk Ln.', 
    'Boise', 'ID', '83720', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (341, 'VAFFE', 8, TO_DATE('12/31/1996', 'MM/DD/YYYY'), TO_DATE('01/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/08/1997', 'MM/DD/YYYY'),'Federal Shipping', 27.36, 'Vaffeljernet', 'Smagsløget 45', 
    'Århus', '8200', 'Denmark');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (342, 'EASTC', 1, TO_DATE('01/01/1997', 'MM/DD/YYYY'), TO_DATE('01/29/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/16/1997', 'MM/DD/YYYY'),'Federal Shipping', 83.93, 'Eastern Connection', '35 King George', 
    'London', 'WX3 6FW', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (343, 'RATTC', 1, TO_DATE('01/01/1997', 'MM/DD/YYYY'), TO_DATE('01/29/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/10/1997', 'MM/DD/YYYY'),  'Federal Shipping', 12.51,  'Eastern Connection', '2817 Milton Dr.', 
    'Albuquerque', 'NM', '87110', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (344,  'ERNSH', 8, TO_DATE('01/02/1997', 'MM/DD/YYYY'), TO_DATE('02/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/10/1997', 'MM/DD/YYYY'), 'United Package', 67.88, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (345,  'ERNSH', 4, TO_DATE('01/03/1997', 'MM/DD/YYYY'), TO_DATE('01/31/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/09/1997', 'MM/DD/YYYY'),'Federal Shipping', 73.79, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (346,  'MAGAA', 2, TO_DATE('01/03/1997', 'MM/DD/YYYY'), TO_DATE('01/31/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/08/1997', 'MM/DD/YYYY'), 'Speedy Express', 155.97, 'Magazzini Alimentari Riuniti', 'Via Ludovico il Moro 22', 
    'Bergamo', '24100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (347, 'LINOD', 1, TO_DATE('01/06/1997', 'MM/DD/YYYY'), TO_DATE('02/03/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/22/1997', 'MM/DD/YYYY'), 'Speedy Express', 34.82, 'LINO-Delicateses', 'Ave. 5 de Mayo Porlamar', 
    'I. de Margarita', 'Nueva Esparta', '4980', 'Venezuela');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (348, 'QUEEN', 7, TO_DATE('01/07/1997', 'MM/DD/YYYY'), TO_DATE('02/18/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/13/1997', 'MM/DD/YYYY'), 'Speedy Express', 108.04, 'Queen Cozinha', 'Alameda dos Canàrios, 891', 
    'São Paulo', 'SP', '05487-020', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (349, 'OTTIK', 2, TO_DATE('01/07/1997', 'MM/DD/YYYY'), TO_DATE('02/04/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/30/1997', 'MM/DD/YYYY'), 'United Package', 91.48, 'Ottilies Käseladen', 'Mehrheimerstr. 369', 
    'Köln', '50739', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (350, 'FOLIG', 8, TO_DATE('01/08/1997', 'MM/DD/YYYY'), TO_DATE('02/05/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/14/1997', 'MM/DD/YYYY'), 'Speedy Express', 11.26, 'Folies gourmandes', '184, chaussée de Tournai', 
    'Lille', '59000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (351, 'OCEAN', 3, TO_DATE('01/09/1997', 'MM/DD/YYYY'), TO_DATE('02/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/14/1997', 'MM/DD/YYYY'), 'Speedy Express', 29.83, 'Océano Atlántico Ltda.', 'Ing. Gustavo Moncada 8585 Piso 20-A', 'Buenos Aires', '1010', 'Argentina');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (352, 'BOTTM', 3, TO_DATE('01/10/1997', 'MM/DD/YYYY'), TO_DATE('02/07/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/15/1997', 'MM/DD/YYYY'),'Federal Shipping', 2.4, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 
    'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (353, 'BOTTM', 9, TO_DATE('01/10/1997', 'MM/DD/YYYY'), TO_DATE('02/07/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/21/1997', 'MM/DD/YYYY'),'Federal Shipping', 23.65, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 
    'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (354, 'WARTH', 8, TO_DATE('01/13/1997', 'MM/DD/YYYY'), TO_DATE('02/10/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/15/1997', 'MM/DD/YYYY'), 'United Package', 3.77, 'Wartian Herkku', 'Torikatu 38', 
    'Oulu', '90110', 'Finland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (355, 'LAMAI', 3, TO_DATE('01/14/1997', 'MM/DD/YYYY'), TO_DATE('02/11/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/16/1997', 'MM/DD/YYYY'), 'United Package', 95.66, 'La maison d''Asie', '1 rue Alsace-Lorraine', 
    'Toulouse', '31000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (356, 'FAMIA', 2, TO_DATE('01/14/1997', 'MM/DD/YYYY'), TO_DATE('02/11/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/17/1997', 'MM/DD/YYYY'),'Federal Shipping', 21.48, 'Familia Arquibaldo', 'Rua Orós, 92', 
    'São Paulo', 'SP', '05442-030', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (357, 'HUNGC', 3, TO_DATE('01/15/1997', 'MM/DD/YYYY'), TO_DATE('02/12/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/24/1997', 'MM/DD/YYYY'), 'Speedy Express', 0.2, 'Hungry Coyote Import Store', 'City Center Plaza 516 Main St.', 
    'Elgin', 'OR', '97827', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (358, 'WARTH', 8, TO_DATE('01/16/1997', 'MM/DD/YYYY'), TO_DATE('02/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/27/1997', 'MM/DD/YYYY'),'Federal Shipping', 22.72, 'Wartian Herkku', 'Torikatu 38', 
    'Oulu', '90110', 'Finland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (359, 'SIMOB', 4, TO_DATE('01/16/1997', 'MM/DD/YYYY'), TO_DATE('02/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/28/1997', 'MM/DD/YYYY'),'Federal Shipping', 70.29, 'Simons bistro', 'Vinbæltet 34', 
    'København', '1734', 'Denmark');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (360, 'QUICK', 4, TO_DATE('01/17/1997', 'MM/DD/YYYY'), TO_DATE('02/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/24/1997', 'MM/DD/YYYY'), 'Speedy Express', 17.55, 'QUICK-Stop', 'Taucherstraße 10', 
    'Cunewalde', '01307', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (361, 'RICSU', 4, TO_DATE('01/20/1997', 'MM/DD/YYYY'), TO_DATE('02/17/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/30/1997', 'MM/DD/YYYY'), 'United Package', 137.35, 'Richter Supermarkt', 'Starenweg 5', 
    'Genève', '1204', 'Switzerland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (362, 'WELLI', 3, TO_DATE('01/21/1997', 'MM/DD/YYYY'), TO_DATE('02/18/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/27/1997', 'MM/DD/YYYY'), 'Speedy Express', 44.12, 'Wellington Importadora', 'Rua do Mercado, 12', 
    'Resende', 'SP', '08737-363', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (363, 'QUEDE', 8, TO_DATE('01/21/1997', 'MM/DD/YYYY'), TO_DATE('03/04/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/27/1997', 'MM/DD/YYYY'), 'Speedy Express', 99.23, 'Que Delícia', 'Rua da Panificadora, 12', 
    'Rio de Janeiro', 'RJ', '02389-673', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (364, 'FRANS', 2, TO_DATE('01/22/1997', 'MM/DD/YYYY'), TO_DATE('02/19/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/31/1997', 'MM/DD/YYYY'), 'Speedy Express', 3.02, 'Franchi S.p.A.', 'Via Monte Bianco 34', 
    'Torino', '10100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (365, 'GOURL', 6, TO_DATE('01/23/1997', 'MM/DD/YYYY'), TO_DATE('02/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/24/1997', 'MM/DD/YYYY'),'Federal Shipping', 24.5, 'Gourmet Lanchonetes', 'Av. Brasil, 442', 
    'Campinas', 'SP', '04876-786', 'Brazil');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (366, 'MEREP', 7, TO_DATE('01/23/1997', 'MM/DD/YYYY'), TO_DATE('02/20/1997', 'MM/DD/YYYY'), 
    TO_DATE('01/27/1997', 'MM/DD/YYYY'), 'United Package', 370.61, 'Mère Paillarde', '43 rue St. Laurent', 
    'Montréal', 'Québec', 'H1J 1C3', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (367, 'LAMAI', 6, TO_DATE('01/24/1997', 'MM/DD/YYYY'), TO_DATE('02/21/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/14/1997', 'MM/DD/YYYY'), 'United Package', 7.93, 'La maison d''Asie', '1 rue Alsace-Lorraine', 
    'Toulouse', '31000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (368, 'GALED', 4, TO_DATE('01/27/1997', 'MM/DD/YYYY'), TO_DATE('02/24/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/06/1997', 'MM/DD/YYYY'), 'Speedy Express', 18.69, 'Galería del gastronómo', 'Rambla de Cataluña, 23', 
    'Barcelona', '8022', 'Spain');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (369, 'PICCO', 4, TO_DATE('01/27/1997', 'MM/DD/YYYY'), TO_DATE('02/24/1997', 'MM/DD/YYYY'), 
    TO_DATE('03/03/1997', 'MM/DD/YYYY'), 'United Package', 31.29, 'Piccolo und mehr', 'Geislweg 14', 
    'Salzburg', '5020', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (370, 'REGGC', 7, TO_DATE('01/28/1997', 'MM/DD/YYYY'), TO_DATE('02/25/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/04/1997', 'MM/DD/YYYY'), 'Speedy Express', 11.09, 'Reggiani Caseifici', 'Strada Provinciale 124', 
    'Reggio Emilia', '42100', 'Italy');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_COUNTRY)
 VALUES
   (371, 'HUNGO', 3, TO_DATE('01/29/1997', 'MM/DD/YYYY'), TO_DATE('03/12/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/07/1997', 'MM/DD/YYYY'), 'United Package', 56.63, 'Hungry Owl All-Night Grocers', '8 Johnstown Road', 
    'Cork', 'Co. Cork', 'Ireland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (372,  'ERNSH', 4, TO_DATE('01/30/1997', 'MM/DD/YYYY'), TO_DATE('02/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/03/1997', 'MM/DD/YYYY'), 'Speedy Express', 458.78, 'Ernst Handel', 'Kirchgasse 6', 
    'Graz', '8010', 'Austria');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (373, 'BOTTM', 4, TO_DATE('01/30/1997', 'MM/DD/YYYY'), TO_DATE('02/13/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/07/1997', 'MM/DD/YYYY'), 'United Package', 44.17, 'Bottom-Dollar Markets', '23 Tsawassen Blvd.', 
    'Tsawassen', 'BC', 'T2F 8M4', 'Canada');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (374, 'SUPRD',3, TO_DATE('01/31/1997', 'MM/DD/YYYY'), TO_DATE('02/14/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/07/1997', 'MM/DD/YYYY'), 'United Package', 4.34, 'Split Rail Beer And Ale', 'P.O. Box 555', 
    'Lander', 'WY', '82520', 'USA');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (375, 'PRINI', 3, TO_DATE('02/03/1997', 'MM/DD/YYYY'), TO_DATE('03/03/1997', 'MM/DD/YYYY'), 
    TO_DATE('03/04/1997', 'MM/DD/YYYY'),'Federal Shipping', 73.83, 'Princesa Isabel Vinhos', 'Estrada da saúde n. 58', 
    'Lisboa', '1756', 'Portugal');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (378, 'FOLKO', 3, TO_DATE('02/03/1997', 'MM/DD/YYYY'), TO_DATE('03/03/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/13/1997', 'MM/DD/YYYY'), 'United Package', 17.92, 'Folk och fä HB', 'Åkergatan 24', 
    'Bräcke', 'S-844 67', 'Sweden');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (379, 'CONSH', 8, TO_DATE('02/04/1997', 'MM/DD/YYYY'), TO_DATE('03/18/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/07/1997', 'MM/DD/YYYY'), 'United Package', 9.21, 'Consolidated Holdings', 'Berkeley Gardens 12  Brewery ', 'London', 'WX1 6LT', 'UK');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (380, 'BLONP', 3, TO_DATE('02/05/1997', 'MM/DD/YYYY'), TO_DATE('03/05/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/11/1997', 'MM/DD/YYYY'), 'United Package', 156.66, 'Blondel père et fils', '24, place Kléber', 
    'Strasbourg', '67000', 'France');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (381, 'WARTH', 8, TO_DATE('02/05/1997', 'MM/DD/YYYY'), TO_DATE('03/05/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/12/1997', 'MM/DD/YYYY'), 'Speedy Express', 19.97, 'Wartian Herkku', 'Torikatu 38', 
    'Oulu', '90110', 'Finland');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (382,  'TOMSP', 3, TO_DATE('02/06/1997', 'MM/DD/YYYY'), TO_DATE('03/06/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/14/1997', 'MM/DD/YYYY'), 'United Package', 8.24, 'Toms Spezialitäten', 'Luisenstr. 48', 
    'Münster', '44087', 'Germany');
INSERT INTO ORDERS
   (ORDER_ID, CUSTOMER_CODE, EMPLOYEE_ID, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, SHIP_VIA, FREIGHT, SHIP_NAME, SHIP_ADDRESS, SHIP_CITY, SHIP_REGION, SHIP_POSTAL_CODE, SHIP_COUNTRY)
 VALUES
   (383, 'MEREP', 6, TO_DATE('02/07/1997', 'MM/DD/YYYY'), TO_DATE('03/07/1997', 'MM/DD/YYYY'), 
    TO_DATE('02/10/1997', 'MM/DD/YYYY'),'Federal Shipping', 4.07, 'Mère Paillarde', '43 rue St. Laurent', 
    'Montréal', 'Québec', 'H1J 1C3', 'Canada');

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (248, 'Queso Cabrales', 14, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (248,'Singaporean Hokkien Fried Mee', 9.8, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (248, 'Mozzarella di Giovanni', 34.8, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (249, 'Tofu',18.6, 9, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (249, 'Manjimup Dried Apples', 42.4, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (250, 'Jack''s New England Clam Chowder', 7.7, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (250, 'Manjimup Dried Apples', 42.4, 35, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (250, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 15, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (251, 'Gustaf''s Knackebrod', 16.8, 6, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (251, 'Ravioli Angelo', 15.6, 15, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (251, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (252, 'Sir Rodney''s Marmalade', 64.8, 40, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (252, 'Geitost', 2, 25, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (252, 'Camembert Pierrot', 27.2, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (253, 'Gorgonzola Telino', 10, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (253, 'Inlagd Sill', 14.4, 42, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (253, 'Maxilaku', 16, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (254, 'Guarana Fantastica', 3.6, 15, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (254, 'Pate chinois', 19.2, 21, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (254, 'Longlife Tofu', 8, 21, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (255, 'Chang', 15.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (255, 'Pavlova', 13.9, 35, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (255, 'Inlagd Sill', 15.2, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (255, 'Raclette Courdavault', 44, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (256, 'Perth Pasties', 26.2, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (256, 'Original Frankfurter grune Sosse', 10.4, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (257, 'Schoggi Schokolade', 35.1, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (257, 'Inlagd Sill', 14.4, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (257, 'Original Frankfurter grune Sosse', 10.4, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (258, 'Chang', 15.2, 50, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (258, 'Chef Anton''s Gumbo Mix', 17, 65, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (258, 'Mascarpone Fabioli', 25.6, 6, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (259, 'Sir Rodney''s Scones', 8, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (259,'Gravad lax', 20.8, 1, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (260, 'Jack''s New England Clam Chowder', 7.7, 16, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (260, 'Ravioli Angelo', 15.6, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (260, 'Tarte au sucre', 39.4, 15, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (260, 'Outback Lager', 12, 21, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (261, 'Sir Rodney''s Scones', 8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (261, 'Steeleye Stout', 14.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (262, 'Chef Anton''s Gumbo Mix', 17, 12, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (262, 'Guarana Fantastica',17, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (262, 'Gnocchi di nonna Alice', 30.4, 2, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (263, 'Pavlova', 13.9, 60, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (263, 'Guarana Fantastica', 3.6, 28, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (263, 'Nord-Ost Matjeshering', 20.7, 60, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (263, 'Longlife Tofu', 8, 36, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (264, 'Chang', 15.2, 35, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (264, 'Jack''s New England Clam Chowder', 7.7, 25, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (265, 'Alice Mutton', 31.2, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (265, 'Outback Lager', 12, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (266, 'Queso Manchego La Pastora', 30.4, 12, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (267, 'Boston Crab Meat', 14.7, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (267, 'Raclette Courdavault', 44, 70, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (267, 'Lakkalikoori', 14.4, 15, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (268, 'Thuringer Rostbratwurst', 99, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (268, 'Mozzarella di Giovanni', 27.8, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (269, 'Geitost', 2, 60, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (269, 'Mozzarella di Giovanni', 27.8, 20, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (270, 'Inlagd Sill', 15.2, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (270, 'Ipoh Coffee', 36.8, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (271, 'Geitost', 2, 24, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (272, 'Sir Rodney''s Marmalade', 64.8, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (272, 'Gorgonzola Telino', 10, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (272, 'Mozzarella di Giovanni', 27.8, 24, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (273, 'Ikura', 24.8, 24, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (273, 'Gorgonzola Telino', 10, 15, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (273, 'Geitost', 2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (273, 'Boston Crab Meat', 14.7, 60, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (273, 'Lakkalikoori', 14.4, 33, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (274, 'Flotemysost', 17.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (274, 'Mozzarella di Giovanni', 27.8, 7, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (275, 'Guarana Fantastica', 3.6, 12, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (275, 'Raclette Courdavault', 44, 6, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (276, 'Ikura', 24.8, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (276, 'Konbu', 4.8, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (277, 'Rossle Sauerkraut', 36.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (277, 'Tarte au sucre', 39.4, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (278, 'Gula Malacca', 15.5, 16, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (278, 'Raclette Courdavault', 44, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (278, 'Vegie-spread', 35.1, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (278, 'Rod Kaviar', 12, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (279, 'Alice Mutton', 31.2, 15, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (280, 'Guarana Fantastica', 3.6, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (280, 'Pate chinois', 19.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (280, 'Rhonbrau Klosterbier', 6.2, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (281, 'Teatime Chocolate Biscuits', 7.3, 1, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (281, 'Guarana Fantastica', 3.6, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (281, 'Steeleye Stout', 14.4, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (288, 'Tourtiere', 5.9, 10, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (288, 'Scottish Longbreads', 10, 3, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (289, 'Aniseed Syrup', 8, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (289, 'Wimmers gute Semmelknodel', 26.6, 9, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (290, 'Chef Anton''s Gumbo Mix', 17, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (290, 'Thuringer Rostbratwurst', 99, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (290, 'Maxilaku', 16, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (290, 'Original Frankfurter grune Sosse', 10.4, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (291, 'Konbu', 4.8, 20, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (291, 'Gula Malacca', 15.5, 24, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (291, 'Manjimup Dried Apples', 42.4, 2, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (292, 'Sir Rodney''s Marmalade', 64.8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (293, 'Carnarvon Tigers', 50, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (293, 'Guarana Fantastica', 3.6, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (293, 'Vegie-spread', 35.1, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (293, 'Rhonbrau Klosterbier', 6.2, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (294,'Chai', 14.4, 18, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (294, 'Alice Mutton', 31.2, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (294, 'Ipoh Coffee', 36.8, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (294, 'Camembert Pierrot', 27.2, 21, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (294, 'Rhonbrau Klosterbier', 6.2, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (295, 'Gnocchi di nonna Alice', 30.4, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (296,'Queso Cabrales', 16.8, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (296, 'Pavlova', 13.9, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (296, 'Gudbrandsdalsost', 28.8, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (297, 'Inlagd Sill', 14.4, 60, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (297, 'Mozzarella di Giovanni', 27.8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (298, 'Chang', 15.2, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (298, 'Inlagd Sill', 15.2, 40, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (298, 'Raclette Courdavault', 44, 30, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (298, 'Tarte au sucre', 39.4, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (299, 'Teatime Chocolate Biscuits', 7.3, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (299, 'Outback Lager', 12, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (300, 'Louisiana Hot Spiced Okra', 13.6, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (300, 'Scottish Longbreads', 10, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (301, 'Boston Crab Meat', 14.7, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (301, 'Gnocchi di nonna Alice', 30.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (302, 'Alice Mutton', 31.2, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (302, 'Rossle Sauerkraut', 36.4, 28, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (302, 'Ipoh Coffee',36.8, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (303, 'Boston Crab Meat', 14.7, 40, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (303, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 30, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (303, 'Scottish Longbreads', 10, 15, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (304, 'Maxilaku', 16, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (304, 'Raclette Courdavault', 44, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (304, 'Flotemysost', 17.2, 2, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (305, 'Carnarvon Tigers', 50, 25, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (305, 'Thuringer Rostbratwurst', 99, 25, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (305, 'Inlagd Sill', 14.4, 30, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (306, 'Nord-Ost Matjeshering', 20.7, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (306, 'Perth Pasties', 26.2, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (306, 'Tourtiere', 5.9, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (307, 'Tarte au sucre', 39.4, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (307, 'Scottish Longbreads', 10, 3, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (308, 'Gudbrandsdalsost', 28.8, 1, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (308, 'Outback Lager', 12, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (309, 'Chef Anton''s Cajun Seasoning', 17.6, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (309, 'Grandma''s Boysenberry Spread', 20, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (309, 'Singaporean Hokkien Fried Mee', 11.2, 2, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (309, 'Ipoh Coffee',36.8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (309, 'Flotemysost', 17.2, 3, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (310, 'Pavlova', 13.9, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (310, 'Tarte au sucre', 39.4, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (311, 'Singaporean Hokkien Fried Mee', 11.2, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (311, 'Gudbrandsdalsost', 28.8, 7, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (312, 'Rossle Sauerkraut', 36.4, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (312, 'Ipoh Coffee',36.8, 24, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (312, 'Perth Pasties', 26.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (312, 'Rhonbrau Klosterbier', 6.2, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (313, 'Inlagd Sill', 15.2, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (314, 'Mascarpone Fabioli', 25.6, 40, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (314,  'Escargots de Bourgogne', 10.6, 30, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (314, 'Tarte au sucre', 39.4, 25, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (315, 'Sasquatch Ale', 11.2, 14, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (315, 'Outback Lager', 12, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (316, 'Jack''s New England Clam Chowder', 7.7, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (316, 'Tarte au sucre', 39.4, 70, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (317,'Chai', 14.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (318, 'Jack''s New England Clam Chowder', 7.7, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (318, 'Lakkalikoori', 14.4, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (319, 'Alice Mutton', 31.2, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (319, 'Rossle Sauerkraut', 36.4, 14, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (319, 'Lakkalikoori', 14.4, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (320, 'Flotemysost', 17.2, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (321, 'Steeleye Stout', 14.4, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (322, 'Filo Mix', 5.6, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (323, 'Genen Shouyu', 12.4, 5, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (323,'Grandma''s Boysenberry Spread', 11.2, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (323, 'Inlagd Sill', 14.4, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (324, 'Pavlova', 13.9, 21, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (324, 'Steeleye Stout', 14.4, 70, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (324, 'Spegesild', 9.6, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (324, 'Raclette Courdavault', 44, 40, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (324, 'Vegie-spread', 35.1, 80, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (325, 'Grandma''s Boysenberry Spread', 25.3, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (325, 'Konbu', 4.8, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (325, 'Tofu',18.6, 9, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (325, 'Gorgonzola Telino', 10, 4, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (325, 'Mozzarella di Giovanni', 27.8, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (326, 'Chef Anton''s Cajun Seasoning', 17.6, 24, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (326, 'Ravioli Angelo', 15.6, 16, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (326, 'Rhonbrau Klosterbier', 6.2, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (327, 'Chang', 15.2, 25, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (327,'Queso Cabrales', 16.8, 50, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (327, 'Nord-Ost Matjeshering', 20.7, 35, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (327,  'Escargots de Bourgogne', 10.6, 30, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (328, 'Raclette Courdavault', 44, 9, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (328, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (328, 'Scottish Longbreads', 10, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (329, 'Teatime Chocolate Biscuits', 7.3, 10, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (329, 'Nord-Ost Matjeshering', 20.7, 8, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (329, 'Côte de Blaye', 210.8, 20, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (329, 'Gnocchi di nonna Alice', 30.4, 12, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (330, 'Gumbar Gummibarchen', 24.9, 50, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (330, 'Mozzarella di Giovanni', 27.8, 25, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (331, 'Tourtiere', 5.9, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (332, 'Carnarvon Tigers', 50, 40, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (332, 'Singaporean Hokkien Fried Mee', 11.2, 10, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (332, 'Zaanse koeken', 7.6, 16, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (333, 'Tofu',18.6, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (333, 'Sir Rodney''s Scones', 8, 10, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (333, 'Flotemysost', 17.2, 40, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (334, 'Filo Mix', 5.6, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (334, 'Scottish Longbreads', 10, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (335, 'Chang', 15.2, 7, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (335, 'Gorgonzola Telino', 10, 25, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (335, 'Mascarpone Fabioli', 25.6, 6, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (335, 'Manjimup Dried Apples', 42.4, 48, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (336, 'Chef Anton''s Cajun Seasoning', 17.6, 18, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (337, 'Tunnbrod', 7.2, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (337, 'Gumbar Gummibarchen', 24.9, 24, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (337, 'Inlagd Sill', 15.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (337,'Gravad lax', 20.8, 28, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (337, 'Mozzarella di Giovanni', 27.8, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (338, 'Alice Mutton', 31.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (338, 'Uncle Bob''s Organic Dried Pears', 20.7, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (339, 'Chef Anton''s Cajun Seasoning', 17.6, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (339, 'Alice Mutton', 31.2, 70, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (339, 'Tarte au sucre', 39.4, 28, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (340, 'Carnarvon Tigers', 50, 20, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (340, 'Jack''s New England Clam Chowder', 7.7, 12, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (340, 'Ipoh Coffee',36.8, 40, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (341, 'Geitost', 2, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (341, 'Raclette Courdavault', 44, 9, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (342, 'Chang', 15.2, 24, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (342, 'Gorgonzola Telino', 10, 56, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (343, 'Queso Manchego La Pastora', 30.4, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (343, 'Pavlova', 13.9, 16, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (343, 'Wimmers gute Semmelknodel', 26.6, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (344, 'Longlife Tofu', 8, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (345, 'Chang', 15.2, 45, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (345, 'Pavlova', 13.9, 49, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (345, 'Thuringer Rostbratwurst', 99, 24, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (345, 'Sirop d''erable', 22.8, 90, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (346, 'Schoggi Schokolade', 35.1, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (346,'Queso Cabrales', 16.8, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (346, 'Tourtiere', 5.9, 80, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (346, 'Louisiana Hot Spiced Okra', 13.6, 60, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (347,'Queso Cabrales', 16.8, 6, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (348, 'Rossle Sauerkraut', 36.4, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (348, 'Alice Mutton', 31.2, 10, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (349, 'Gumbar Gummibarchen', 24.9, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (349, 'Steeleye Stout', 14.4, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (350, 'Jack''s New England Clam Chowder', 7.7, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (350, 'Inlagd Sill', 14.4, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (350, 'Tourtiere', 5.9, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (350, 'Teatime Chocolate Biscuits', 7.3, 12, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (350, 'Guarana Fantastica', 3.6, 20, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (351, 'Gorgonzola Telino', 10, 3, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (351, 'Filo Mix', 5.6, 15, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (352, 'Teatime Chocolate Biscuits', 7.3, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (352, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 35, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (352, 'Flotemysost', 17.2, 2, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (353, 'Gumbar Gummibarchen', 24.9, 6, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (354, 'Boston Crab Meat', 14.7, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (355, 'Gnocchi di nonna Alice', 24.8, 14, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (356, 'Filo Mix', 5.6, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (357, 'Tarte au sucre', 39.4, 35, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (357, 'Ikura', 24.8, 20, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (358, 'Tourtiere', 5.9, 6, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (358, 'Pate chinois', 19.2, 120, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (359, 'Wimmers gute Semmelknodel', 26.6, 35, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (360, 'Louisiana Fiery Hot Pepper Sauce', 16.8, 28, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (361, 'Original Frankfurter grune Sosse', 10.4, 55, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (362, 'Rossle Sauerkraut', 36.4, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (362, 'Gula Malacca', 15.5, 100, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (363, 'Chocolade', 10.2, 15, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (363, 'Outback Lager', 12, 25, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (364, 'Pavlova', 13.9, 20, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (364, 'Geitost', 2, 20, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (364, 'Spegesild', 9.6, 10, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (365, 'Inlagd Sill', 14.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (365, 'Perth Pasties', 26.2, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (365, 'Sirop d''erable', 22.8, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (365, 'Flotemysost', 17.2, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (366, 'Sir Rodney''s Scones', 8, 40, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (366, 'Maxilaku', 16, 21, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (367, 'Raclette Courdavault', 44, 36, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (368, 'Gumbar Gummibarchen', 24.9, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (368, 'Rossle Sauerkraut', 36.4, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (368, 'Ipoh Coffee',36.8, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (368, 'Gnocchi di nonna Alice', 30.4, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (368, 'Flotemysost', 17.2, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (369,'Uncle Bob''s Organic Dried Pears', 24, 16, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (369, 'Spegesild', 9.6, 20, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (369, 'Mozzarella di Giovanni', 27.8, 40, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (370, 'Scottish Longbreads', 10, 21, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (370, 'Rhonbrau Klosterbier', 6.2, 4, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (371, 'Sir Rodney''s Scones', 8, 40, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (371, 'Nord-Ost Matjeshering', 20.7, 28, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (371, 'Pate chinois', 19.2, 60, 0.25);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (372, 'Konbu', 4.8, 1, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (372, 'Tunnbrod', 7.2, 21, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (373, 'Teatime Chocolate Biscuits', 7.3, 21, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (373, 'Singaporean Hokkien Fried Mee', 11.2, 50, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (374, 'Chef Anton''s Cajun Seasoning', 17.6, 16, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (374, 'Ipoh Coffee',36.8, 3, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (374, 'Gnocchi di nonna Alice', 30.4, 30, 0.2);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (374, 'Camembert Pierrot', 27.2, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (375, 'Guarana Fantastica', 3.6, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (375, 'Thuringer Rostbratwurst', 99, 18, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (375, 'Boston Crab Meat', 14.7, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (375, 'Rogede sild', 7.6, 30, 0.1);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (375,'Valkoinen suklaa', 13, 25, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (378, 'Nord-Ost Matjeshering', 20.7, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (378, 'Ipoh Coffee', 36.8, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (379, 'Chang', 15.2, 40, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (379, 'Pavlova', 13.9, 35, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (379, 'Gula Malacca', 15.5, 2, 0.15);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (380, 'Carnarvon Tigers', 50, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (380, 'Tunnbrod', 7.2, 15, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (380, 'Wimmers gute Semmelknodel', 26.6, 8, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (381,'Uncle Bob''s Organic Dried Pears', 24, 30, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (381, 'Gnocchi di nonna Alice', 30.4, 20, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (382, 'Guarana Fantastica', 3.6, 80, 0.05);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (382, 'Manjimup Dried Apples', 42.4, 18, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (383, 'Geitost', 2, 12, 0);
INSERT INTO ORDER_DETAIL
   (ORDER_ID, PRODUCT_NAME, UNIT_PRICE, QUANTITY, DISCOUNT)
 VALUES
   (383, 'Flotemysost', 17.2, 12, 0);
   
COMMIT;


spool off
