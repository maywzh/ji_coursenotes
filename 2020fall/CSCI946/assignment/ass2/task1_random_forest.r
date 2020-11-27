library(pROC)
library(randomForest)
data<-read.csv("./heart.csv", head = TRUE, fileEncoding = 'GBK')
set.seed(1)
sub<-sample(1:nrow(data),round(nrow(data)*2/3))
data_train<-data[sub,]
data_test<-data[-sub,]
dim(data_train)
dim(data_test) 
data_train$target = as.factor(data_train$target)
data_test$target = as.factor(data_test$target)
heart_randomforest <- randomForest(target ~ .,data = data_train,ntree =500,mtry=3,importance=TRUE ,proximity=TRUE)
wine_randomforest$importance
heart_randomforest$importance
varImpPlot(heart_randomforest, main = "variable importance")
pre_ran <- predict(heart_randomforest,newdata=data_test)
obs_p_ran = data.frame(prob=pre_ran,obs=data_test$target)
table(data_test$target,pre_ran,dnn=c("True","Predict"))
test_confusion=table(data_test$target,pre_ran,dnn=c("True","Predict"))
acc <- sum(diag(test_confusion)) / sum(test_confusion)
acc