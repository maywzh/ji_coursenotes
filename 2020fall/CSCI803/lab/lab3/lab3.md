# Lab3
## Task a.

$$
\begin{matrix}
2 &3 &4 &5 \\
8 &9 &12 &\infty \\
14& 16&\infty &\infty \\
\infty &\infty &\infty &\infty
\end{matrix} 
$$




## Task b.
if $Y[1,1]=\infty$, As $Y[i,j]\geq Y[1,1]$, $Y[i,j]=\infty$, $Y$ is empty,
if $Y[m,n]<\infty$, we can set $Y[i,j], Y[i,j]<Y[i+offset,j], Y[i,j]<Y[i,j+offset] for offset>0$
## Task c.
We know $Y[1,1]\leq Y[i,j]$, Set $tmp \leftarrow Y[1,1] , Y[1,1] \leftarrow \infty$, Then we rearrange the Matrix elements to satisfy the rule of Young tableau. 

Compare $Y[i,j]$ with $min(Y[i+1,j],Y[i,j+1])$ and Swap them., then we satisfy the property of the young tableau again. Repeat the operation until $Y[i,j]<min(Y[i+1,j],Y[i,j+1])$

Then $$T(p)=T(p-1)+O(1)=...=O(p)$$
## Task d.
Swap $Y[i,j]$ with $min(Y[i+1,j],Y[i,j+1])$ until $Y[i,j]<min(Y[i+1,j],Y[i,j+1])$, Start from $Y[m,n]$, for $i\leftarrow i-1$ for $j\leftarrow j-1$. The Time complexity is $O(m+n)$
## Task e.
Insert $n^2$ elements to empty tableau.

Insert: $O(n)$

Total: $O(n^2*n) = O(n^3)$

Then take $Y[1,1]$ and restore the tableau, the total Time complexity is $O(n^3)$

## Task f.
The algorithm is 
```pseudocode
i:=m 
j:=1
while i>=1 and j<=n do 
    if Y[i,j]>key then do
        i:=i-1
    else if Y[i,j]<key then do
        j:=j+1
    else
        if i>=1 and j<=n
            return i,j
    end
end
```
start from $i \leftarrow m, j\leftarrow 1, cur \leftarrow Y[m,1]$ if $key<Y[i,j]$ set $i\leftarrow i-1$ if $key>Y[i,j]$ set $j\leftarrow j+1$ repeat the operation until $i=0$ or $j>n$, or $Y[i,j] = key$