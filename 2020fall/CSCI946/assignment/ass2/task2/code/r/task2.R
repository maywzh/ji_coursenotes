#=============================================================================
# SET WORKING DIRECTORY TO SOURCE FILE LOCATION
#=============================================================================

library(stringr)        # find strings within data frame
library(tm)             # text mining
library(SnowballC)      # stemming
library(slam)           # computation on sparse matrices
library(topicmodels)    # LDA
library(RWeka)          # use bigrams
library(e1071)          # classifiers (NB, SVM)
library(randomForest)   # random forests
library(fpc)            # DBSCAN, PAMK, further clustering
library(cluster)        # PAM, silhouette measures


#=============================================================================
# IMPORT & CLEAN DATA
#=============================================================================

# import data
reuters <- read.csv("reutersCSV.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------------------------
# combine document title & text into single string; extract company tags; clean data
clean.data <- function(data) {
  
  #combine document text & title into single string
  data$doc <- paste(data$doc.title, data$doc.text, sep = " ")
  
  # extract company identifiers
  # correct < symbol from &lt; - allows us to pull out company identifiers
  data$doc <- gsub("&lt;", "<", data$doc)
  
  # replace non-apostrophe punctuation with spaces
  # (splits up eg. Jun/Jul - otherwise this would appear as a single word)
  data$doc <- gsub("[^[:alnum:][:space:]<>]", " ", data$doc)
  
  # convert all factors back into character strings
  data <- data.frame(lapply(data, as.character), stringsAsFactors = FALSE)
  
  # extract company tags as single unbroken strings
  companytags <- lapply(str_extract_all(data$doc, "(<.+?>)"), paste, collapse = " ")
  companytags <- gsub(" ", "", companytags)       # remove strings from company tags
  companytags <- gsub("><", "> <", companytags)   # replace spaces between company tags
  
  # remove company tags from main document (they are essentially a duplicate)
  data$doc <- str_replace_all(data$doc, "(<.+?>)", "")  
  
  # data cleaning
  # has to be done here instead of in DTM function - 
  # otherwise bigrams often include stopwords or whitespace
  # stemming is performed as part of DTM creation - not as effective at this point.
  
  # general text cleaning
  data$doc <- tolower(data$doc)
  data$doc <- removePunctuation(data$doc)
  data$doc <- removeNumbers(data$doc)
  data$doc <- removeWords(data$doc, stopwords("english"))
  data$doc <- stripWhitespace(data$doc)
  
  cbind.data.frame(data, companytags, stringsAsFactors = FALSE)
}

reuters <- clean.data(reuters)


#=============================================================================
# TAG DOCUMENTS WITH TOPICS
#=============================================================================

# tag topics (this creates duplicates of some lines, one for each topic of interest - equally weighted)
get.topics <- function(data, topic.list) {
  
  # data frame to hold output
  tagged <- data.frame()
  
  # iterate over all columns, extracting documents with that tag applied
  for (i in 4:138) {
    
    # ignore any columns without tags
    if (sum(as.numeric(data[,i])) > 0) {
      
      # pick up topic name from column header
      topic.name <- gsub("topic.", "", colnames(data)[i], )
      
      # only tag topics of interest
      if (topic.name %in% topic.list) {
        
        just.tagged <- cbind("pid" = data[data[,i] == 1, 1], 
                             "topic" = topic.name)
        
        tagged <- rbind(tagged, just.tagged)
      }
    }
  }
  
  # extract all documents that don't relate to topics on the list and tag as 'Other'
  untagged <- cbind("pid" = data[!data$pid %in% tagged$pid, 1],
                    "topic" = "_other")
  
  # output all data with topic tags assigned
  data.frame(lapply(rbind(tagged, untagged), as.character), stringsAsFactors = F)
}

topics.of.interest <- c("earn", "acq", "money.fx", "grain", "crude", "trade", "interest", "ship", "wheat", "corn")
topic.list <- get.topics(reuters, topics.of.interest)

#-----------------------------------------------------------------------------
# clean up duplicate grain/corn/wheat tags to allow for better separation

unduplicate.topics <- function(data, topics.to.keep, topics.to.cut) {
  
  # extract documents with corn, wheat or grain as topic
  cw <- data[data$topic %in% c(topics.to.keep), ]
  g <- data[data$topic %in% c(topics.to.cut), ]
  
  # create df from all corn/wheat topics and all 'grain' not also tagged as corn or wheat
  cwg <- rbind(cw, g[!(g$pid %in% cw$pid), ])
  
  # trim data to remove all lines with topics in question
  data <- data[!(data$topic %in% c(topics.to.keep, topics.to.cut)), ]
  
  # reattach topics in question without duplicated lines
  rbind(data, cwg)
}

# trim data so that topics tagged as "grain" as well as "corn" or "wheat" are tagged only as "corn" or "wheat"
topic.list <- unduplicate.topics(topic.list, c("corn", "wheat"), c("grain"))


#=============================================================================
# CREATE DOCUMENT-TERM MATRIX
#=============================================================================

# create a bigram tokenizer (will include unigrams & bigrams)
bigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))

