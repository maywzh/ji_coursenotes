# Personalized High School Math Exercises Recommendation based on Knowledge Graph Completion and Knowledge Tracing

## Introduction

In the context of the popularity of artificial intelligence technology, AI has become a trend in various industries. The theoretical breakthrough has brought about large-scale commercial applications and profoundly changed social development. 

When it comes to AI-education, although there are many deep learning and artificial intelligence solutions, there are not many projects that can be applied and implemented in practice. Most of the solutions are still in the conceptual stage or data collection stage, which is far from practical application. 

In recent years, domestic adaptive learning has begun to enter the field of vision of many people engaged in education training and education investment. There are more and more educational technology companies focusing on adaptive learning tools in the market. At the same time, many educational companies have begun to use adaptive learning as the main core function or main selling point of their products. The biggest advantage of adaptive education is that it can locate the knowledge loopholes of each student. The adaptive learning platform will guide the student to the next learning content and activities most suitable for him. When the student encounters a course that is too difficult or too low during the learning process, the difficulty of the course can be automatically adjusted. Teachers can also analyze the knowledge gaps of each student according to the learning status evaluation report provided by the system, and adjust the learning progress in real time to provide personalized teaching for each student. So in theory, adaptive learning is one of the potential feasible solutions to the problem of "teaching students in accordance with their aptitude" in online education. To make an practical adaptive learning system, I plan to adapted Knowledge Graph (KG) technique with knowledge completion and knowledge tracking in making such a recommendation system.

The key challenges include building one knowledge graph, performing knowledge completion and building recommendation model. 

In the education industry, AI technology is mainly used for the recommendation of teaching resources to teach students in accordance with their aptitude. However, the current AI-based teaching is still at a simple stage, and coarse-grained recommendation algorithms are used to push teaching resources in batches, causing a lot of burden. Compared with other methods, the knowledge graph can express the relationship between knowledge more widely and intuitively. The push based on knowledge graph can ensure better domain adaptability, knowledge granularity and construction automation.

However, the problem of missing ternary groups (i.e., missing links) is common in knowledge graphs. Because the size of missing ternary is usually large, it is costly to find these ternary manually. Therefore, researchers have designed the Knowledge Graph Completion task, which aims to automatically complete missing ternary groups through machine learning models. This task is also known as Link Prediction because it does not add new entities or relationships, but completes links between existing entities. The knowledge graph completion algorithm can make the knowledge graph more complete, which is currently a research hotspot in the field of artificial intelligence. It predicts the missing part of the triples, so that the knowledge graph becomes more complete. Based on the existing knowledge graph completion algorithm, combined with the particularity of education data, we optimized the model construction budget method. 

Knowledge Tracing is a technique for modeling a student's knowledge based on past answers to obtain a representation of the student's current knowledge state. In order to make personalized question recommendations based on student learning, knowledge tracing algorithms are needed to measure individual student learning, and in this paper we propose an improved knowledge tracing approach to better model the learning cognitive model for better performance.

First we build a knowledge map for high school mathematics education based on the existing dataset of public high school mathematics questions, and work at this stage includes entity extraction, relation extraction and attribute extraction, and knowledge fusion techniques. Then we try to use a variety of knowledge graph complementation techniques to complement the knowledge graph and propose an improved knowledge graph complementation algorithm, complete theoretical design, algorithm optimization and experimental validation, and analyze and compare with the existing knowledge complementation models.

Then we complete the design, optimization and experimental validation of the improved knowledge tracing algorithm for high school mathematics education knowledge, and compare it with existing Bayesian-based knowledge tracing and deep knowledge tracing models. And compare it with other cognitive model inference algorithms such as cognitive diagnostics.

Finally, a recommendation model for high school mathematics questions is implemented based on complementary knowledge mapping and knowledge tracing models. A high performance recommendation model based on the high school mathematics knowledge model is proposed to complete the theoretical justification, model optimization and experimental validation.
## High School Math

### Definitioin of Subject Knowledge 

Disciplines and knowledge are closely related to each other, so that disciplinary knowledge denotes the specific knowledge contained in a particular field of study. Disciplines are referred to in this study only for specific subjects in the field of education, such as mathematics, language, chemistry and so on. The first step is to learn how to make the best use of the knowledge that is available. The knowledge is obtained from practice, so after learning it, it can also be applied to social practice. Scientific knowledge is declarative because it can be expressed in a series of symbols, words and diagrams; it is also procedural because it can be arranged and learned according to a specific logical order in the process of concrete learning.

Mathematics is a science specializing in the study of the relationship between quantities and spatial forms, its symbolic system is more complete, the formula structure is clear and unique, text and images and other expressions of language is also more vivid and intuitive.

### Knowledge structure of High School Math

The knowledge that learners need to learn mostly comes from the summaries of the experiences of their predecessors in practical activities. The learning process is a process of cognitive learning of the summarized knowledge and continuous digestion, adjustment and reorganization of the knowledge structure, so as to build a more perfect and suitable knowledge structure, as well as a process of integration with innovative thinking. 20], so a good cognitive structure can promote the formation of knowledge structure, and a good knowledge structure can enrich the organization form of cognitive structure. Since the disciplinary knowledge structure consists of two parts: knowledge composition and knowledge dependency, we will analyze the disciplinary knowledge structure from these two aspects.

#### Knowledge composition

