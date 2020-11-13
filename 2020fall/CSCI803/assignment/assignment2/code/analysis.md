# Analysis
## First strategy
Use a single queue from which each server will take the next customer as soon as the server becomes available. 

```
>>>> strategy 1 <<<<
Number of people served:  1000
Time that the last customer being completely served:  30558.395
Average service time:  159.1083
Average time a customer spends in queue:  0.15424999999999636
Maximum time a customer spends in queue:  39.6929999999993
Enter the given second number: 1
Average length of queue in any given second:  0.0

Maximum Length of queue:  3

Total idle time for each server:
        server 0: 4798.595  s
        server 1: 6356.395  s
        server 2: 7248.495  s
        server 3: 8714.995  s
        server 4: 11381.895  s
        server 5: 15012.595  s
        server 6: 18344.995  s
        server 7: 20965.295  s
        server 8: 26030.395  s
        server 9: 27621.995  s
```


## Second strategy
Use a queue for each server. Customers will choose the server with the shortest queue on arrival and will not move from queue to queue. 
```
>>>> strategy 2 <<<<
Number of people served:  1000 
Time that the last customer being completely served:  30558.395
Average service time:  159.1083
Average time a customer spends in queue:  0.6125809999999965
Maximum time a customer spends in queue:  270.4279999999999
Maximum queue length:  2
Enter the given second number: 100
Average length of queue in any given second:  0.0

Maximum Length of queue:  2

Total idle time for each server:
        server 0: 4778.295  s
        server 1: 6402.995  s
        server 2: 7129.495  s
        server 3: 8953.595  s
        server 4: 11472.295  s
        server 5: 14800.495  s
        server 6: 18417.795  s
        server 7: 20868.295  s
        server 8: 26030.395  s
        server 9: 27621.995  s
```

## Comparation
### Strategy 1

| Number  of servers | Time that the last customer being completely served | Average service time | Average time a customer spends in queue | Maximum time a customer spends in queue | Maximum queue length | Total idle time for each server |
| ------------------ | --------------------------------------------------- | -------------------- | --------------------------------------- | --------------------------------------- | -------------------- | ------------------------------- |
| 1                  | 159119.842                                          | 159108.3             | 64552.066                               | 128731.682                              | 966                  | 11.542                          |
| 3                  | 53140.134                                           | 53036.1              | 11492.707                               | 22956.197                               | 678                  | 312.102                         |
| 10                 | 30558.395                                           | 15910.83             | 0.154                                   | 39.693                                  | 3                    | 145014.05                       |


### Strategy 2
| Number  of servers | Time that the last customer being completely served | Average service time | Average time a customer spends in queue | Maximum time a customer spends in queue | Maximum queue length | Total idle time for each server |
| ------------------ | --------------------------------------------------- | -------------------- | --------------------------------------- | --------------------------------------- | -------------------- | ------------------------------- |
| 1                  | 159119.842                                          | 159108.3             | 64552.066                               | 128731.682                              | 966                  | 11.542                          |
| 3                  | 54323.25                                            | 53036.1              | 11489.016                               | 24215.451                               | 684                  | 3806.45                         |
| 10                 | 30558.395                                           | 15910.83             | 0.493                                   | 158.275                                 | 2                    | 146475.65                       |


When number of servers is 1, these two strategies are equivalent.
When number of servers becomer larger, strategy 1 has less average queuing time and maximum queuing time, strategy has less maximum queuing length.