# create a DTM of unigrams & bigrams
dtm.all <- DocumentTermMatrix(Corpus(VectorSource(reuters$doc)),
                              control = list(tokenize = scan_tokenizer,
                                             stemming = T))

# remove sparse terms (LDA does not work well with sparse terms)
dtm.all <- removeSparseTerms(dtm.all, .95)

# replace document number with PID
dtm.all$dimnames$Docs <- reuters$pid


#=============================================================================
# GENERATE TOPIC MODELS
#=============================================================================

# for training LDA, remove 'noise' documents from training set
lda.dtm <- reuters$pid[reuters$pid %in% c(reuters$pid[reuters$purpose == "test"],
                                          topic.list$pid[topic.list$topic %in% topics.of.interest])]

lda.dtm <- dtm.all[dtm.all$dimnames$Docs %in% lda.dtm,]

# remove empty rows
lda.dtm <- lda.dtm[row_sums(lda.dtm) > 0, ]

# run latent dirichlet allocation to generate 10 topics
lda <- LDA(lda.dtm, 10)

# get probabilities to use as features - reattach to list of all PIDs
lda.probs <- merge(reuters[,c(1,3)], 
                   cbind.data.frame("pid" = lda@documents, lda@gamma, stringsAsFactors = F),
                   by = "pid", all.x = T, incomparables = 0)

# replace unmatched values with 0 instead of NA: uniform non-zero likelihood of each class
lda.probs[is.na(lda.probs)] <- 0


#=============================================================================
# COMBINE ALL OF THIS INTO A SINGLE LABELLED FEATURE MATRIX
#=============================================================================

# combine DTM, topic tags and LDA probabilities into data frame
# matching on PID
all.data <- merge(topic.list, cbind(lda.probs, data.matrix(dtm.all)), by = "pid", all.x = "T")

# topic must be a factor for classification
all.data$topic <- as.factor(all.data$topic)

# extract training set
training.data <- all.data[all.data$purpose != "test", -c(1,3)]


#=============================================================================
# PROPOSE ADDITIONAL FEATURE SETS
#=============================================================================

# get n most likely terms per LDA topic cluster
lda.10 <- unique(c(terms(lda, 10)))
lda.20 <- unique(c(terms(lda, 20)))

#-----------------------------------------------------------------------------

# extract the n most frequent terms per topic
get.freq.terms <- function(dtm, n = 10) {
  
  terms <- list()
  
  # filter DTM to select terms for one topic at a time
  for (i in 1:length(levels(dtm$topic))) {
    topic <- levels(dtm$topic)[i]
    
    t.dtm <- dtm[dtm$topic == topic, -1]
    
    # selects terms with highest term frequency
    terms[[i]] <- names(sort(colSums(t.dtm), decreasing = T)[1:n])
    names(terms)[i] <- topic
  }
  
  terms
}

fr.10 <- unique(unlist(get.freq.terms(training.data[,-(2:11)], 10)))
fr.20 <- unique(unlist(get.freq.terms(training.data[,-(2:11)], 20)))

#-----------------------------------------------------------------------------
# FUNCTION TO GET N MOST SIGNIFICANT TERMS PER TOPIC BY CHI-SQUARED VALUE
get.chisq.terms <- function(dtm, n = 10) {
  
  terms <- list()
  
  # iterate over each topic, summing for each term
  for (i in 1:length(levels(dtm$topic))) {
    topic <- levels(dtm$topic)[i]
    cs <- c()
    
    tab <- rbind(colSums(dtm[dtm$topic == topic, -1]),
                 colSums(dtm[dtm$topic != topic, -1]))
    
    # iterate over each term, calculating Chi-sq statistic for each
    for (j in 1:ncol(tab)) {
      cs[j] <- suppressWarnings(chisq.test(cbind(tab[,j], rowSums(tab[,-j])))$statistic)
    }
    
    # allocate terms to vector of Chi-sq results
    names(cs) <- colnames(dtm)[-1]
    
    # take top n terms by Chi-sq, allocate to 'terms' list
    terms[[i]] <- names(sort(cs, decreasing = T))[1:n]
  }
  names(terms) <- levels(dtm$topic)
  terms
}

