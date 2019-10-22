(defun IsPrime 
	(p)
	(if 
		(or 
			(= p 1) 
			(= p 2)) 
		(return 1) 
		
		(
			(loop for i from 2 to 
				(nth-value 0 
					(floor 
						(sqrt lis))) do 
				(
					(if 
						(= 0 
							(mod p i)) 
						(return nil)))) 
			(return 1))))

(defun NumberOfPrimes 
	(lis)
	(if 
		(atom lis) 
		(if 
			(not lis) 0 1)
		(+ 	
			(NumberOfPrimes 
				(car lis)) 
			(NumberOfPrimes 
				(cdr lis)))))

;(nth-value 1 (floor 4 3))
;(multiple-value-bind (quot rem)
;    (floor 4 3)
;  (format t "The remainder is ~f~%" rem))