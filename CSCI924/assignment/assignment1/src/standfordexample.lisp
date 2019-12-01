;; #| 

;; This file contains Decision tree learning code to accompany the
;; textbook "Machine Learning," Tom M. Mitchell, McGraw Hill, 1997.

;; Copyright 1998 Tom M. Mitchell.  This code may be freely distributed
;; and used for any non-commericial purpose, as long as this copyright
;; notice is retained.  The author assumes absolutely no responsibility
;; for any harm caused by bugs in the code.


;;  1. OVERVIEW

;; This file contains a Lisp implementation of the ID3 program for
;; learning decision trees, as described in Table 3.1 of the textbook
;; "Machine Learning," Tom Mitchell, McGraw Hill, 1997.  It also contains
;; the set of training examples given in Table 3.2.

;; The code is simple enough that you should be able to inspect and
;; modify it for your own use.

;; The six key functions are:

;; 1. ID3(examples target.attribute attributes)
;;    learns a decision tree, using the algorithm from Table 3.1 in the book

;; 2. Classify(instance tree)
;;    Given a new instance and a previously learned tree, returns the 
;;    classification of that instance produced by the tree.

;; 3. Print.tree(tree)
;;    Prints a tree in human readable form

;; 4. Print.entity(instance)
;;    Prints an instance (e.g., one of your training examples)

;; 5. Get.value(attribute instance)
;;    Get the value of some ATTRIBUTE of INSTANCE

;; 6. Put.value(attribute instance value)
;;    Assign VALUE to ATTRIBUTE of INSTANCE


;; 2. EXAMPLE TRACE:

;; After loading this file into CommonLisp, you should be able to
;; duplicate the following trace:


;; ;; FIRST LOOK AT THE PROVIDED TRAINING EXAMPLES
;; >> *training.examples*
;; (D14 D13 D12 D11 D10 D9 D8 D7 D6 D5 ...)

