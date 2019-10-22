(defun NumberOfPrimes 
	(lis)
	(if 
		(atom lis) 
		(if 
			(not lis) 0 
			(loop (return 1)))
		(+ 
			(NumberOfPrimes 
				(car lis)) 
			(NumberOfPrimes 
				(cdr lis)))))