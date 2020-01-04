
(let 
    (
        (in 
            (open "data.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = 
            (read-line in nil)
whilelinedo
            (format t "~a~%" line))
        (close in)))