cs.10 <- unique(unlist(get.chisq.terms(training.data[,-(2:11)], 10)))
cs.20 <- unique(unlist(get.chisq.terms(training.data[,-(2:11)], 20)))


#=============================================================================
# FUNCTIONS TO ASSESS PERFORMANCE OVER FIRST RUN
#=============================================================================

# function to calculate performance measures per class
assess.performance <- function(res) {
  
  cm <- table("expected" = res$expected, "predicted" = res$predicted)
  
  if (ncol(cm) != nrow(cm)) {
    missing <- rownames(cm)[!(rownames(cm) %in% colnames(cm))]
    m <- matrix(nrow = nrow(cm), ncol = length(missing), 0)
    colnames(m) <- missing
    cm <- cbind(cm, m)
    cm <- cm[, sort(colnames(cm))]
  }
  
  TP <- diag(cm)
  FN <- rowSums(cm) - TP
  FP <- colSums(cm) - TP
  TN <- sum(cm) - TP - FN - FP
  
  # remove values for 'other'
  TP <- TP[-1]; FN <- FN[-1]; FP <- FP[-1]; TN <- TN[-1]
  
  recall <- TP / (TP + FN)
  precision <- TP / (TP + FP)
  fmeasure <- (2 * recall * precision) / (recall + precision)
  accuracy <- (TP + TN) / (TP + TN + FN + FP)
  
  tab <- cbind(recall, precision, fmeasure, accuracy)
  tab[is.na(tab)] <- 0
  
  # add macro-averages
  tab <- rbind(tab, "macro.avg" = colSums(tab) / nrow(tab))
  
  # calculate micro-averaged performance
  micro.recall <- sum(TP) / (sum(TP) + sum(FN))
  micro.precision <- sum(TP) / (sum(TP) + sum(FP))
  micro.fmeasure <- (2 * micro.recall * micro.precision) / (micro.recall + micro.precision)
  micro.accuracy <- (sum(TP) + sum(TN)) / (sum(TP) + sum(TN) + sum(FN) + sum(FP))
  
  tab <- rbind(tab, "micro.avg" = cbind(micro.recall, micro.precision,
                                        micro.fmeasure, micro.accuracy))
  rownames(tab)[nrow(tab)] <- "micro.avg"
  tab
}


# first pass: split 80/20 into temporary test & training sets
# for a quick initial comparison of feature sets
quick.svm <- function(data, features) {
  
  # trim data to only required features
  data <- data[,colnames(data) %in% c("topic", c(1:10), features)]
  
  # randomly order data
  rand <- data[sample(nrow(data), replace = FALSE),]
  
  # split 80:20 into training & test sets
  train <- rand[1:floor(nrow(rand) * .8), ]
  test <- rand[-(1:floor(nrow(rand) * .8)), ]
  
  # remove empty rows & columns from training data
  train <- train[rowSums(train[,-1]) > 0, ]
  train <- train[,!(colnames(train) %in% colnames(train[,-1])[colSums(train[,-1]) == 0])]
  
  # run model & compare predictions to expected values
  model <- svm(topic ~ ., data = train)
  prediction <- predict(model, newdata = test[,-1])
  result <- as.data.frame(cbind("expected" = as.character(test[,1]), "predicted" = as.character(prediction)))
  perf <- round(assess.performance(result)*100,1)
  
  z <- c(length(colnames(data)) - 1, perf[11:12,3:4], model$kernel, model$cost)
  names(z) <- c("n.features", "macro-f", "micro-f", "macro-a", "micro-a", "kernel", "cost")
  list("call" = model$call, "perf" = z, "cm" = table(result))
}

#=============================================================================
# INVESTIGATE PERFORMANCE ACROSS ADDITIONAL FEATURE SETS
#=============================================================================

proposed.features <- list('topic models only' = "", '+ lda.10' = lda.10, '+ lda.20' = lda.20, 
                          '+ fr.10' = fr.10, '+ fr.20' = fr.20,
                          '+ cs.10' = cs.10, '+ cs.20' = cs.20,
                          '+ all terms' = dtm.all$dimnames$Terms)

# run quick SVM model over 80:20 split of training data to compare performance
feature.comparison <- list()
for (i in 1:length(proposed.features)) {
  features <- proposed.features[[i]]
  feature.comparison[[i]] <- quick.svm(training.data, proposed.features[[i]])
  names(feature.comparison)[i] <- names(proposed.features)[i]
}
# extract performance measures & save to csv
feature.scores <- t(sapply(feature.comparison, "[[", 2))
feature.scores <- cbind.data.frame("feature.set" = rownames(feature.scores), feature.scores, stringsAsFactors = F)

write.csv(feature.scores, file = "feature.comparison.csv")


