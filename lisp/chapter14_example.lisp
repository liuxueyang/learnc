;;; ##############################
;;;                              #
;;;     chapter 14 Macros,       #
;;;      and Compilation         #
;;;        Example code          #
;;;         2015/01/12           #
;;;                              #
;;; ##############################



;; ==============================
;; ==============================

;; 14.4 DEFINING A MACRO

(defmacro simple-incf (var)
  (list 'setq var (list '+ var 1)))

(setf a 4)
(simple-incf a)

(defmacro simple-incf-1 (var &optional (amount 1))
  (list 'setq var (list '+ amount var)))

(setf b 2)
(simple-incf-1 b (* 3 a))

;; 14.6 THE BACKQUOTE CHARACTER

(setf name 'fred)

`(this is ,name from pittsburgh)

`(i gave ,name about ,(* 25 8) dollars)

(defmacro simple-incf-2 (var &optional (amount 1))
  `(setq ,var (+ ,var ,amount)))

(setf a 2)
(simple-incf-2 a 2)

`(setf foo 'bar)