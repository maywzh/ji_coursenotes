data<-read.csv("./heart.csv", head = TRUE, fileEncoding = 'GBK')
set.seed(1)
sub<-sample(1:nrow(data),round(nrow(data)*2/3))
data_train<-data[sub,]
data_test<-data[-sub,]
dim(data_train)
dim(data_test) 
library(rpart)
dt_model = rpart(target~., data = data_train,method = "class",parms = list(split="information"))
summary(dt_model)
library(rpart.plot)
rpart.plot(dt_model) test_predict=predict(dt_model,newdata = data_test,type="class")
test_predict
test_confusion=table(test_predict, data_test$target, dnn = c("Predicted", "Actual"))
test_confusion
acc <- sum(diag(test_confusion)) / sum(test_confusion)
acc 
library(ROCR)
test.pred<-prediction(test.predict[,2],data_test$target)
test.perf<-performance(test.pred,"tpr","fpr")  
View(test.perf) 
plot(test.perf,main="ROC Curve",col = "blue", lty = 1, lwd = 3)
auc_ROCR <- performance(test.pred, measure = "auc")
auc_ROCR
auc_ROCR <- auc_ROCR@y.values[[1]]
auc_ROCR