#=============================================================================
# CHECK PERFORMANCE USING K-FOLD CROSS-EVALUATION
#=============================================================================

# function to run & evaluate k-fold cross-validation
run.kfold <- function(dtm, k = 10, classifier = svm) {
  
  # sort data into random order
  dtm <- dtm[sample(nrow(dtm), replace = FALSE), ]
  
  # create vector containing fold number
  folds <- rep(1:k, ceiling(nrow(dtm) / k))[1:nrow(dtm)]
  
  # initialise data frames to hold predicted & expected topics
  prediction <- data.frame()
  expected <- data.frame()
  
  # iterate over all k folds, each time reserving one to evaluate and using the rest to train
  for (i in 1:k){
    
    # split data into test & training sets
    trainingset <- dtm[folds != i,]
    
    # clean training set - remove any empty rows or columns
    trainingset <- trainingset[rowSums(trainingset[,-1]) > 0, ]
    trainingset <- trainingset[,!(colnames(trainingset) %in% colnames(trainingset[,-1])[colSums(trainingset[,-1]) == 0])]
    
    testset <- dtm[folds == i,]
    
    # run classifier on the training data
    model <- classifier(topic ~ ., data = trainingset)
    
    # use classifier to predict classes on test set (excluding actual topic)
    temp <- as.data.frame(predict(model, newdata = testset[,-1]))
    
    # add this iteration's predictions to 'prediction' data frame
    prediction <- rbind(prediction, temp)
    
    # add correct classifications to 'expected' data frame
    expected <- rbind(expected, as.data.frame(testset[, 1]))
  }
  
  result <- cbind(expected, prediction, folds, prediction == expected)
  colnames(result) <- c("expected", "predicted", "fold", "correct")
  
  perf <- round(assess.performance(result)*100,1)
  
  m <- round(mean(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct)))*100, 1)
  s <- round(sd(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct))), 3)
  
  z <- c(length(colnames(dtm)) - 1, perf[11:12,3:4], m, s)
  names(z) <- c("n.features", "macro-f", "micro-f", "macro-a", "micro-a", "pf-mean", "pf-sd")
  list("call" = model$call, "perf" = z, "result" = result)
}

kfold.fr10 <- run.kfold(training.data[,colnames(training.data) %in% c("topic", c(1:10), fr.10)])


#=============================================================================
# RUN SAME FEATURE SET WITH NORMALISED FREQUENCIES
#=============================================================================

# normalise frequencies by dividing by max. frequency of that term
training.norm <- cbind(training.data[,1:11],
                       sweep(training.data[,-(1:11)], 2, sapply(training.data[,-(1:11)], max), '/'))

kfold.fr10.norm <- run.kfold(training.norm[,colnames(training.norm) %in% c("topic", c(1:10), fr.10)])


#=============================================================================
# RUN SAME FEATURE SET WITH BINARY FREQUENCIES
#=============================================================================

# convert to binary vector instead of frequencies
training.bin <- cbind(training.data[,1:11],
                      ceiling(training.data[,-(1:11)] / (training.data[,-(1:11)] + 1)))

kfold.fr10.bin <- run.kfold(training.bin[,colnames(training.bin) %in% c("topic", c(1:10), fr.10)])

kfold.classifiers <- rbind(cbind('features' = 'topic models + fr.10', 
                                 data.frame(t(kfold.fr10$perf))),
                           cbind('features' = 'topic models + fr.10, normalised', 
                                 data.frame(t(kfold.fr10.norm$perf))),
                           cbind('features' = 'topic models + fr.10, binary', 
                                 data.frame(t(kfold.fr10.bin$perf))))

write.csv(kfold.classifiers, "kfold.feature.selection.csv")

# fix final feature set
features <- c(fr.10, c(1:10))

# cut down training set to contain only final feature set
training.data <- training.data[,colnames(training.data) %in% c("topic", c(1:10), fr.10)]

# column names can't be numeric - random forest classifier will fail
colnames(training.data)[2:11] <- c('v1', 'v2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8', 'v9', 'v10')


#=============================================================================
# RUN SELECTED FEATURE SET WITH CANDIDATE CLASSIFIERS
#=============================================================================

kfold.rf <- run.kfold(training.data, classifier = randomForest)
kfold.nb <- run.kfold(training.data, classifier = naiveBayes)

#=============================================================================
# TUNE SVM PARAMETERS
#=============================================================================

