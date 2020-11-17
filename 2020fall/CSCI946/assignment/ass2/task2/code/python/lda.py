'''
Author: maywzh
Date: 2020-11-16 18:43:22
LastEditTime: 2020-11-17 00:02:59
LastEditors: maywzh
Description: 
FilePath: /ji_coursenotes/2020fall/CSCI946/assignment/ass2/task2/lda.py
maywzh，All rights reserved.
'''
from nltk.corpus import reuters 
 
def collection_stats():
    # List of documents
    documents = reuters.fileids()
    print(str(len(documents)) + " documents");
 
    train_docs = list(filter(lambda doc: doc.startswith("train"),
                        documents));
    print(str(len(train_docs)) + " total train documents");
 
    test_docs = list(filter(lambda doc: doc.startswith("test"),
                       documents));
    print(str(len(test_docs)) + " total test documents");
 
    # List of categories
    categories = reuters.categories();
    print(str(len(categories)) + " categories");
 
    # Documents in a category
    category_docs = reuters.fileids("acq");
 
    # Words for a document
    document_id = category_docs[0]
    document_words = reuters.words(category_docs[0]);
    print(document_words);  
 
    # Raw document
    print(reuters.raw(document_id));