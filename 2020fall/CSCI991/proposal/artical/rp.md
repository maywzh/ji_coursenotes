## 0. Research Title 
Personalized High School Math Exercises Recommendation based on Knowledge Graph Completion and Knowledge Tracing

## 1. Research Content
### a. Please describe research problems and key challenges to be addressed in the research
In the context of the popularity of artificial intelligence technology, AI has become a trend in various industries. The theoretical breakthrough has brought about large-scale commercial applications and profoundly changed social development. 

When it comes to AI-education, although there are many deep learning and artificial intelligence solutions, there are not many projects that can be applied and implemented in practice. Most of the solutions are still in the conceptual stage or data collection stage, which is far from practical application. 

In recent years, domestic adaptive learning has begun to enter the field of vision of many people engaged in education training and education investment. There are more and more educational technology companies focusing on adaptive learning tools in the market. At the same time, many educational companies have begun to use adaptive learning as the main core function or main selling point of their products. The biggest advantage of adaptive education is that it can locate the knowledge loopholes of each student. The adaptive learning platform will guide the student to the next learning content and activities most suitable for him. When the student encounters a course that is too difficult or too low during the learning process, the difficulty of the course can be automatically adjusted. Teachers can also analyze the knowledge gaps of each student according to the learning status evaluation report provided by the system, and adjust the learning progress in real time to provide personalized teaching for each student. So in theory, adaptive learning is one of the potential feasible solutions to the problem of "teaching students in accordance with their aptitude" in online education. To make an practical adaptive learning system, I plan to adapted Knowledge Graph (KG) technique with knowledge completion and knowledge tracking in making such a recommendation system.

The key challenges include building one knowledge graph, performing knowledge completion and building recommendation model. 


### b. Please state the significance of the research
In the education industry, AI technology is mainly used for the recommendation of teaching resources to teach students in accordance with their aptitude. However, the current AI-based teaching is still at a simple stage, and coarse-grained recommendation algorithms are used to push teaching resources in batches, causing a lot of burden. Compared with other methods, the knowledge graph can express the relationship between knowledge more widely and intuitively. The push based on knowledge graph can ensure better domain adaptability, knowledge granularity and construction automation.

However, the problem of missing ternary groups (i.e., missing links) is common in knowledge graphs. Because the size of missing ternary is usually large, it is costly to find these ternary manually. Therefore, researchers have designed the Knowledge Graph Completion task, which aims to automatically complete missing ternary groups through machine learning models. This task is also known as Link Prediction because it does not add new entities or relationships, but completes links between existing entities. The knowledge graph completion algorithm can make the knowledge graph more complete, which is currently a research hotspot in the field of artificial intelligence. It predicts the missing part of the triples, so that the knowledge graph becomes more complete. Based on the existing knowledge graph completion algorithm, combined with the particularity of education data, we optimized the model construction budget method. 

Knowledge Tracing is a technique for modeling a student's knowledge based on past answers to obtain a representation of the student's current knowledge state. In order to make personalized question recommendations based on student learning, knowledge tracing algorithms are needed to measure individual student learning, and in this paper we propose an improved knowledge tracing approach to better model the learning cognitive model for better performance.

### c. Please describe research objectives and planned outcomes of the research

First we build a knowledge map for high school mathematics education based on the existing dataset of public high school mathematics questions, and work at this stage includes entity extraction, relation extraction and attribute extraction, and knowledge fusion techniques. Then we try to use a variety of knowledge graph complementation techniques to complement the knowledge graph and propose an improved knowledge graph complementation algorithm, complete theoretical design, algorithm optimization and experimental validation, and analyze and compare with the existing knowledge complementation models.

Then we complete the design, optimization and experimental validation of the improved knowledge tracing algorithm for high school mathematics education knowledge, and compare it with existing Bayesian-based knowledge tracing and deep knowledge tracing models. And compare it with other cognitive model inference algorithms such as cognitive diagnostics.

Finally, a recommendation model for high school mathematics questions is implemented based on complementary knowledge mapping and knowledge tracing models. A high performance recommendation model based on the high school mathematics knowledge model is proposed to complete the theoretical justification, model optimization and experimental validation.