# extra function for tuning SVM paramaters (uses linear kernel by default)
tune.kfold.svm <- function(dtm, k = 10, c = 1) {
  
  # sort data into random order
  dtm <- dtm[sample(nrow(dtm), replace = FALSE), ]
  
  # create vector containing fold number
  folds <- rep(1:k, ceiling(nrow(dtm) / k))[1:nrow(dtm)]
  
  # initialise data frames to hold predicted & expected topics
  prediction <- data.frame()
  expected <- data.frame()
  
  # iterate over all k folds, each time reserving one to evaluate and using the rest to train
  for (i in 1:k){
    
    # split data into test & training sets
    trainingset <- dtm[folds != i,]
    
    # clean training set - remove any empty rows or columns
    trainingset <- trainingset[rowSums(trainingset[,-1]) > 0, ]
    trainingset <- trainingset[,!(colnames(trainingset) %in% colnames(trainingset[,-1])[colSums(trainingset[,-1]) == 0])]
    
    testset <- dtm[folds == i,]
    
    # run classifier on the training data
    model <- svm(topic ~ ., data = trainingset, kernel = "linear", cost = c)
    
    # use classifier to predict classes on test set (excluding actual topic)
    temp <- as.data.frame(predict(model, newdata = testset[,-1]))
    
    # add this iteration's predictions to 'prediction' data frame
    prediction <- rbind(prediction, temp)
    
    # add correct classifications to 'expected' data frame
    expected <- rbind(expected, as.data.frame(testset[, 1]))
  }
  
  result <- cbind(expected, prediction, folds, prediction == expected)
  colnames(result) <- c("expected", "predicted", "fold", "correct")
  
  perf <- round(assess.performance(result)*100,1)
  
  m <- round(mean(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct)))*100, 1)
  s <- round(sd(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct))), 3)
  
  z <- c(length(colnames(dtm)) - 1, perf[11:12,3:4], m, s)
  names(z) <- c("n.features", "macro-f", "micro-f", "macro-a", "micro-a", "pf-mean", "pf-sd")
  list("call" = model$call, "perf" = z, "result" = result)
}

# experiment with changing svm parameters
kfold.svm.linear <- tune.kfold.svm(training.data)
kfold.svm.linear.5 <- tune.kfold.svm(training.data, c = 0.5)
kfold.svm.linear.1 <- tune.kfold.svm(training.data, c = 0.1)


#=============================================================================
# TUNE RF PARAMETERS
#=============================================================================

tune.kfold.rf <- function(dtm, k = 10, m = 5) {
  
  # sort data into random order
  dtm <- dtm[sample(nrow(dtm), replace = FALSE), ]
  
  # create vector containing fold number
  folds <- rep(1:k, ceiling(nrow(dtm) / k))[1:nrow(dtm)]
  
  # initialise data frames to hold predicted & expected topics
  prediction <- data.frame()
  expected <- data.frame()
  
  # iterate over all k folds, each time reserving one to evaluate and using the rest to train
  for (i in 1:k){
    
    # split data into test & training sets
    trainingset <- dtm[folds != i,]
    
    # clean training set - remove any empty rows or columns
    trainingset <- trainingset[rowSums(trainingset[,-1]) > 0, ]
    trainingset <- trainingset[,!(colnames(trainingset) %in% colnames(trainingset[,-1])[colSums(trainingset[,-1]) == 0])]
    
    testset <- dtm[folds == i,]
    
    # run classifier on the training data
    model <- randomForest(topic ~ ., data = trainingset, mtry = m)
    
    # use classifier to predict classes on test set (excluding actual topic)
    temp <- as.data.frame(predict(model, newdata = testset[,-1]))
    
    # add this iteration's predictions to 'prediction' data frame
    prediction <- rbind(prediction, temp)
    
    # add correct classifications to 'expected' data frame
    expected <- rbind(expected, as.data.frame(testset[, 1]))
  }
  
  result <- cbind(expected, prediction, folds, prediction == expected)
  colnames(result) <- c("expected", "predicted", "fold", "correct")
  
  perf <- round(assess.performance(result)*100,1)
  
  m <- round(mean(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct)))*100, 1)
  s <- round(sd(table(result$fold, result$correct)[,2]/rowSums(table(result$fold, result$correct))), 3)
  
  z <- c(length(colnames(dtm)) - 1, perf[11:12,3:4], m, s)
  names(z) <- c("n.features", "macro-f", "micro-f", "macro-a", "micro-a", "pf-mean", "pf-sd")
  list("call" = model$call, "perf" = z, "result" = result)
}

kfold.rf.m4 <- tune.kfold.rf(training.data, m = 4)
kfold.rf.m6 <- tune.kfold.rf(training.data, m = 6)


