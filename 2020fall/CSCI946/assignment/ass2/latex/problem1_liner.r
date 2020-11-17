library(grid)
library(broom)
library(tidyr)
library(dplyr)
library(scales)
library(ggthemr)
library(ggthemes)
library(gridExtra)
library(data.table)
library(caret)
library(ggplot2)
library(MASS)
library(car)
library(mlogit)
library(sqldf)
library(Hmisc)
library(boot) 
library(QuantPsyc)
library(lmtest)
library(sandwich)
library(vars)
library(nortest)
library(zoo)
library(InformationValue)
library(ROCR)
library(pROC)

dt<-read.csv("./BigData/ASS2/heart1.csv",na.strings = "?")
dt <- na.omit(dt) # handle NA
head(dt)
set.seed(111)
for(i in c(2,3,6,7,9,11,13)){
  dt[,i] <- as.factor(dt[,i])
}

summary(dt)
summary(dt$age)
dt$age<-cut(as.numeric(dt$age),breaks = 3,labels=c("low1","normal1","high1"))
levels(dt$age)
table(dt$age)

summary(dt$chol)
dt$chol<-cut(as.numeric(dt$chol),breaks =3,labels=c("low","normal","high"))
levels(dt$chol)
table(dt$chol)


samp<-sample(2,nrow(dt),replace = T,prob = c(0.7,0.3))
training<-dt[samp==1,]
test<-dt[samp==2,]
head(training)
head(test)
colSums(is.na(test))

for(i in c(2,3,6,7,9,11,13)){
  training[,i]<-as.factor(training[,i])
}
for(i in c(2,3,6,7,9,11,13)){
  test[,i]<-as.factor(test[,i])
}
str(training)
str(test)

mod<-glm(target~.,data = training,family = binomial('logit'))
summary(mod)
AIC(mod)
BIC(mod)

predicted<-predict(mod,training,type ="response")
training$predd<-round(predicted,3)
View(training)
ggplot( training, aes( training$predd, color = as.factor(training$target) ) ) + 
  geom_density( ) +
  ggtitle( "Training Set's Predicted Score" )
training$predw<-ifelse(training$predd>0.46,1,0)
confusn<-confusionMatrix(training$target,training$predw,threshold = 0.46)
confusn
class(confusn)
confusn<-as.matrix(confusn)
AccuracyRate <- sum(diag(confusn))/sum(confusn)
AccuracyRate

test$prob <- predict(mod,test,type = "response")
View(test)
ggplot( test, aes( test$prob, color = as.factor(test$target) ) ) + geom_density( size = 1 ) + ggtitle( "Test Set's Predicted Score" )
test$predc<-ifelse(test$prob>0.475,1,0)
confusn<-confusionMatrix(test$target,test$predc,threshold = 0.475)
confusn
class(confusn)
confusn<-as.matrix(confusn)
AccuracyRate <- sum(diag(confusn))/sum(confusn)
AccuracyRate

test$target <- as.factor(test$target)
rocCurve   <- roc(response = test$target, predictor = test$predc ,levels = rev(levels(test$target)))
rocCurve
plot.roc(test$target,test$predc)

test$predclass <-ifelse(test$predc>coords(rocCurve,"best")[1],1,0)
Confusion <- table(Predicted = test$predclass,Actual = test$target)

length(test$predclass)