## 2. Proposed Research Plan and Methodology
### a. Please describe research methods, the theories and strategies adopted in the research.
The first step is data collection, using either public datasets or crawling techniques to create experimental datasets for high school mathematics education. This is the basis for building an educational knowledge graph.
Combined with the principle of knowledge mapping, we provide an overview of knowledge mapping techniques based on the relevant literature to introduce the definition, principle, and representation of knowledge mapping. Then we conduct a literature review and theoretical introduction based on the basic techniques of knowledge graph such as knowledge extraction and storage. Then the specificity of high school education knowledge relative to general knowledge is analyzed to design the high school education knowledge map based on business. In this process, a performance comparison can be made with the general knowledge map, including both theoretical derivation and experimental validation.
Then the complementary algorithm for high school mathematics knowledge graph, we first conduct a literature review to introduce the common knowledge graph complementary techniques and the latest research results, based on the specificity of high school mathematics knowledge, combined with traditional machine algorithms, deep learning algorithms and knowledge inference to optimize the knowledge graph complementary model. The theoretical derivation and experimental validation are completed.
Then, the learning state detection work i.e., knowledge tracking model construction is carried out. Here we introduce the existing common knowledge tracking models, try to optimize the algorithm in theory, combine with the existing public database for model training and experimental validation.
Finally, based on the built high school mathematics education knowledge map, knowledge complement and knowledge tracing model, the recommendation algorithm optimized for test question recommendation is designed and compared with the existing recommendation algorithm, including theoretical justification and experimental validation. 



### b. Please explain the reasons why the methods, strategies, theories stated above are adopted, indicate the reference to the literature you have read so far and give your comments on the literature.  
Based on the techniques of knowledge graph construction, knowledge complementation and knowledge tracking, we build a closed loop from data source to learning state tracking, which, combined with model optimization for educational data, can achieve good results.
Knowledge Graphs (2020)
An early 2020 overview with many authors and very comprehensive content, suitable for a systematic approach to building a knowledge map of knowledge.
KG-BERT: BERT for Knowledge Graph Completion(2019)
Apply Bert's model to the task of completing the knowledge graph.
KG Completion
Learning Sequence Encoders for Temporal Knowledge Graph Completion
Differentiable Reasoning on Large Knowledge Bases and Natural Language
Diachronic Embedding for Temporal Knowledge Graph Completion
Commonsense Knowledge Base Completion with Structural and Semantic Context
KG-BERT: BERT for Knowledge Graph Completion
Knowledge Tracing

Knowledge tracing- Modeling the acquisition of procedural knowledge
Individualized Bayesian Knowledge Tracing Models
Deep Knowledge Tracing
Tracking Knowledge Proficiency of Students with Educational Priors


### c. Please describe how you intend to validate your solution/experimental results/simulations/procedures as well as your implementation plan (e.g., programming languages, software, hardware, etc.).
We use publicly available or crawled data to build high school mathematics-specific knowledge graphs, and a graph database is used to validate the knowledge graphs. And baseline comparisons are made with existing knowledge graphs.
Then we remove some of the edges and apply different knowledge complementation algorithms to compare the baseline performance based on the reasoning of edge recovery. It is also possible to derive multidimensional vectors for each map, which are input to the feedforward network to rank the different patterns. This allows performance comparison of the knowledge complementary models.
For the knowledge tracing part, a dataset of existing student answer records is used, different knowledge tracing algorithms are used to train the model and predict the scores of the answers, compare them with the true scores, vectorize the time series and knowledge points, and compare the baseline performance in different dimensions.
In terms of recommendation algorithms, offline experiments, user surveys and online experiments are used for performance comparison. The offline experiment trains the student learning data, trains the interest model, and evaluates the predicted results by pre-defined metrics. The user survey, on the other hand, is a kind of black box test that applies the recommendation algorithm and collects user feedback. The online experiment divides the users into groups, applies different recommendation algorithms, statistical data, and compares the performance of the algorithms.




### d. Please list the detailed timeline for the research

| Time periods | Contents                                                     |
| ------------ | ------------------------------------------------------------ |
| 9.20-10.15   | Literature review, research methodology design, completion of research proposal                     |
| 10.15-11.15  | Knowledge Tracking Algorithm Framework and Essay Writing |
| 11.15-11.28  | Mid-term report, mid-term defence                                      |
| 11.28-01.30 | Recommendation Algorithm Framework Establishment and Thesis Draft Writing |
| 02.01-03.10 | Revision and polishing of thesis, final draft, finishing work                       |
| 3.01-4.10    | Final pleadings                                       |



### e. Please describe the novelty of the research
1. The complementary aspects of the educational knowledge map based on high school mathematics, taking into account the peculiarities of educational data and improving the generic knowledge complementary model.
2. Designing special models to improve knowledge-tracing algorithms for gc, such as through feature engineering.
3. Designing improved learning path recommendation models that take into account the specificities of educational data
