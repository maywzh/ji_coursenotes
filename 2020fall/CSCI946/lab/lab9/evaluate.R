#after execution of tensorflowCNN.R
predicted = model %>% predict_classes(x_test)
missclassified = (predicted == mnist$test$y) == FALSE
n = length(predicted[missclassified])
print(paste("Number of missclassified samples:", n, "(", n/length(predicted), "%)"))
predicted[missclassified]
mnist$test$y[missclassified]

#plot missclassified samples (test set)
for (idx in which(missclassified)){
  im <- t(apply(x_test_raw[idx,,],2,rev))
  label=paste("predicted:", predicted[idx], "Label:", mnist$test$y[idx])
  image(1:28, 1:28, im, col=gray(1-(0:255)/255), main=paste(label))
}
