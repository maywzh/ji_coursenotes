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



Then, in the second Knowledge Tracing model, I introduced Transformer architecture and Graph Attention network into it. The exercise id, related knowledge points and positional tag are fed into the GAT and embedded into question embedding vector. The vector is then inputted into the Encoder module. 

