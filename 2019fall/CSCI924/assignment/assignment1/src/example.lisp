;;; First some accessor functions for decision trees, each dt has a
;;; feature (with associated values, mostly for printing purposes) and
;;; some subtrees.  A dt is a leaf if its subtrees field is null.  If
;;; it is an inner node, then feature will be the number of the
;;; feature, if it is a leaf, then feature is the classification
(defun make-decision-tree (feature values subtrees)
  (list feature values subtrees))

(defun dt-feature (dt)
  (first dt))

(defun dt-values (dt)
  (second dt))

(defun dt-subtrees (dt)
  (third dt))

(defun dt-leaf (dt)
  (null (dt-subtrees dt)))

(defun print-dt (dt &optional (level 0))
  (cond
   ((dt-leaf dt)
    (format t "~%~vTClass: ~a" (* level 5) (dt-feature dt)))
   (t
    (if *feature-names*
	(format t "~%~vTFeature: ~a"
		(* level 5) (nth (dt-feature dt) *feature-names*))
      (format t "~%~vTFeature: ~a" (* level 5) (dt-feature dt)))
    (dotimes (i (length (dt-subtrees dt)))
      (format t "~%~vT~a" (* level 5) (nth i (dt-values dt)))
      (print-dt (nth i (dt-subtrees dt)) (+ level 1))))))

(defconstant *FAIL* (make-decision-tree 'id3-fail nil nil) "A place
holder for cases where ID3 fails")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A utility for debugging trace-print will only print its arguments
;;; if TEST is true
(defparameter *trace-id3* nil "Produces a trace if set to T")
(defun trace-print (test ctrl-string &rest args)
  (if test
      (apply #'format t ctrl-string args)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Here's the main code

(defun train (examples)
  ;; First build a list (1 2 3 ... num-features)
  ;; then call build-dt with the examples and the list
  (let ((features)
	(dt))
    (dotimes (i (- (length (first examples)) 1))
      (push (- (length (first examples)) i 1) features))
    (setq dt (build-dt examples features))
    (print-dt dt)
    dt))

(defun build-dt (examples features)
  (trace-print *trace-id3* "~%Comparing features: ~a"
	       (if *feature-names*
		   (mapcar #'(lambda (n) (nth n *feature-names*)) features)
		 features))
  ;; First extract the classes and the possible values for each of the
  ;; features under consideration
  (let ((classes)
	(possible-values (make-list (length features))))
    (dolist (example examples)
      (pushnew (first example) classes)
      (dotimes (i (length features))
	(pushnew (nth (nth i features) example)
		 (nth i possible-values))))

    (cond
     ;; No examples, real ID3 would use most common classification of
     ;; parent node
     ((null examples)
      (trace-print *trace-id3* "~%No examples, fail:")
      *FAIL*)

     ;; All examples are the same class, make a leaf node with that class
     ((= 1 (length classes))
      (trace-print *trace-id3* "~%All examples: ~a" (first (first examples)))
      (make-decision-tree (first (first examples)) nil nil))

     ;; No features, real ID3 would use most common classification of examples
     ((null features)
      (trace-print *trace-id3* "~%No features, fail:")
      *FAIL*)

     ;; Otherwise, pick a feature, split the examples into groups
     ;; based on their values for the chosen feature and recur on each
     ;; group, removing feature from the list of features under
     ;; consideration.  Once the recursion returns, use the resulting
     ;; subtrees and the chosen feature to build a decision-tree
     (t
      (let* ((feature (pick-feature examples features
				    possible-values classes))
	     (values (nth (position feature features) possible-values))
	     (groups (split examples feature values))
	     (subtrees (mapcar #'(lambda (group value)
				   (trace-print *trace-id3*
						"~%~%Considering value ~A of feature ~A"
						value
						(nth feature *feature-names*))
				   (build-dt group (remove feature features)))
			       groups values)))
	(make-decision-tree feature values subtrees))))))

;;; Use information gain heuristic to pick which feature to split on.
;;; Info-gain(examples, feature) = total-info -
;;;                                   expected-info-of-splitting-on-feature
(defun pick-feature (examples features possible-values classes)
  (let ((max-gain MOST-NEGATIVE-SINGLE-FLOAT) ; Initialize max
	gain
	chosen-feature
	feature
	values
	(total-info (total-info examples classes)))  ; Compute total-info
    ;; For each feature compute info-gain, compare to max and make it
    ;; the chosen feature if compares favorably
    (dotimes (i (length features))
      (setq feature (nth i features))
      (setq values (nth i possible-values))
      (setq gain (- total-info
		    (expected-info feature examples values classes)))
      (when (> gain max-gain)
	(setq max-gain gain)
	(setq chosen-feature feature))
      (trace-print
       *trace-id3*
       "~%total/expected/gained info for feature ~15A = ~5,3F/~5,3F/~5,3F"
       (nth feature *feature-names*) total-info (+ gain total-info) gain))
    (trace-print *trace-id3*
		 "~%~%Splitting on feature ~A"
		 (nth chosen-feature *feature-names*))
    ;; Return the chosen feature
    chosen-feature))

;;; Split a bunch of examples into separate groups based on which
;;; value each example has for feature.  Start with a list of N lists
;;; (where N is the number of possible values of feature), for each
;;; example, add it to group i (where i is the index of that example's
;;; value for feature into the possible values for feature)
(defun split (examples feature values)
  (let ((groups (make-list (length values))))
    (dolist (example examples)
      (push example (nth (position (nth feature example) values) groups)))
    groups))


;;; Compute the expected amount of information needed for the subtrees
;;; created by splitting on the given feature. This is simply a
;;; weighted sum of the information needed for each subtree.
(defun expected-info (feature examples values classes)
  (let ((E 0)
	(num-examples (length examples)))
    (dolist (value values)
      (let ((counts (make-list (length classes) :initial-element 0))
 	    (position))
	(dolist (example examples)
	  (when (equal (nth feature example) value)
	    (setq position (position (first example) classes))
	    (incf (nth position counts))))
	(incf E (* (/ (apply #'+ counts) num-examples)
		   (info counts)))))
    E))

;;; (Also known as Entropy)
;;; Compute the amount of information needed to distinguish between
;;; classes given (nth i counts) instances of class i
(defun info (counts)
    (let* ((sum (apply #'+ counts))
	   (entropies (mapcar #'(lambda (count)
				  (if (zerop count)
				      0
				    (- (* (/ count sum)
					  (log (/ count sum) 2)))))
			      counts)))
      (apply #'+ entropies)))

;;; Compute the expected amount of information needed for the subtrees
;;; created by splitting on the given feature. This is simply a
;;; weighted sum of the information needed for each subtree.
(defun total-info (examples classes)
  (let ((counts (make-list (length classes) :initial-element 0))
	(position))
    (dolist (value classes)
      (dolist (example examples)
	(when (equal (first example) value)
	  (setq position (position (first example) classes))
	  (incf (nth position counts)))))
    (info counts)))