
(defun getData
    (filePath)
    (let 
        (
            (in 
                (open filePath :if-does-not-exist nil))
            (features nil))
        (when in
            (loop for line = 
                (read-line in nil)
whilelinedo
                (format t "~a~%" line))
            (close in)) '
        (1 2)))
