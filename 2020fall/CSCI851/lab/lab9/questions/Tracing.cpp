     1	#include<iostream>
     2	using namespace std;
     3	class A
     4	{
     5	public:
     6	  A( ){}
     7	  ~A( ){}
     8	};
     9	class B : public A
    10	{
    11	public:
    12	  B( ){}
    13	  B(int x){}
    14	  ~B( ){}
    15	};
    16	class C : public B
    17	{
    18	public:
    19	  C( ){}
    20	  C(int x):B(x){}
    21	};
    22	int main( ){
    23	  {A obja;
    24	  B objb;}
    25	  B bAlt(5);
    26	  C c;
    27	  {C cAlt(0);}
    28	}
       
