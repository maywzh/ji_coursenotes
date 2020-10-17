# Lab 04
## 8-2 Sorting in place in linear time
### a.
```pseudocode
result <- []
front <- 0
tail <- 0
for i <- 0 to n do
    if arr[i]=0 then
        result[front] <- arr[i] 
        front <- front+1
        tail <- tail+1
    else
        result[front] <- arr[i] 
        tail <- tail+1 
    end if
end
return result


```

### b.
We count the number of 0/1 of the array, and rearrange the elements.
```pseudocode
len := len(arr)
cnt:= 0
for i := 0 to len-1 do
    if arr[i] == 0
        cnt+=1
end
for i := 0 to cnt-1 do
    arr[i] := 0
end
for i := cnt to len-1 do
    arr[i] := 1
end 

```

### c. 
Bubble sort
```pseudocode 
n := len(arr)
for i:= 0 to n-1 do
    for j:= 0 to n-i-1 do 
        if arr[j] > arr[j+1] then
            arr[j],arr[j+1] := arr[j+1], arr[j]
        end if
    end
end
        
```

### d.
Sort the array with eacch bit, from the lower bit to highter bit. 

### e. 
```pseudocode
sort(arr, minv, maxv) 
begin
    cnt := []
    n := len(arr)
    for i := 0 to max-min do
        cnt[i] := 0
    end
    for i := 0 to n-1 do 
        cnt[n-min] += 1
    end
    result := []
    idx := 0
    for i := 0 to range(len(cnt)) do
        while cnt[i] >0 do 
            result[idx] := i + min
            idx += 1
            cnt[i] -= 1
        end
    end
end
```

## 9-2 Weight median
### a. 
Assuming $x_m$ is the median of array $x_1,x_2,...,x_n$
Then we get that $|\{x_i|x_i<x_m\}| \leq n/2$, $|\{x_i|x_i>x_m\}| \leq n/2$
Then $$\sum_{x_i<x_k}{W_i}=\sum_{x_i<x_k}{\frac{1}{n}}\leq 1/2$$
$$\sum_{x_i>x_k}{W_i}=\sum_{x_i>x_k}{\frac{1}{n}}\leq 1/2$$

### b.
Sort the array and then get the weighted median.
```pseudocode
calculate(x)
if n = 1 then
    reutnr x1
else n=2 then
    if w1>=w2
        then return x1
        else return x2
else 
    find the median xk of x=[x1-xn]
    partition the set X around xk
    compute Wl=sum(wi) for xi<xk and Wr = sum(wi) for xi>xk
    if wl < 1/2 and wr > 1/2
        then return xk
    elseif wl > 1/2
        then wk:=wk+wg
    else wk:=wk+wl
        return calculate(x)

```

### c.
```pseudocode
calculate(arr)
begin
    n := len(arr)
    if n=1 then
        return arr[0]
    else n=2 then
        return max(arr[0],arr[1])
    else 
        k := n/2
        suml:=0
        sumr:=0
        for i := 0 to k-1 do
            suml += arr[i]
        end
        for i:= k to n-1 do 
            sumr += arr[i]
        end
        if suml<1/2 and sumr <1/2 then
            return arr[k]
        else suml>1/2 then
            arr[k] += sumr
            return calculate(arr[:k+1])
        else
            arr[k] += suml
            return calculate(arr[k:])
        end if 
    end if
end 
    
```