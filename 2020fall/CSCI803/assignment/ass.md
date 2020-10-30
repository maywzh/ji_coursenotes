# Assignment 1
## Question 1
$$\log_b^{x^n}=\log_b^{\prod\limits_{i=1}^n x}=\sum\limits_{i=1}^n \log_b^x=n\log_b^x$$

## Question 2
### a.
As $k>2+\frac{1}{k},k\in \mathbb{Z}$, so $k\geq 3$
As $k>2+\frac{1}{k},k^2>2k+1\Rightarrow 2k^2>k^2+2k+1=(k+1)^2$
As $k^2>2k+1\Rightarrow k^2-2k+1>2\Rightarrow(k-1)^2>2$, so $k>1+\sqrt{2}$
In summary, $k\geq 3$

### b.
Set $f(n)=2^n-2n^2$ ,Then $f^{'}(n)=2^n\ln2-4n$
$f^{''}(n)=2^n(\ln2)^2-4>0$ for $N\in\mathbb{Z}$ and $N>6$, so $f^{'}(n)$ monotonically increase when $n>6$
As $f^{'}(7)=2^7\ln2-28>0$ so $f^{'}(n)>0$ for $N\in\mathbb{Z}$ and $N>6$, so $f(n)$ monotonically increase when $n>6$
$f(7)=2^7-98>0$ so $f(n)>0$ for $N\in\mathbb{Z}$ and $N>6$

### c
$\lim\limits_{n\rightarrow\infty}{\frac{2^n}{2n}} > \lim\limits_{n\rightarrow\infty}{n} =\infty_{+}$

### d
According to L'Hôpital's rule
$\lim\limits_{m\rightarrow\infty}{\frac{\log_2^m}{\sqrt{m}}}=\lim\limits_{m\rightarrow\infty}{\frac{1}{m\ln{2}\frac{1}{2}\frac{1}{\sqrt{m}}}}=\frac{2}{\ln2}\lim\limits_{m\rightarrow\infty}{\frac{1}{\sqrt{m}}}$



## 3.
### a.
The worst space complexity:
O(1+1/2n+1/4n+...)=O(N)

### b.
Time complexity of each iteration: 
$\frac{N}{2^{n-1}}$
The worst case is $O((1+\frac{1}{2}+\frac{1}{4}+...)N)=T(2N)$
The best case is $\Omega(N) = T(N)$
$\Theta(N)= T((1+\frac{1}{2}+\frac{1}{4}+...)N)=(2-\frac{1}{2^{n-1}})N$

### c.
The algorithm use "Divide conquer" pattern. In a binary group, if two elements are equal, there is no winner for that binary group. Each iteration of the round, the winner of the small binary group is selected. Each time it is progressively eliminated, and what is left is the number with the most numbers in that array. 

### d.
