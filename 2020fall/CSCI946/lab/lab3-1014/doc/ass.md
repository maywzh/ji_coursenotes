# Lab Week 4
## Task One
```R
> library(plyr)
> library(ggplot2)
> library(cluster)
> library(lattice)
> library(graphics)
> library(grid)
> library(gridExtra)
> library(ggthemes)
> grade_input = as.data.frame(read.csv('./grades_km_input.csv'))
> kmdata_orig = as.matrix(grade_input[,c('Student','English','Math','Science')])
> kmdata<-kmdata_orig[,2:4]
> View(kmdata)
> wss <- numeric(15)
> for (k in 1:15) wss[k] <- sum(kmeans(kmdata,centers=k,nstart=25)$withinss)
> plot(1:15,wss,type='b',xlab='Number of Clusters', ylab='Within Sum of Squares')
> km=kmeans(kmdata,3,nstart=25)
> km
K-means clustering with 3 clusters of sizes 218, 244, 158

Cluster means:
   English     Math  Science
1 73.22018 64.62844 65.84862
2 85.84426 79.68033 81.50820
3 97.21519 93.37342 94.86076

Clustering vector:
  [1] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [48] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
 [95] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[142] 3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 2 2 2 2 2 2 2 2 2 3 3 2 2 3 2 2 2 3 2 2
[189] 2 2 2 2 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[236] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[283] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[330] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[377] 1 1 1 1 1 1 1 2 1 2 1 2 2 2 1 1 1 1 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[424] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 2
[471] 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[518] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[565] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 1 1 2 2 2 2 3 3 2
[612] 2 2 1 1 2 1 2 2 2

Within cluster sum of squares by cluster:
[1] 34806.339 22984.131  6692.589
 (between_SS / total_SS =  76.5 %)

Available components:

[1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"   
[7] "size"         "iter"         "ifault"      
> c(wss[3],sum(km$withinss))
[1] 64483.06 64483.06
> save.image('task1.RData')
```


## Task Two
```R
# task2.r
> library(plyr)
> library(ggplot2)
> library(cluster)
> library(lattice)
> library(graphics)
> library(grid)
> library(gridExtra)
> library(ggthemes)
> data(ruspini)
> wss<-numeric(15)
> for (k in 1:15) wss[k] <- sum(kmeans(ruspini,centers=k,nstart=25)$withinss)
> plot(1:15,wss,type='b',xlab='Number of clusters',ylab='Within sum of squares')
> km<-kmeans(ruspini,5)
> plot(ruspini[c('x','y')],col=km$cluster,pch=as.integer(ruspini$Species))
> points(km$centers[,c('x','y')],col=1:5,pch=8,cex=2)
> km$cluster
 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 
 3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  2  2  2  2  2  2  2  2  2  2  2  2  2 
34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 
 2  2  2  2  2  2  2  2  2  2  5  4  4  4  4  5  5  5  5  5  5  5  5  5  5  5  5  1  1  1  1  1  1 
67 68 69 70 71 72 73 74 75 
 1  1  1  1  1  1  1  1  1 
> print(km)
K-means clustering with 5 clusters of sizes 15, 23, 20, 4, 13

Cluster means:
          x        y
1  68.93333  19.4000
2  43.91304 146.0435
3  20.15000  64.9500
4  80.50000 100.2500
5 103.61538 119.3846

Clustering vector:
 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 
 3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  2  2  2  2  2  2  2  2  2  2  2  2  2 
34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 
 2  2  2  2  2  2  2  2  2  2  5  4  4  4  4  5  5  5  5  5  5  5  5  5  5  5  5  1  1  1  1  1  1 
67 68 69 70 71 72 73 74 75 
 1  1  1  1  1  1  1  1  1 

Within cluster sum of squares by cluster:
[1] 1456.533 3176.783 3689.500  381.750 1422.154
 (between_SS / total_SS =  95.9 %)

Available components:

[1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"   
[7] "size"         "iter"         "ifault"      
> save.image('task2.RData')
```
