## 学生行为

- Deep and Cross Network

- deep crossing 

  ![](https://i.loli.net/2021/04/01/hiIOEktCPe9zB1u.png )

- 本文是《Label-Specific Document Representation for Multi-Label [Text](https://flashgene.com/archives/tag/text) Classification》的阅读笔记，部分内容有删改。

   

  多标签文本分类旨在对给定文本分配多个相关类别的标签。在该篇论文中提出了一个label specific attention network(LSAN)来学习文档表示。LSAN能够利用标签的语义信息来确定标签和文档之间的语义联系来建立特定标签的文档表示。另外，自注意力机制适用于通过文档内容来学习特定标签的文档表示。为了将这两点很好地结合起来，我们设计了一个自适应的融合策略，有效地建立了多标签文档分类器。

   

  ### 任务

   

  文本分类是一个基本且核心的文本语义挖掘任务，其中包含了多分类任务和多标签任务，前者是对给定文本只分配一个类别标签，后者则是一篇文本属于不同的标签。

   

  多标签文本分类允许单文本同时存在多个标签。因此，标签间存在语义相关性。它们可能共享相同的文档子集。另外，文档内容可能很长，复杂的语义信息可能隐藏在冗余的内容中。还有就是，大多数文本只属于少数标签，而大量的“尾部标签”属于少量文本。因此，本文将主要解决以下三个问题：

   

   

  1. 

   

  1. 

   

  1. 

   

   

  ### 模型

   

  在多标签文本分类任务中，一篇文本可能包含多个标签，而且每个标签反映了文本的不同方面，因此，文本的整个语义可以由多个部分组成。基于以上观察，论文提出一个Label-Specific Attention Network （LSAN）模型，充分挖掘文本内容和标签内容，学习到文本表示。因此，模型利用标签文本，将标签文本编码成向量，像词向量一样。然后，论文设计了一个融合策略从两方面来抽取信息，并为每个文档构建标签特定的表示形式。结构如下图所示：

   

  ![img](data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9JzYwMCcgd2lkdGg9JzEzMzgnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZycgdmVyc2lvbj0nMS4xJy8+)![img](https://flashgene.com/wp-content/uploads/2020/04/fa722f1e278bc27ead4fc193a89e11af.png)

   

  从图中，我们可以看出LSAN包含两个部分，第一部分是从每个文本内容和标签内容中捕获文本内容与标签相关的信息；第二部分则是从这两方面自适应的提取信息。最后，分类模型在融合了特定标签的文本表示上进行训练。

   

  #### 文本表示

   

  我们用 $D={(x_i,y_i)}_{i=1}^N$ 来表示文本集合$N$对应着标签$Y={ y_i \in \{0,1\}^l}$，$l$ 是所有标签的数量。对于文本分类，每个标签包含着文本信息。因此，类似地将文本 编码成向量，我们将标签也编码成一个可训练的矩阵 $C\in R^{l \times k}$。输入文本及相关的标签，多标签分类器旨在训练出将最相关的标签分配给文本。

   

  论文中的编码器使用了Bi-LSTM来对每个单词的上下文进行建模。因此，整篇文本经过Bi-LSTM可以表示成如下：

   

  #### 标签-特定注意力网络

   

  这种策略网络对文本分类十分直观。例如，“ *June a friday, in the lawn, a war between the young boys of the football game starte* ”，将其分为（youth）青年和（sports ）运动。显然，“小男孩”与青年的联系远大于与“体育”的联系，而“足球比赛”应与体育直接相关。接下来，我们将展示我们的模型如何捕获到该特征。

   

  #### 自注意力机制

   

  为了挖掘文本内容属于不同的标签，我们使用了自注意力机制，该机制已经成功地应用到文本语义挖掘任务中。标签词注意得分如下：

   

  其中，$W_1 \in R^{d_a \times 2k}$ $W_2 \in R^{l*d_a}$，这些都是自注意力的训练参数。每行$A^{(s)}_j$ 表明所有单词对第$j$个标签的贡献。然后我们可以获得标签-单词的分数获得每个标签上下文的线性组合：

   

  这样可以获得输入文本关于第$j$个标签的新表示 $M^{(s)} \in R^{l \times 2k}$。

   

  #### 标签-注意力机制

   

  自注意力机制只需要基于文本就可以获得表示。据我们了解，在文本分类时，标签具有特定的语义，是文本内容隐含的描述。我们通过Bi-LSTM获得了单词的语义表示和标签向量$C$，我们可以利用的简单的方式来获得单词和标签之间的语义关系，如计算两者之间的点积如下：

   

  单词和标签之间的前后语义关系，与上述的自注意力机制类似，通过线性组合标签的上下文词来构造标签特定的文档内容表示。

   

  最后，属于所有标签的文本表示为$M^{(l)} =(\overrightarrow M^{(l)},\overleftarrow M^{(l)}) $，由于这个表示是基于标签文本的，因此我们称为标签注意力机制。

   

  #### 自适应融合策略

   

  基于上述内容，我们获得了$M^{(s)}$和$M^{(l)}$,前者关注于文本内容，而后者更关注于文本内容和标签文本之间的语义关联。为了利用这两者的优势，我们设计了一个自适应的融合策略，从中自适应的抽取相应的信息量来构建全面的有关标签特定的文本内容表示。

   

  我们将上面的两个向量送入到全连接层中获得两个向量的权重，具体如下：

   

  上述$\alpha_j$和$\beta_j$分别表明自注意力和标签注意力来构建最后文本表示的重要性。我们并加以以下限制

   

  然后，基于融合策略，我们获得最终的文本内容表示沿着第$j$个标签表示为：

   

  最后将文本表示进行Relu线性变换，使用交叉熵损失函数来作为多分类任务的目标函数。

   

  ### 实验

   

  实验主要在四个数据集上进行了实验：

   

   

  1. 

   

  1. 

   

  1. 

   

  1. 

   

   

  ![img](data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9JzUwNicgd2lkdGg9JzE1MjYnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZycgdmVyc2lvbj0nMS4xJy8+)![img](https://flashgene.com/wp-content/uploads/2020/04/873632643edb88331f2b2a9c9bfece4e.png)

   

  从上图可以看出，该论文提出的模型在所有语料上的性能均超越了基线模型。为了探讨标签注意力的效果，论文还使用热图可视化注意力在原文中分布，如下图所示：

   

  ![img](data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9JzQxNCcgd2lkdGg9JzE1MjYnIHhtbG5zPSdodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZycgdmVyc2lvbj0nMS4xJy8+)![img](https://flashgene.com/wp-content/uploads/2020/04/ed3095cfee70bf9fc2003ea02e763909.png)

   

  这个例子是AAPD领域中属于计算机视觉和进化计算的论文，从注意力权重上，我们可以观察到每个类别属于与自己最相关的词，这也就验证了论文提出的标签具体注意力网络是能够抽取出基于标签感知的内容并进一步构建关于标签特定的文档表示。

   

  [《Label-Specific Document Representation for Multi-Label Text Classification》](https://www.aclweb.org/anthology/D19-1044.pdf)

- 

