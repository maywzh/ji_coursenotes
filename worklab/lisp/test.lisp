
(defun show-squares 
    (i end)
    (if 
        (> i end) 'done
        (progn
            (format t "~A ~A~%" i 
                (* i i))
            (show-squares 
                (+ i 1) end))))

(show-squares 1 9)