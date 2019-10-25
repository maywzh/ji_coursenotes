(defun IsPrime 
	(p)
	(cond 
		(
			(= 1 p) 0) 
		(t 
			(if 
				(loop for i from 2 to 
					(sqrt p) never 
					(= 0 
						(mod p i))) 1 0))))

(defun NumberOfPrimes 
	(lis)
	(if 
		(atom lis) 
		(if 
			(not lis) 0 
			(IsPrime lis))
		(+ 	
			(NumberOfPrimes 
				(car lis)) 
			(NumberOfPrimes 
				(cdr lis)))))

(defun even 
	(lis)
	(setq ans nil)
	(if 
		(atom lis) 
		(if 
			(lis) 
			;(when (= 0 (mod lis 2)) (setq ans (append ans lis)) )
			(cons ans lis)
		)
		(+ 	
			(even 
				(car lis)) 
			(even 
				(cdr lis)))) (ans))

;(nth-value 1 (floor 4 3))
;(multiple-value-bind (quot rem)
;    (floor 4 3)
;  (format t "The remainder is ~f~%" rem))