(let ((n (read))
      m)
  (setf m (+ (* 100 (mod n 10))
             (* 10 (mod (floor (/ n 10)) 10))
             (floor (/ n 100))))
  (format t "~3,'0d~%" m)
  ;; (format t "~d~%" m)
  )
