(defun NumberOfPrimes 
    (lis)
    (if 
        (lis) 
        (setq liscar 
            (car lis))
        (if liscar)
        (if 
            (and liscar 
                (atom liscar)) 
            (1+ x) 
            (
                (if 
                    (cdr lis) 
                    (NumberOfPrimes
                        (cdr lis))))) 
        (0))
)