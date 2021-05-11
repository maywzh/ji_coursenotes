# Defending Draft



## Introduction

### self-intro

Hi, Everyone, My name is Wangzhihui Mei, and My supervisor is Professor Zhifeng Wang. The research topic I'm going to defend today is Research on High School Math Exercise Recommendation Based on Graph Neural Network. 



### research background - existing problems

The background of the research is Chinese high school math exercise recommendation system, which has following existing problems.



1. The current exercise recommendation are based on class-level recommendation rather than personal-level.

   This means that teachers tend to recommend exercises for class units based on their professional experience. The quality of the recommendations depends on the level of expertise of the educator. Also the uneven level of knowledge of students can cause certain problems.

2. The Math exercise corpuses are usually too disorganized to obtain appropriate exercise.

   The exercises often lack relevant knowledge labels, making it difficult to practice in a planned manner. 



3. The evaluation of knowledge mastery proficiency is difficult.

   Currently, it is very difficult to assess the fine-grained knowledge level of all students at the time and cost of assessing their knowledge level.

4. We need solution to recommend appropriate exercises according to the knowledge mastery. Therefore deep learning techniques are used to solve this problem.



### relative works

There are several relative works about this topic. 

The current mainstream knowledge assessment models are divided into two types: cognitive diagnosis and knowledge tracking. As a traditional knowledge level assessment model, cognitive diagnosis usually assesses students' learning status only based on their test scores at a certain point in time, which is a relatively static knowledge level assessment. Knowledge tracking, on the other hand, is based on past answer histories and can dynamically track students' knowledge levels.

In my study, I mainly adopt the knowledge tracking approach to dynamically track students' real-time knowledge mastery and recommend exercises accordingly.





### reserach objectives

Thus the study has three main objectives:

1. Exercise knowledge labelling
2. Knowledge tracing
3. Exercise recommendation



### research contributions

There are three main contributions of my research:

1. proposed a  multi-knowledge point labeling algorithm for high school mathematics exercises based on bidirectional LSTM (Bi-LSTM) and graph convolutional neural network (GCN)
2. proposed an improved graph-based DKVMN knowledge tracing model to evaluate the knowledge proficiency of students.
3. proposed a mathematical exercise recommendation model based on Matching-Ranking stages



## Model Description

### Exercise Knowledge Labelling

Now let me instroduce the design and architecture of the proposed models.

In the first Exercise Knowledge Labelling model, There are two parts in the module. The first one is the text mining representation and the second one is the classifiers generato

In the text mining part, we have pre-processing, embedding, bi-lstm and attention layers to generate the exercise text representation vector. 

In the classifiers generator part, I use GCN to generate knowledge classifier. Each vertex in the GCN is one knowledge point, the correlation matrix of graph vertexes is the based on the co-occurence of knowledge points. The system is in end-to-end training mode. The generated classifier is then multiplied with the text representing vector to get the predicted label vector.

The knowledge tracing problem can be described as that a student answers a sequence of questions and predict whether the tth question will be answered correctly or not based on the responses to the previous t-1 questions.

Then, in the second Knowledge Tracing model, it has a key matrix to store the knowledge point representation and a value matrix to store the knowledge point mastery, with two steps: reading and modifying. In the reading step, the embedding vector of the exercise is weighted with the key matrix to obtain the weight matrix w, wi represents the relevant weight of the exercise for the ith knowledge point. wi is weighted and calculated with Mv to obtain the mastery of the current exercise, which can be used to The probability of correctness of the exercise can be predicted. In the writing step, the mastery of the exercise Mv is corrected according to the current response, and the relationship between the knowledge points is captured by the graph propagation mechanism at the end

Finally, The exercise recommendation module. It has two phases: Matching and Ranking. The Matching Phase filter out the candidate  exercises recommendation set. The Ranking Phase sorted the exercises in the candidate set with knowledge tracing model and generated final recommendation set. The matching phase has mulitiplex matching and multiplex merging stages. The multiplex matching is consisted of several matching strategies such as CF、Statiscal based  and user preference based. It can filter out exercised reffered by similar students, and popular exercises and user's favorite exercises. In the merging layer, the model deduplicate the set and sort the exercises with weighted sum algorithm. Then each exercise in the candidate exercise set in imported into the kt model to get the predicting correctness. Sort them in descending order of predicting correctness. Get the final ranked recommend exercise set.



In experiment design, for the exercise knowledge labelling, I compared with several baseline models and checked the multi-classification report of the proposed model. For the kt, we compared it with other baseline model in public datasets. For exercise recommendation, i compared it with cf and dkt algorithm. adapted kt dataset for testing. and check if the selected exercise is in the final recommendation.



Now lets see the result, The result showed that my model achieved better performance than baseline model and when the occurrence of knowledge point decrese the performance of each model degrade. For the knowledge tracing model. the proposed model achieved better performance in AUC metrics.



In the recommendation system, Compared with CF and random recommendation, the model achieved better performance. when the threshold $\tau$ is closer to 0.5 the performence is better.



All right, that's all, I would like to thank my supervisor for his guidance and assistance. Hope for your criticism and correction.



 

   



