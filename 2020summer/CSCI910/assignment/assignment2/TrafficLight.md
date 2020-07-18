





























































































































### TrafficLight

#### Petri Net Graph

![pn](C:\Users\maywz\Workspace\ji_coursenotes\2020summer\CSCI910\assignment\assignment2\pn.png)

#### Mathematic definition

$C=(P,T,I,O)$

$P=\{L1R,L1G,L1Y,L2R,L2G,L2Y,L34R,L34G,L34Y\}$

$T=\{ab,bc,cd,de,ea\}$

$I(ab)=\{L1R,L34R\}$ $O(ab)=\{L1G,L34G\}$

$I(bc)=\{L34G\}$ $O(bc)=\{L34Y\}$

$I(cd)=\{L2R,L34Y\}$ $O(cd)=\{L2G,L34R\}$

$I(de)=\{L1G,L2G\}$ $O(de)=\{L1Y,L2Y\}$

$I(ea)=\{L1Y,L2Y\}$ $O(ea)=\{L1R,L2R\}

The initial marking is: $\mu=(1,0,0,1,0,0,1,0,0)$

#### The definition of all colsets

```ML
  colset DATA = string;
  var c,c': DATA;
  fun TransColor(c:DATA) = (case c of
  						   "Red" => 1`"Green" | 
  						   "Green" => 1`"Yellow" |
                           "Yellow" => 1`"Red");
```

#### State space analysis

```
Statistics
------------------------------------------------------------------------

State Space
Nodes:  5
Arcs:   5
Secs:   0
Status: Full

Scc Graph
Nodes:  1
Arcs:   0
Secs:   0


Boundedness Properties
------------------------------------------------------------------------

Best Integer Bounds
Upper      Lower
TrafficLight'L1G 1      1          0
TrafficLight'L1R 1      1          0
TrafficLight'L1Y 1      1          0
TrafficLight'L2G 1      1          0
TrafficLight'L2R 1      1          0
TrafficLight'L2Y 1      1          0
TrafficLight'L34G 1     1          0
TrafficLight'L34R 1     1          0
TrafficLight'L34Y 1     1          0

Best Upper Multi-set Bounds
TrafficLight'L1G 1  1`"Green"
TrafficLight'L1R 1  1`"Red"
TrafficLight'L1Y 1  1`"Yellow"
TrafficLight'L2G 1  1`"Green"
TrafficLight'L2R 1  1`"Red"
TrafficLight'L2Y 1  1`"Yellow"
TrafficLight'L34G 1 1`"Green"
TrafficLight'L34R 1 1`"Red"
TrafficLight'L34Y 1 1`"Yellow"

Best Lower Multi-set Bounds
TrafficLight'L1G 1  empty
TrafficLight'L1R 1  empty
TrafficLight'L1Y 1  empty
TrafficLight'L2G 1  empty
TrafficLight'L2R 1  empty
TrafficLight'L2Y 1  empty
TrafficLight'L34G 1 empty
TrafficLight'L34R 1 empty
TrafficLight'L34Y 1 empty


Home Properties
------------------------------------------------------------------------

Home Markings
All


Liveness Properties
------------------------------------------------------------------------

Dead Markings
None

Dead Transition Instances
None

Live Transition Instances
All


Fairness Properties
------------------------------------------------------------------------

Impartial Transition Instances
TrafficLight'ab 1
TrafficLight'bc 1
TrafficLight'cd 1
TrafficLight'de 1
TrafficLight'ea 1

Fair Transition Instances
None

Just Transition Instances
None

Transition Instances with No Fairness
None
```

