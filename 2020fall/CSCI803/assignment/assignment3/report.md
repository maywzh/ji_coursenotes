# Assignment 3
## Problem description
Given two sorted arrays `nums1` and `nums2` of size `m` and `n` respectively, return the **median** of the two sorted arrays.

###Example
```
m=2 
n=1
nums1 = [1,3]
nums2 = [2]
median of the two array is 2
```
```
m=2 
n=2
nums1 = [1,2]
nums2 = [3,4]
median of the two array is 2.5
```

## Simple Merging Algorithm
### Analysis and strategy
Intuitively, we can merge two sorted array into one sorted array with merging operation, the space complexity is $O(m+n)$ as we need m+n memory space to store the merged array. the merging time complexity is $O(m+n)$

### Code

```java
public double findMedianSortedArrays(int[] nums1, int[] nums2) {
    int[] nums;
    int m = nums1.length;
    int n = nums2.length;
    nums = new int[m + n];
    if (m == 0) {
        if (n % 2 == 0) {
            return (nums2[n / 2 - 1] + nums2[n / 2]) / 2.0;
        } else {

            return nums2[n / 2];
        }
    }
    if (n == 0) {
        if (m % 2 == 0) {
            return (nums1[m / 2 - 1] + nums1[m / 2]) / 2.0;
        } else {
            return nums1[m / 2];
        }
    }

    int count = 0;
    int i = 0, j = 0;
    while (count != (m + n)) {
        if (i == m) {
            while (j != n) {
                nums[count++] = nums2[j++];
            }
            break;
        }
        if (j == n) {
            while (i != m) {
                nums[count++] = nums1[i++];
            }
            break;
        }

        if (nums1[i] < nums2[j]) {
            nums[count++] = nums1[i++];
        } else {
            nums[count++] = nums2[j++];
        }
    }

    if (count % 2 == 0) {
        return (nums[count / 2 - 1] + nums[count / 2]) / 2.0;
    } else {
        return nums[count / 2];
    }
}
```
## Counting Merging Algorithm
### Analysis
We can use pointer rather than an array to represent the element as we don't need to record all the elements. Using two pointer to point each array. Each time pointer pointing to the smaller number move to next number until the number of movement reach to $(m+n)/2$. By doing this, we make the space complexity down to $O(1)$, the time complexity is $O(m+n)$

### Code
```java
public double findMedianSortedArrays(int[] A, int[] B) {
    int m = A.length;
    int n = B.length;
    int len = m + n;
    int left = -1, right = -1;
    int aStart = 0, bStart = 0;
    for (int i = 0; i <= len / 2; i++) {
        left = right;
        if (aStart < m && (bStart >= n || A[aStart] < B[bStart])) {
            right = A[aStart++];
        } else {
            right = B[bStart++];
        }
    }
    if ((len & 1) == 0)
        return (left + right) / 2.0;
    else
        return right;
}
```

## Binary Search based Algorithm
### Analysis
The problem is to find the median, which is actually a special case of finding the kth decimal, and there is an algorithm for finding the kth decimal. Since the array is ordered, we can actually eliminate half and half. Suppose we want to find the kth decimal, we can eliminate k/2 numbers in each loop. Take a look at the following example.

We compare the $k/2_{th}$ number of the two arrays, and if $k$ is odd, round down. That is, if we compare the 33rd number, 44 in the top array and 33 in the bottom array, if it is smaller, it means that the first $k/2$ numbers of the array are not the $k_{th}$ smallest number, so we can exclude it.



### Code
```java
public double findMedianSortedArrays(int[] nums1, int[] nums2) {
    int n = nums1.length;
    int m = nums2.length;
    int left = (n + m + 1) / 2;
    int right = (n + m + 2) / 2;
    //将偶数和奇数的情况合并，如果是奇数，会求两次同样的 k 。
    return (getKth(nums1, 0, n - 1, nums2, 0, m - 1, left) + getKth(nums1, 0, n - 1, nums2, 0, m - 1, right)) * 0.5;  
}
    
    private int getKth(int[] nums1, int start1, int end1, int[] nums2, int start2, int end2, int k) {
        int len1 = end1 - start1 + 1;
        int len2 = end2 - start2 + 1;
        //让 len1 的长度小于 len2，这样就能保证如果有数组空了，一定是 len1 
        if (len1 > len2) return getKth(nums2, start2, end2, nums1, start1, end1, k);
        if (len1 == 0) return nums2[start2 + k - 1];

        if (k == 1) return Math.min(nums1[start1], nums2[start2]);

        int i = start1 + Math.min(len1, k / 2) - 1;
        int j = start2 + Math.min(len2, k / 2) - 1;

        if (nums1[i] > nums2[j]) {
            return getKth(nums1, start1, end1, nums2, j + 1, end2, k - (j - start2 + 1));
        }
        else {
            return getKth(nums1, i + 1, end1, nums2, start2, end2, k - (i - start1 + 1));
        }
    }
```
Time complexity: With each loop, we reduce $k/2$ elements, so the time complexity is $O(log(k))$, and $k=(m+n)/2$, so the final complexity is also $O(log(m+n))$

Space complexity: Although we use recursion, we can see that this recursion belongs to tail recursion, so the compiler does not need to keep stacking, so the space complexity is O(1).