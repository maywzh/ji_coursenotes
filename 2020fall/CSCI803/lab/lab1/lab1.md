## Lab 01
### Problem 1

#### Algorithm

An algorithm is a list of rules to follow in order to solve a problem.
#### Data Structure

A data structure is a specialized format for organizing, processing, retrieving and storing data. 

#### Relation

A good algorithm usually comes together with a set of good data structures that allow the algorithm to manipulate the data efficiently. Algorithms are commonly used to solve certain types of computational problems. We can often describe such a problem by specifying a relationship between input and output. 

### Problem 2
```c++
#include <iostream>
using namespace std;
int Maximum(Vector<int> nums){
    int res = nums.at(0);
    for (int i=1;i<nums.size();i++){
        if (res < nums.at(i)){
            res = nums.at(i)
        }
    }
    return res;
}
int Minimum(Vector<int> nums){
    int res = nums.at(0);
    for (int i=1;i<nums.size();i++){
        if (res > nums.at(i)){
            res = nums.at(i)
        }
    }
    return res;
}
float Mean(Vector<int> nums){
    int sum = 0;
    for (int i=0;i<nums.size();i++){
        sum+=nums.at(i);
    }
    return (float)sum/nums.size();
}
float Variance(Vector<int> nums){
    int var = 0;
    float avg = Mean(nums);
    for (int i=0;i<nums.size();i++){
        var+=(float)(nums.at(i)-avg)*(nums.at(i)-avg);
    }
    return var/nums.size();
}
int main(){
    return 0;
}
```