kfold.classifiers <- rbind(cbind('classifier' = 'SVM', data.frame(t(kfold.fr10$perf))),
                           cbind('classifier' = 'Random Forest', data.frame(t(kfold.rf$perf))),
                           cbind('classifier' = 'Naive Bayes', data.frame(t(kfold.nb$perf))),
                           cbind('classifier' = 'SVM (linear kernel)', data.frame(t(kfold.svm.linear$perf))),
                           cbind('classifier' = 'SVM (linear kernel, cost 0.5)', data.frame(t(kfold.svm.linear.5$perf))),
                           cbind('classifier' = 'SVM (linear kernel, cost 0.1)', data.frame(t(kfold.svm.linear.1$perf))),
                           cbind('classifier' = 'RF (mtry = 4)', data.frame(t(kfold.rf.m4$perf))),
                           cbind('classifier' = 'RF (mtry = 6)', data.frame(t(kfold.rf.m6$perf))))
colnames(kfold.classifiers)[1] <- "classifier"

write.csv(kfold.classifiers, file = "kfold.classifier.selection.csv")


#=============================================================================
# TRAIN FINAL CLASSIFIER OVER WHOLE TRAINING SET & PREDICT ON TEST SET
#=============================================================================

# extract training set
test.data <- all.data[all.data$purpose == "test", -c(1,3)]

# convert column names to match those of the training set
colnames(test.data)[2:11] <- c('v1', 'v2', 'v3', 'v4', 'v5', 'v6', 'v7', 'v8', 'v9', 'v10')

# trim test data to contain only columns of interest
test.data <- test.data[, colnames(test.data) %in% colnames(training.data)]

# train model and make predictions
model <- randomForest(topic ~ ., data = training.data, mtry = 6)
prediction <- predict(model, newdata = test.data[,-1])
result <- as.data.frame(cbind("expected" = as.character(test.data[,1]), "predicted" = as.character(prediction)))
performance <- assess.performance(result)

performance <- round(performance*100, 1)
performance <- cbind(rownames(performance), performance)
performance[11:12,1] <- c("Macro-average", "Micro-average")
colnames(performance) <- c("topic", "recall", "precision", "fmeasure", "accuracy")
write.csv(performance, file = "classifier-performance.csv")

# calculate correlation between performance & topic size
cor(as.numeric(table(test.data$topic)[-1]), as.numeric(performance[1:10,2]))     # recall: .823
cor(as.numeric(table(test.data$topic)[-1]), as.numeric(performance[1:10,3]))     # precision: .878
cor(as.numeric(table(test.data$topic)[-1]), as.numeric(performance[1:10,4]))     # f-measure: .891
cor(as.numeric(table(test.data$topic)[-1]), as.numeric(performance[1:10,5]))     # accuracy: -.756


# output confusion matrix to .csv
cm <- as.data.frame.matrix(table("expected" = result$expected, "predicted" = result$predicted))
cm <- cbind.data.frame("expected" = rownames(cm), cm, stringsAsFactors = F)
cm[cm == "_other"] <- "other"

write.csv(cm, file = "cm.csv")

#=============================================================================
# CLUSTERING
#=============================================================================

# strip out topics from data, retain only unique records
all.data  <- unique(all.data[, -(2:3)])

# strip out all but selected features
pid <- all.data[,1]
all.data <- all.data[, colnames(all.data) %in% c(c(1:10), fr.10)]

# get distance matrix
dist <- dist(all.data)

# get all original topic tags from data (not just the top 10)
all.topics <- gsub("topic.", "", colnames(reuters)[4:138], )
org.topics <- get.topics(reuters, all.topics)

# function to label clusters according to main topic picked up
label.clusters <- function(clusters, topics) {
  
  # match clusters to original topic labels via PID
  matched <- merge(topics, clusters, by = "pid", all.x = T)
  
  # find dominant topic in each cluster, excluding 'other'
  clust.cm <- table("expected" = matched$topic, "cluster" = matched$cluster)
  c <- cbind("cluster" = colnames(clust.cm), 
             "predicted" = rownames(clust.cm[-1,])[apply(clust.cm[-1,],2,which.max)])
  
  # largest cluster will be 'noise' cluster - label this as '_other'
  c[c[,1] == names(colSums(clust.cm)[which.max(colSums(clust.cm))]),2] <- "_other"
  
  # return expected & predicted topics per document
  colnames(c) <- c("cluster", "clust.topic")
  z <- merge(matched, c, by = "cluster", all.x = T)
  colnames(z) <- c("cluster", "pid", "expected", "predicted")
  z
}


#=============================================================================
# PAM (PARTITIONING AROUND K-MEDOIDS)
#=============================================================================

pam10 <- pam(all.data, k = 10)

# output silhouette to pdf
pdf('pam10-silhouette.pdf');
plot(silhouette(pam10));
dev.off()