Knowledge composition refers to the organization of knowledge within a subject area, which mainly includes knowledge points, knowledge blocks and knowledge systems.

- knowledge point: A point of knowledge is the smallest constituent unit of the knowledge structure of a discipline and is used to represent specific concepts.
  propositions, formulas, etc.
- knowledge block: A knowledge block is a collection of one or more sets of knowledge points, also known as knowledge modules, in which knowledge blocks and knowledge blocks can be combined to form new knowledge modules, and a subset of knowledge blocks is called a knowledge sub-module
- knowledge body: a body of knowledge is a structured system that is a combination of all the pieces of knowledge in a particular subject area.

#### Knowledge Relation

Knowledge relations represent the connections between knowledge points (or between knowledge blocks and knowledge chunks) in the discipline knowledge structure. It is through these connections that different knowledge points can be formed into knowledge blocks, and different knowledge blocks can be combined to form the whole disciplinary network knowledge structure system. There are many different kinds of knowledge relationships, so that different definitions of knowledge relationships lead to different knowledge structures. Therefore, in order to unify the definition of knowledge relations, we divided them into general relations and special relations based on the general and special characteristics of discipline knowledge structure. The special relationships represent the unique knowledge relationships of a particular discipline, while the universal relationships represent the general relationships of any discipline. Secondly, according to the demands of knowledge mapping research, we divide universal relations into six kinds of knowledge relations: synonymous, fraternal, antecedent, consequent, inclusive and antagonistic; and special relations into four kinds of knowledge relations: detailed, transformative, causal and correlative.

- tautology: Expresses the relationship between two points of knowledge that have the same meaning as what is being described, e.g. regular and equilateral triangles.
- fraternity: Expresses the relationship between two knowledge points that have the same parent class

- predecessor: It means that you need to finish learning knowledge point A before learning knowledge point B, that is, A → B is a precursor relationship.
- successor: denotes the inverse of the antecedent relationship, i.e., B→A is the successor relationship.
- containment: Indicates that knowledge point B is included in the definition of knowledge point A, i.e., A → B is an inclusion relationship.
- antagonism: From a certain point of view, knowledge point A is incompatible with knowledge point B, i.e. A↔ B is an antagonistic relationship
-  refinement: A grammatical analysis of the definition of knowledge point A leads to knowledge point B, where A↔ B is a detailed relationship
- transformation: denotes that knowledge point A and knowledge point B can be transformed to each other under certain conditions, i.e., A↔ B is a transformation relationship.
- causation: denotes that knowledge point A can be deduced from knowledge point B as a known condition, i.e., A↔B is a causal relationship
- relation: Indicates that there is a relationship between the definitions of Knowledge Point A and Knowledge Point B, but the relationship is not explicitly specified, i.e., A↔ B are correlated.

In the process of constructing the discipline knowledge structure, firstly, we need to analyze the current discipline knowledge content, teaching objectives, teaching objects, teaching strategies and discipline characteristics in detail; secondly, we divide the whole discipline knowledge system into several knowledge modules, and then we divide each knowledge module into several knowledge points; finally, with reference to the above ten kinds of knowledge relationships and the knowledge relationships extracted from data sources, we can determine and establish the relationships between knowledge modules and knowledge modules, between knowledge modules and knowledge points, and between knowledge points and knowledge points, so as to form a complete discipline knowledge system structure.



### The property of High School Math

Mathematics is a science that specializes in the relationship between quantity and spatial form. Its symbol system is more complete, the formula structure is clear and unique, and the language of expression such as words and images is more vivid and intuitive. The knowledge structure of senior secondary mathematics is a more logical and systematic knowledge system organized on the basis of the knowledge structure of junior secondary mathematics. This is because learning for any discipline needs to be based on the existing cognitive structure in order to progressively effective learning and skills training, so in the process of learning high school mathematics, you need to have a solid foundation of junior high school mathematics discipline knowledge. In the past few years, there have been a number of cases in which the students have been able to learn from each other.

- Highly abstract

  Mathematics has a high degree of abstraction, because the discipline's knowledge system is built using many abstract knowledge concepts, and with the help of these concepts and knowledge to learn and expand thinking, forming new abstract conceptual knowledge. The abstraction of mathematics is reflected in the object is not concerned with the introduction of specific content, only the number of relationships between the spatial form. Therefore, abstraction in mathematics is different from abstraction in other disciplines in terms of both object and degree. There are also some differences between mathematics and the natural sciences, because in mathematics the accuracy of calculations, proofs, and inferences can only be verified using rigorous logical methods and cannot be tested by repetitive experiments, whereas in the natural sciences the verification is the opposite.

- strict logic

  The discipline of mathematics is very logical because any conclusion reached in mathematics requires rigorous logical reasoning and rigorous proof in order to be considered reasonable. However, mathematics is not the only discipline that possesses rigorous logic; other natural science studies of reasoning and proof must also possess a certain degree of logic. In mathematics, not all conclusions reached after reasoning and proof can be applied in practice, because many mathematical models are developed and mathematical conclusions drawn under ideal circumstances.

- Broad applicability

  Mathematics is an important means and tool for us to participate in practical social activities or scientific research, and the study of mathematics is indispensable in all walks of life and in all areas of society. Therefore, mathematics has a wide range of applications and has become an important basis for the development of modern science.


## Knowledge Graph
