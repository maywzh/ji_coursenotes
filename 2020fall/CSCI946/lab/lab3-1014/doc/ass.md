# Lab Week 4
## Task One
```R
> grades_input = as.data.frame(read.csv('./grades_km_input.csv'))
> kmdata_orig = as.matrix(grade_input[,c('Student','English','Math','Science')])
Error in as.matrix(grade_input[, c("Student", "English", "Math", "Science")]) : 
  object 'grade_input' not found
> kmdata_orig = as.matrix(grades_input[,c('Student','English','Math','Science')])
> kmdata<-kmdata_orig[,2:4]
> View(kmdata)
> wss <- numeric(15)
> for (k in 1:15) wss[k] <- sum(kmeans(kmdata,centers=k,nstart=25)$withinss)
> plot(1:15,wss,type='b',xlab='Number of Clusters', ylab='Within Sum of Squares')
> km=kmeans(kmdata,3,nstart=25)
> km
K-means clustering with 3 clusters of sizes 244, 158, 218

Cluster means:
   English     Math  Science
1 85.84426 79.68033 81.50820
2 97.21519 93.37342 94.86076
3 73.22018 64.62844 65.84862

Clustering vector:
  [1] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
 [49] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
 [97] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[145] 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 2 2 1 1 2 1 1 1 2 1 1 1 1 1 1
[193] 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[241] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[289] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
[337] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 3 3 3 3 3 3 1
[385] 3 1 3 1 1 1 3 3 3 3 1 1 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[433] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 3 3 3 1 3 3 3 3 3 3 3 3 1 3
[481] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[529] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[577] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 1 3 3 1 1 1 1 2 2 1 1 1 3 3 1 3 1 1 1

Within cluster sum of squares by cluster:
[1] 22984.131  6692.589 34806.339
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
library(plyr)
library(ggplot2)
library(cluster)
library(lattice)
library(graphics)
library(grid)
library(gridExtra)
library(ggthemes)
data(ruspini)
wss<-numeric(15)
for (k in 1:15) wss[k] <- sum(kmeans(ruspini,centers=k,nstart=25)$withinss)
plot(1:15,wss,type='b',xlab='Number of clusters',ylab='Within sum of squares')
km<-kmeans(ruspini,5)
plot(ruspini[c('x','y')],col=km$cluster,pch=as.integer(ruspini$Species))
points(km$centers[,c('x','y')],col=1:5,pch=8,cex=2)
km$cluster
print(km)
save.image('task2.RData')
```