# assess performance of clustering against all 135 original topic tags
pam.clusters <- cbind("pid" = pid, "cluster" = pam10$cluster)
pam.clusters <- label.clusters(pam.clusters, org.topics)
pam.perf <- assess.performance(pam.clusters)

# save an abridged version, only including clusters with predictions
pam.abr <- cbind("topic" = rownames(pam.perf[pam.perf[,1] > 0, ]),
                 round(pam.perf[pam.perf[,1] > 0, ]*100, 1),
                 "nexp" = c(table(pam.clusters$expected)[names(table(pam.clusters$expected)) %in% rownames(pam.perf[pam.perf[,1] > 0, ])],0,0),
                 "npred" = c(table(pam.clusters$predicted)[names(table(pam.clusters$predicted)) %in% rownames(pam.perf[pam.perf[,1] > 0, ])],0,0))
write.csv(pam.abr, file = "pam-performance.csv")

#=============================================================================
# HIERARCHICAL CLUSTER ANALYSIS
#=============================================================================

hc <- hclust(dist)

# plot hierarchical clustering dendrogram
pdf('hclust.pdf')
plot(hc, labels = F, xlab = "")
dev.off()


# create confusion matrices & output to .csv
hclust.10.cm <- as.data.frame.matrix(table(merge(topic.list, cbind("pid" = pid, "cluster" = cutree(hc, k = 10)),
                                                 by = "pid", all.x = T)[,3:2]))
hclust.10.cm <- cbind.data.frame("cluster" = rownames(hclust.10.cm), hclust.10.cm, stringsAsFactors = F)
colnames(hclust.10.cm)[2] <- "other"
write.csv(hclust.10.cm, file = "hclust-10-cm.csv")

hclust.24.cm <- as.data.frame.matrix(table(merge(topic.list, cbind("pid" = pid, "cluster" = cutree(hc, h = 24)),
                                                 by = "pid", all.x = T)[,3:2]))
hclust.24.cm <- cbind.data.frame("cluster" = rownames(hclust.24.cm), hclust.24.cm, stringsAsFactors = F)
colnames(hclust.24.cm)[2] <- "other"
write.csv(hclust.24.cm, file = "hclust-24-cm.csv")

hclust.150.cm <- as.data.frame.matrix(table(merge(topic.list, cbind("pid" = pid, "cluster" = cutree(hc, k = 150)),
                                                  by = "pid", all.x = T)[,3:2]))
hclust.150.cm <- cbind.data.frame("cluster" = rownames(hclust.150.cm), hclust.150.cm, stringsAsFactors = F)
colnames(hclust.150.cm)[2] <- "other"
write.csv(hclust.150.cm, file = "hclust-150-cm.csv")


# plot silhouette measures
hclust.10 <- silhouette(cutree(hc, k = 10), dist)
hclust.24 <- silhouette(cutree(hc, h = 24), dist)
hclust.150 <- silhouette(cutree(hc, k = 150), dist)


pdf('hclust10-silhouette.pdf')
plot(hclust.10, do.n.k = F, do.clus.stat = F, main = "")
dev.off()

pdf('hclust24-silhouette.pdf')
plot(hclust.24, do.n.k = F, do.clus.stat = F, main = "")
dev.off()

pdf('hclust150-silhouette.pdf')
plot(hclust.150, do.n.k = F, do.clus.stat = F, main = "")
dev.off()


# plot per-class silhouette measure without maximum class
pdf('hclust10-plot.pdf')
plot(summary(hclust.10)$clus.avg.widths, 
     summary(hclust.10)$clus.sizes, 
     ylim = c(0, max(summary(hclust.10)$clus.sizes[-which.max(summary(hclust.10)$clus.sizes)])), 
     pch = 16, ylab = "Cluster size", xlab = "Cluster silhouette measure (10 clusters)", cex = 2, oma = c(1,1,0,0))
dev.off()

pdf('hclust24-plot.pdf')
plot(summary(hclust.24)$clus.avg.widths, 
     summary(hclust.24)$clus.sizes, 
     ylim = c(0, max(summary(hclust.24)$clus.sizes[-which.max(summary(hclust.24)$clus.sizes)])), 
     pch = 16, ylab = "Cluster size", xlab = "Cluster silhouette measure (clusters at height 24)", cex = 2, oma = c(1,1,0,0))
dev.off()

pdf('hclust150-plot.pdf')
plot(summary(hclust.150)$clus.avg.widths, 
     summary(hclust.150)$clus.sizes, 
     ylim = c(0, max(summary(hclust.150)$clus.sizes[-which.max(summary(hclust.150)$clus.sizes)])), 
     pch = 16, ylab = "Cluster size", xlab = "Cluster silhouette measure (150 clusters)", cex = 2, oma = c(1,1,0,0))