;; ;; USE THE FUNCTION PRINT.ENTITY TO EXAMINE JUST ONE OF THEM
;; >> (print.entity 'd6)

;; (PLAY.TENNIS? NO WIND STRONG HUMIDITY NORMAL TEMPERATURE COOL OUTLOOK RAIN) 

;; ;; NOW USE ID3 TO LEARN A TREE
;; >> (setq tree (id3 *training.examples* 
;; 		'play.tennis? 
;; 		'(outlook temperature humidity wind)))

;; (OUTLOOK (SUNNY (HUMIDITY (NORMAL YES) (HIGH NO))) 
;;          (OVERCAST YES)
;;          (RAIN (WIND (STRONG NO) (WEAK YES))))


;; ;; LOOK AT THE TREE IN A MORE HUMAN-FRIENDLY FORM
;; >> (print.tree tree)
;; OUTLOOK
;;  = SUNNY
;;      HUMIDITY
;;       = NORMAL => YES
;;       = HIGH => NO
;;  = OVERCAST => YES
;;  = RAIN
;;      WIND
;;       = STRONG => NO
;;       = WEAK => YES


;; ;; FINALLY, USE THIS LEARNED TREE TO CLASSIFY AN INSTANCE
;; >> (classify 'd6 tree)
;; NO


;; |#

;;; General utility functions
;; use (print.entity instance) to see the definition of entity 

(defun put.value (attribute instance val)
  "assign a value to an attribute of an instance"
  (setf (get instance attribute) val))

(defun get.value (attribute instance)
  "retrieve the value of attribute of instance"
  (get instance attribute))

(defun print.entity (instance)
  "print the description of instance to the screen"
  (print (symbol-plist instance)))


(setf *data* 
;;;     day outlook temperature humidity wind play.tennis?
      '((d1 sunny hot high weak no)
        (d2 sunny hot high strong no)
        (d3 overcast hot high weak yes)
        (d4 rain mild high weak yes)
        (d5 rain cool normal weak yes)
        (d6 rain cool normal strong no)
        (d7 overcast cool normal strong yes)
        (d8 sunny mild high weak no)
        (d9 sunny cool normal weak yes)
        (d10 rain mild normal weak yes)
        (d11 sunny mild normal strong yes)
        (d12 overcast mild high strong yes)
        (d13 overcast hot normal weak yes)
        (d14 rain mild high strong no)))

(defvar *training.examples* nil)
;; set up each training example so that GET.VALUE(attribute example) can be used
;; to retrieve the value of ATTRIBUTE for EXAMPLE
(loop for d in *data* do
      (setf *training.examples* (cons (first d) *training.examples*))
      (loop for attribute in '(outlook temperature humidity wind play.tennis?)
            as value in (cdr d)
            do (put.value attribute (first d) value)))
(put.value 'legal.values 'play.tennis? '(yes no))


;;; Top level ID3 Decision Tree learning algorithm
;
; Tree Representation: each non-terminal tree node is a list of the form 
;  (attribute (value1 subtree1)(value2 subtree2)...)
;  where subtree-n is either a non-terminal node, or a value signifying the 
;  target value associated with that terminal node

(defun id3 (examples target.attribute attributes)
  "TARGET.ATTRIBUTE is the attribute to be predicted by the learned tree.
   EXAMPLES are training examples.  ATTRIBUTES is a list of attributes (not
   including TARGET.ATTRIBUTE) that may be included in the learned decision 
   tree.
   Returns: a decision tree that predicts the TARGET.ATTRIBUTE over EXAMPLES"
  (let (firstvalue a partitions)
    (setq firstvalue (get.value target.attribute (first examples)))
    (cond 
     ;; if every example has the same target attribute value, return it as
     ;; a leaf node
     ((every #'(lambda(e)(eq firstvalue (get.value target.attribute e)))
             examples)
      firstvalue)
     ;; if no attributes, return the most common target attribute value
     ((null attributes)
      (most.common.value target.attribute examples))
     ;; otherwise, pick the best attribute, partition training data, and call
     ;; ID3 recursively to grow subtrees below this node
     (t
      (setq partitions
            (loop for a in attributes collect (partition a examples)))
      (setq a (choose.best.partition target.attribute partitions))
      (cons (first a)
            (loop for branch in (cdr a) collect
                  (list (first branch)
                        (id3 (cdr branch) 
                             target.attribute 
                             (remove (first a) attributes)))))))))

                  
(defun partition (attribute instances)
  "returns a partion of INSTANCES according to their values for ATTRIBUTE. 
   Returns a list (attribute (value1 e11 e12 ...)(value2 e21 e22 ...)...)"
  (let (result vlist v)
    (loop for e in instances do
          (setq v (get.value attribute e))
          (if (setq vlist (assoc v result))
            (rplacd vlist (cons e (cdr vlist)))
            (setq result (cons (list v e) result))))
    (cons attribute result)))

(defun choose.best.partition (target.attribute partitions)
  "return the partition with the highest information gain.  
   PARTITIONS is of the form ((attribute1 (val1 e11 e12 ...)(val2 e21 e22 ...)...)
                              (attribute2 (...  ...........)(...  ...  )...)).
   Note for efficiency, we compute only the expected value of the entropy of the
   partition, because this is the only term in information gain that varies from
   one attribute to another"
  (let ((lowest.exp.entropy 9999) exp.entropy best.partition)
    (loop for att.partition in partitions do
          (when (< (setq exp.entropy 
                         (expected.entropy target.attribute (cdr att.partition)))
                   lowest.exp.entropy)
            (setq lowest.exp.entropy exp.entropy)
            (setq best.partition att.partition)))
    best.partition))

(defun expected.entropy (att partition)
  "returns the sum over possible values of att of the quantity
    number.of.instances.with.this.value x sample.entropy.of.this.partition"
  (loop for p in partition sum
        (* (length (cdr p))
           (loop for v in (get.value 'legal.values att) sum
                 (let ((vcount (loop for e in (cdr p) count 
                                     (eq v (get.value att e))))
                       proportion)
                   (setq proportion (/ vcount (length (cdr p))))
;;                   (format t "p: ~S, vcount: ~d, proportion: ~S~%"
;;                           p vcount proportion)
                   (* -1.0 proportion 
                      (if (zerop proportion) 0 (log proportion 2))))))))

(defun most.common.value (attribute instances)
  (let ((length 0) longest)
    (loop for p in (partition attribute instances) do
          (when (> (length p) length)
            (setq length (length p))
            (setq longest p)))
    (car longest)))
                   

(defun print.tree (tree &optional (depth 0))
  (tab depth)
  (format t "~A~%" (first tree))
  (loop for subtree in (cdr tree) do
        (tab (+ depth 1))
        (format t "= ~A" (first subtree))
        (if (atom (second subtree))
          (format t " => ~A~%" (second subtree))
          (progn (terpri)(print.tree (second subtree) (+ depth 5))))))
(defun tab (n)
  (loop for i from 1 to n do (format t " ")))


;;;******
;;  Code to classify a new instance given a tree output by ID3
;;
(defun classify (instance tree)
  (let (val branch)
    (if (atom tree) (return-from classify tree))
    (setq val (get.value (first tree) instance))
    (setq branch (second (assoc val (cdr tree))))
    (classify instance branch)))

(defun entropy (p)
  (+ (* -1.0 p (log p 2))
     (* -1.0 (- 1 p) (log (- 1 p) 2))))