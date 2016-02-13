;;;====================
;;; some example code
;;; in chapter 3
;;; Functional Programming
;;; 2015/02/27
;;;
;;; Time Passed. Now it is 2016/02/06. :(
;;;====================

;;; ====================
;;; 3.1 Function Design

(defun good-reverse (lst)
  (labels ((rec (lst acc)
		(if (null lst)
		    acc
                    (rec (cdr lst)
                         (cons (first lst) acc)))))
    (rec lst nil)))

(good-reverse '(a b c d e))

(= 2 (truncate 2.6)) ; return t. It uses first return value

(format t "~&~S"
	(multiple-value-bind (int frac)
	    (truncate 2.66)
	  (list int frac)))

(defun powers (x)
  (values x (sqrt x) (expt x 2)))

(format t "~&~S"
	(multiple-value-bind (base root square)
	    (powers 4)
	  (list base root square)))

;; ====================
;; 3.2 Imperative Outside-In

(defun fun (x)
  (list 'a (expt (car x) 2)))

(fun '(4))

(defun imp (x)
  (let (y sqr)
    (setq y (car x))
    (setq sqr (expt y 2))
    (list 'a sqr)))

(imp '(4))

;; ====================
;; 3.3 Functional Interfaces

(defun exclaim (expression)
  (append expression '(oh my)))

; type following three expressions in REPL

(exclaim '(lions and tigers and bears))

(nconc * '(goodness))

(exclaim '(fixnums and bignums and floats))

; so we should write:

(defun exclaim (expression)
  (append expression (list 'oh 'my)))

(let ((a '(a b c)))
  (nconc a '(e f g))
  a)

(let ((x 0))
  (defun total (y)
    (incf x y)))

(total 3)

(defun not-ok (x)
  (nconc (list 'a) x (list 'c)))

(let ((a '(a b c)))
  (not-ok a)
  a)

;; use of mapcar, mapcan, maplist, mapc, mapl

(mapcar #'car '((1 a)
                (2 b)
                (3 c)))
(mapcar #'abs '(3 -4 2 -5 -6))
(mapcar #'cons '(a b c) '(1 2 3))
(maplist #'append '(1 2 3 4)
         '(1 2)
         '(1 2 3))
(maplist #'(lambda (x)
             (cons 'foo x))
         '(a b c d))
(maplist #'(lambda (x)
             (if (member (car x) (cdr x))
                 0 1))
         '(a b a c d b c))
(setq dummy nil)

(mapc #'(lambda (&rest x)
          (setq dummy (append dummy x)))
      '(1 2 3 4)
      '(a b c d e)
      '(x y e))
(format t "~S" dummy)
(setq dummy nil)
(mapl #'(lambda (x)
          (push x dummy))
      '(1 2 3 4))
(format t "~S" dummy)
(mapcan #'(lambda (x y)
            (if (null x)
                nil
                (list x y)))
        '(nil nil nil d e)
        '(1 2 3 4 5 6))
(mapcar #'(lambda (x y)
            (if (null x)
                nil
                (list x y)))
        '(nil nil nil d e)
        '(1 2 3 4 5 6))
(mapcan #'(lambda (x)
            (and (numberp x)
                 (list x)))
        '(a 1 b c 3 4 d 5))

;; use of nconc
(nconc)

;; use of rplaca, rplacd
(let ((a '(1 2 3)))
  (rplaca a 100)
  a)
(let ((a '(1 2 3)))
  (rplacd a (list 100))
  (format t "a is: ~S~%" a)
  (format t "rplacd return value: ~S~%" (rplacd (last a) (list 200)))
  (format t "~S~%" a)
  (setq lst (list* 'one 'two 'three 'four))
  (format t "~S~%" lst)
  (format t "rplaca return value: ~S~%" (rplaca lst 'uno))
  (format t "~S~%" lst)
  (rplacd (last lst) (list 'IV)))


