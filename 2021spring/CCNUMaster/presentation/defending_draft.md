# Defending Draft

Hi, Everyone, My name is Wangzhihui Mei, and My supervisor is Professor Zhifeng Wang. Today the research topic I'm going to defend today is Research on High School Math Exercise Recommendation Based on Graph Neural Network. 



The background of the research is Chinese high school math exercise recommendation system, which has following existing problems.



1. The current exercise recommendation are based on class-level recommendation rather than personal-level.
2. The Math exercise corpuses are usually too disorganized to obtain appropriate exercise.
3. The evaluation of knowledge mastery proficiency is difficult.
4. We need solution to recommend appropriate exercises according to the knowledge mastery.



Thus the study has three main points at its core:

1. Exercise knowledge labelling
2. Knowledge tracing
3. Exercise recommendation



Now let me instroduce the design and architecture of the proposed models.

In the first Exercise Knowledge Labelling model, There are two parts in the module. The first one is the text mining representation and the second one is the classifiers generator. 

In the text mining part, we have pre-processing, embedding, bi-lstm and attention layers to generate the exercise text representation vector. 

In the classifiers generator part, I use GCN to generate knowledge  classifier. Each vertex in the GCN is one knowledge point, the correlation matrix of graph vertexes is the based on the co-occurence of knowledge points. The system is in end-to-end training mode. The generated classifier is then multiplied with the text representing vector to get the predicted label vector.



Then, in the second Knowledge Tracing model, I introduced Transformer architecture and Graph Attention network into it. The exercise id, related knowledge points and positional tag are fed into the GAT and embedded into question embedding vector $E$. The embedding vector is then inputted into the Knowledge Tracing Model. We can see from the figure, the exercise and answer embedding vector are input of the encoder consists of several transformer blocks. In each block a masked multi-hgead attetion with upper triangular mask and a feed forward network are employed. We use this transformer block to extract the inplicit knowledge proficiency representation vector $S$. The the $S$ vector are inputted into the decoder module as the keys and values. The next question embedding vector is inputted into the decoder vector as the query. Finally, the decoder outputted the predicting of the correctness of the next question.



Finally, The exercise recommendation module. It has two phases: Matching and Ranking. The Matching Phase filter out the candidate  exercises recommendation set. The Ranking Phase sorted the exercises in the candidate set with knowledge tracing model and generated final recommendation set. The matching phase has mulitiplex matching and multiplex merging stages. The multiplex matching is consisted of several matching strategies such as CF、Statiscal based  and user preference based. It can filter out exercised reffered by similar students, and popular exercises and user's favorite exercises. In the merging layer, the model deduplicate the set and sort the exercises with weighted sum algorithm. Then each exercise in the candidate exercise set in imported into the kt model to get the predicting correctness. Sort them in descending order of predicting correctness. Get the final ranked recommend exercise set.



In experiment design, for the exercise knowledge labelling, I compared with several baseline models and compared the performence with various occurrence frequency of knowledge point label $\tau$ . For the kt, we compared it with other baseline model in public datasets. For exercise recommendation, i compared it with cf and random algorithm. adapted kt dataset for testing. and check if the selected exercise is in the final recommendation.



Now lets see the result, The result showed that my model achieved better performance than baseline model and when the occurrence of knowledge point decrese the performance of each model degrade. For the knowledge tracing model. the proposed model achieved better performance in AUC metrics.



In the recommendation system, Compared with CF and random recommendation, the model achieved better performance. when the threshold $\tau$ is closer to 0.5 the performence is better.



 

   



