#### Task 3

##### Customer Table

One customer can submit multiple orders, so there are multiple order-id assigned to one customer.

The **functional dependencies** are:

customer-code $\rightarrow$ name 

customer-code $\rightarrow$ address

order-id $\rightarrow$ order-id

customer-code $\rightarrow$ name, address

{customer-code, order-id} are the **minimal keys**

customer-code $\rightarrow$ name, address, 

so the table does not conform to 2NF, the highest normal valid for the schema is 1NF.

To **make the table in BCNF**, we should decompose the schema into:

(customer-code, name, address) with primary key customer-code

(customer-code, order-id) with prsolimary key order-id



##### Employee Table

One Employee can handle multiple orders, so there are multiple order-id assignmed to one employee.

The **functional dependencies** are:

employee-number $\rightarrow$ name, department-name

department-name $\rightarrow$ department-budget

{employee-number} is the **minimal key**.

all nonprime attribute name, department-name, department-budget are fully functionallly dependent on a primary key, the schema is in 2NF. But the department-budget is transitively dependent on a primary key employee-number, so the schema is not in 3NF, **the highest normal valid is 2NF**.

To **make the schema in BCNF**, decompose the schema into 2 schemas:

(employee-number, name, department-name) with primary key employee-number

(department-name, department-budget) with primary key department-name



##### Order Table

one order is assigned to one customer and one employee

**functional dependencies** are:

order-id $\rightarrow$ order-date, total-value, customer-code, employee-number, employee-name

employee-number $\rightarrow$ employee-name

so **the minimal key** is order-id

all nonprime attribute are fully functionallly dependent on a primary key, so the schema is in 2NF. While the employee-name is transitively dependent on a primary key, so **the highest normal valid is 2NF**.

To **transform the schema into BCNF**,  decompose the chema into 2 schemas:

(order-id, order-date, total-value, customer-code, employee-number) with primary key order-id

(employee-number, employee-name) with primary key employee-number



