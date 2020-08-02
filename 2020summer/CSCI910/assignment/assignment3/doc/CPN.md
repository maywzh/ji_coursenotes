# Colored Petri Net of Dinning67
### Group 
Wangzhihui Mei 6603385 2019124044
Muzhe Peng 6603646 2019124040
Yiwen Zhao 6603749 2019124038

### CPN Graph

![Dinning 67 Colored Petri Net](.\dinning67.png)







### Mathematic representation

$C=(P,T,I,O)$

$P=\{Arrived, Ordered, Cancelled, Preparing, Served, Modify\_Operation, Available\_items, Available\_restaurant\_employee\}$

$T=\{Place\_orders, Modify\_dishes, Prepare\_ordered\_dishes, Serve\_ordered\_dishes\}$

$I(Place\_orders)=\{Arrived\}$  
$O(Place\_orders)=\{Ordered\}$

$I(Modify\_dishes)=\{Ordered,Modify\_operation,Available\_items\}$  
$O(Modify\_dishes)=\{Ordered,Modify\_operation,Available\_items,Cancelled\}$

$I(Prepare\_ordered\_dishes)=\{Ordered,Available\_restaurant\_employee\}$  $O(Prepare\_ordered\_dishes)=\{Preparing\}$

$I(Serve\_ordered\_dishes)=\{Preparing\}$  
$O(Serve\_ordered\_dishes)=\{Available\_restaurant\_employee,Served\}$

Initial marking is $\mu=\{5,0,0,0,0,2,10,2\}$



## Definition of all colsets

```ML
colset OPT = with add | del;
colset TABLEID = index tid with 1..10;
colset ORDERID = index oid with 1..20;
colset DISHES = with Reuben
| Sandwich 
| Salad 
| Steak
| Carpaccio
| Hamburger
| Samosas
| Gyoza
| Pizza 
| Cheese;
colset QUANTITY = int;
colset ORDERITEM = product DISHES * QUANTITY;
colset ORDERITEMLST = list  DISHES;
colset ORDER = product TABLEID * ORDERID * ORDERITEMLST;
colset WAITERNAME = with Wendy | Rose;
colset ORDERxWAITER = product ORDER * WAITERNAME;
var tidv: TABLEID;
var oidv: ORDERID;
var dish: DISHES;
var olst: ORDERITEMLST;
var opt: OPT;
var waiter: WAITERNAME;
fun modifyorder(olst:ORDERITEMLST,opt:OPT,dish:DISHES) = 
(case opt of 
del => if (length olst)>0 
then (rm dish olst)
else nil 
| add => ins_new olst dish)
```

#### Explaination

There are 2 employee who can serve orders of customers  in the Dinning67 restaurant and 5 arrived customers with initial orders. They can modify their orders when the order is ordered by adding or deleting items. There are 10 available dishes.