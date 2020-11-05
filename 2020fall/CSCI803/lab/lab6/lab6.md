<!--
 * @Author: maywzh
 * @Date: 2020-11-03 14:32:26
 * @FilePath: /ji_coursenotes/2020fall/CSCI803/lab/lab6/lab6.md
-->
# Lab06

## Q1
SH-Shanghai JN-Jinan XA-Xian CQ-Chongqing CD-Chengdu FZ-Fuzhou BJ-Beijing
SHZ-Shijiazhuang GZ-Guangzhou HZ-Hangzhou NJ-Nanjing WH-Wuhan ZZ-Zhengzhou



## Q2
| **The current shortest path vertex set S**                   | **The left vertex set U**                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| S = {Guangzhou}                                              | U = {Chongqing, Wuhan, Fuzhou, Chengdu, Xi’an, Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou}                                      | U = {Chongqing, Wuhan, Chengdu, Xi’an, Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan}                               | U = {Chongqing, Chengdu, Xi’an, Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan, Chongqing}                    | U = {Chengdu, Xi’an, Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan, Chongqing, Chengdu}           | U = {Xi’an, Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan, Chongqing, Chengdu, Xi’an}    | U = {Zhengzhou, Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan, Chongqing, Chengdu, Xi’an, Zhengzhou} | U = {Nanjing, Shanghai, Hangzhou, Beijing, Shijiazhuang, Jinan} |
| S = {Guangzhou, Fuzhou, Wuhan,Chongqing, Chengdu, Xi’an, Zhengzhou, Shijiazhuang} | U = {Nanjing, Shanghai, Hangzhou, Beijing,Jinan}             |
| S = {Guangzhou, Fuzhou, Wuhan, Chongqing, Chengdu, Xi’an, Zhengzhou, Shijiazhuang, Beijing} | U = {Nanjing, Shanghai, Hangzhou}                            |

Thus, the shortest path from Guangzhou to Beijing is: Guangzhou—>Wuhan—>Zhengzhou—>Shijiazhuang—>Beijing=1930


## Q3
```python
import sys
if __name__=='__main__':
    MAX = sys.maxsize
    primgraph = [[MAX, 250, 900, 360, MAX, 890, MAX, MAX, MAX,MAX, MAX, MAX, MAX],[250, MAX, 630, MAX, 370, MAX, MAX, MAX, MAX,MAX, MAX, MAX, MAX],[900, 630, MAX, MAX, 430, MAX, 620, 650, MAX,MAX, 580, MAX, MAX],[360, MAX, MAX, MAX, 380, 530, MAX, MAX, MAX,MAX, MAX, MAX, MAX],[MAX, 370, 430, 380, MAX, MAX, MAX, 470, MAX,MAX, MAX, MAX, MAX],[890, MAX, MAX, 530, MAX, MAX, MAX, 470, 260,MAX, MAX, MAX, MAX],[MAX, MAX, 620, MAX, MAX, MAX, MAX, MAX, MAX,MAX, 280, MAX, MAX],[MAX, MAX, 650, MAX, 470, 470, MAX, MAX, 700,570, 760, 700, 840],[MAX, MAX, MAX, MAX, MAX, 260, MAX, 700, MAX,170, MAX, MAX, MAX],[MAX, MAX, MAX, MAX, MAX, MAX, MAX, 570, 170,MAX, MAX, 480, MAX],[MAX, MAX, 580, MAX, MAX, MAX, 280, 760, MAX,MAX, MAX, MAX, 980],[MAX, MAX, MAX, MAX, MAX, MAX, MAX, 700, MAX,480, MAX, MAX, 700],[MAX, MAX, MAX, MAX, MAX, MAX, MAX, 840, MAX,MAX, 980, 700, MAX]]
    cityarray = ['Beijing','Shijiazhuang','Xian','Jinan','Zhengzhou','Nanjing','Chengdu','Wuhan','Shanghai', 'Hangzhou', 'Chongqing', 'Fuzhou','Guangzhou']
    citylist = []
    citylist.append(cityarray[0])
    mid = [] # mid[i] represents the number of the point closest to point i in the spanning tree set
    lowcost = [] # lowcost[i] represents the minimum weight of the edge formed by the point closest to point i in the spanning tree set, and -1 represents that i is already in the spanning tree set
    lowcost.append(-1)
    mid.append(0)
    n = len(cityarray)
    for i in range(1,n): # Initialize mid array and lowcost array
        lowcost.append(primgraph[0][i])
```