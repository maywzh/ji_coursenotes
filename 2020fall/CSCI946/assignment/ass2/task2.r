require(topicmodels)
library(tm.corpus.Reuters21578)
library(wordcloud)
library(lda)
library(ggplot2)
library(reshape2)

data(Reuters21578)

#Summarize the data
summary(Reuters21578)

#Pre-Processing
pre_process_reuters <- tm_map(Reuters21578,  content_transformer(tolower))
pre_process_reuters <- tm_map(pre_process_reuters, stripWhitespace)
pre_process_reuters <- tm_map(pre_process_reuters, removeWords, stopwords("english"))
pre_process_reuters <- tm_map(pre_process_reuters, removePunctuation)
pre_process_reuters <- tm_map(pre_process_reuters, removeNumbers)
pre_process_reuters <- tm_map(pre_process_reuters,stemDocument)

#document term matrix - BOW
bowdtm <- DocumentTermMatrix(pre_process_reuters)

#document term matrix TF-IDF
tfidfdtm <- DocumentTermMatrix(pre_process_reuters, control = list(weighting = weightTfIdf))

#To reduce the dimension of the bowdtm, we can remove the less frequent terms such that the sparsity is less than 0.95
review_dtm = removeSparseTerms(tfidfdtm, 0.99)

#frequency - Simple word cloud
x <- findFreqTerms(bowdtm,15)

#word cloud
freq = data.frame(sort(colSums(as.matrix(review_dtm)), decreasing=TRUE))
wordcloud(rownames(freq), freq[,1], max.words=50, colors=brewer.pal(1, "Dark2"))

#LDA
# due to vocabulary pruning, we have empty rows in our bowdtm 
#LDA does not like this. So we remove those docs from the bowdtm and the metadata
bowdtm <- bowdtm[slam::row_sums(bowdtm) > 0, ]

# k = n_topics
k <- 20

# compute the LDA model, inference via 25 iterations of Gibbs sampling
result <- LDA(bowdtm, k, method="Gibbs", control=list(iter = 25, verbose = 25, alpha = 0.1))
result

#Let's take a look at the 10 most likely terms within the term probabilities beta of the inferred topics.
terms(result, 10)

#five most likely terms of each topic to a string
top5termsPerTopic <- terms(result, 5)
nameOfTopics <- apply(top5termsPerTopic, 2, paste, collapse=" ")

# have a look a some of the results (posterior distributions)
tmposterior <- posterior(result)

# format of the resulting object
attributes(tmposterior)

#Let us first take a look at the contents of eight sample documents:
examples <- c(2, 100, 200, 400, 800, 1000, 1200, 1400)
lapply(pre_process_reuters[examples], as.character)

theta <- tmposterior$topics
N <- length(examples)

# get topic proportions form example documents
tpExamples <- theta[examples,]
colnames(tpExamples) <- nameOfTopics
vizDataFrame <- melt(cbind(data.frame(tpExamples), document = factor(1:N)), variable.name = "topic", id.vars = "document")  
vizDataFrame


#ggplot
ggplot(data = vizDataFrame, aes(topic, value, fill = document), ylab = "proportion") + 
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +  
  coord_flip() +
  facet_wrap(~ document, ncol = N)

