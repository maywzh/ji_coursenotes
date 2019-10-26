
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
    (if 
        (atom lis) 
        (if 
            (null lis) lis 
            (if 
                (= 0 
                    (mod lis 2)) 
                (list lis) nil)) 
        (append 
            (even 
                (car lis)) 
            (even 
                (cdr lis))))
)

(defun flatten
    (lis)
    (if 
        (atom lis) 
        (if 
            (null lis) lis 
            (list lis)) 
        (append 
            (flatten 
                (car lis)) 
            (flatten  
                (cdr lis)))))



(defun SumIfNot
    (lis0 lis1)
    (let 
    (
        (mysumv 0))
        (loop for i in 
            (flatten lis1) do
            (if 
                (loop for j in 
                    (flatten lis0) never 
                    (= i j)) 
                (setq mysumv
                    (+ mysumv i)))) mysumv)
)