dev.off()

# assess performance of clustering against all 135 original topic tags
hc10.clusters <- cbind("pid" = pid, "cluster" = cutree(hc, k = 10))
hc10.clusters <- label.clusters(hc10.clusters, org.topics)
hc10.perf <- assess.performance(hc10.clusters)

# save an abridged version, only including clusters with predictions
hc10.abr <- cbind("topic" = rownames(hc10.perf[hc10.perf[,1] > 0, ]),
                  round(hc10.perf[hc10.perf[,1] > 0, ]*100, 1),
                  "nexp" = c(table(hc10.clusters$expected)[names(table(hc10.clusters$expected)) %in% rownames(hc10.perf[hc10.perf[,1] > 0, ])],0,0),
                  "npred" = c(table(hc10.clusters$predicted)[names(table(hc10.clusters$predicted)) %in% rownames(hc10.perf[hc10.perf[,1] > 0, ])],0,0))
write.csv(hc10.abr, file = "hc10-performance.csv")


# assess performance of clustering against all 135 original topic tags
hc24.clusters <- cbind("pid" = pid, "cluster" = cutree(hc, h = 24))
hc24.clusters <- label.clusters(hc24.clusters, org.topics)
hc24.perf <- assess.performance(hc24.clusters)

# save an abridged version, only including clusters with predictions
hc24.abr <- cbind("topic" = rownames(hc24.perf[hc24.perf[,1] > 0, ]),
                  round(hc24.perf[hc24.perf[,1] > 0, ]*100, 1),
                  "nexp" = c(table(hc24.clusters$expected)[names(table(hc24.clusters$expected)) %in% rownames(hc24.perf[hc24.perf[,1] > 0, ])],0,0),
                  "npred" = c(table(hc24.clusters$predicted)[names(table(hc24.clusters$predicted)) %in% rownames(hc24.perf[hc24.perf[,1] > 0, ])],0,0))
write.csv(hc24.abr, file = "hc24-performance.csv")



# assess performance of clustering against all 135 original topic tags
hc150.clusters <- cbind("pid" = pid, "cluster" = cutree(hc, k = 150))
hc150.clusters <- label.clusters(hc150.clusters, org.topics)
hc150.perf <- assess.performance(hc150.clusters)

# save an abridged version, only including clusters with predictions
hc150.abr <- cbind("topic" = rownames(hc150.perf[hc150.perf[,1] > 0, ]),
                   round(hc150.perf[hc150.perf[,1] > 0, ]*100, 1),
                   "nexp" = c(table(hc150.clusters$expected)[names(table(hc150.clusters$expected)) %in% rownames(hc150.perf[hc150.perf[,1] > 0, ])],0,0),
                   "npred" = c(table(hc150.clusters$predicted)[names(table(hc150.clusters$predicted)) %in% rownames(hc150.perf[hc150.perf[,1] > 0, ])],0,0))
write.csv(hc150.abr, file = "hc150-performance.csv")

#=============================================================================
# DBSCAN
#=============================================================================

db <- dbscan(all.data, eps = 0.5, MinPts = 50, method = "raw")

dbclust <- silhouette(db$cluster, dist)

pdf('dbclust-silhouette.pdf')
plot(dbclust, do.n.k = F, do.clus.stat = F, main = "")
dev.off()

# create confusion matrix & output to .csv
dbclusts <- merge(org.topics, cbind("pid" = pid, "cluster" = db$cluster, by = "pid", all.x = T))
dbclust.cm <- as.data.frame.matrix(table(dbclusts[,3:2]))
dbclust.cm <- cbind.data.frame("cluster" = rownames(dbclust.cm), dbclust.cm, stringsAsFactors = F)
colnames(dbclust.cm)[2] <- "other"
write.csv(dbclust.cm, file = "dbclust-cm.csv")


# assess performance of clustering against all 135 original topic tags
db.clusters <- cbind("pid" = pid, "cluster" = db$cluster)
db.clusters <- label.clusters(db.clusters, org.topics)
db.perf <- assess.performance(db.clusters)

# save an abridged version, only including clusters with predictions
db.abr <- cbind("topic" = rownames(db.perf[db.perf[,1] > 0, ]),
                round(db.perf[db.perf[,1] > 0, ]*100, 1),
                "nexp" = c(table(db.clusters$expected)[names(table(db.clusters$expected)) %in% rownames(db.perf[db.perf[,1] > 0, ])],0,0),
                "npred" = c(table(db.clusters$predicted)[names(table(db.clusters$predicted)) %in% rownames(db.perf[db.perf[,1] > 0, ])],0,0))

write.csv(db.abr, file = "db-performance.csv")

