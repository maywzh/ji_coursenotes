# Toxic-Comment-Classification-Challenge

Kaggle Toxic Comment Classification Challenge: (https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge) <br />
<br />
Single LSTM + GRU Model with 10 fold CV yields a ROC-AUC score of **0.9871** against Public LB highest of 0.9890 with current solution ranked **300<sup>th</sup>** on Public LB <br />
<br />
**Additional Details:**
1. Embedding Vectors - fastText & GloVe Twitter (200d)
2. Implementation Libraries - Pytorch (Model) & Keras (Text Pre-processing)

**Potential Areas of Improvement:**
1. Modifying model architecture with focus on better regularization
2. Ensembling (though ensembling with NB-SVM baseline did not help improve the score)

**Note** - Did not use BERT baseline since it wasn't released at the time of competition <br />
