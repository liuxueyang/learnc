(defclass tree-node ()
  ((value :initform nil
          :initarg :value
          :accessor value)
   (left :initform nil
         :accessor left-child)
   (right :initform nil
          :accessor right-child)))

(defun create-node (value)
  (let ((node (make-instance 'tree-node :value value)))
    node))

(defun insert-node (tree-node
                    value)
  (cond ((> (value tree-node) value)
         (if (null (left-child tree-node))
             (setf (left-child tree-node)
                   (create-node value))
             (insert-node (left-child tree-node) value)))
        ((< (value tree-node) value)
         (if (null (right-child tree-node))
             (setf (right-child tree-node)
                   (create-node value))
             (insert-node (right-child tree-node) value)))
        (t (format t "duplicate insert of ~d~%" value))))

(defun in-order (tree-node)
  (if (null tree-node) (return-from in-order))
  (in-order (left-child tree-node))
  (format t "~d " (value tree-node))
  (in-order (right-child tree-node)))

(defun pre-order (tree-node)
  (if (null tree-node) (return-from pre-order))
  (format t "~d " (value tree-node))
  (pre-order (left-child tree-node))
  (pre-order (right-child tree-node)))

(defun post-order (tree-node)
  (if (null tree-node) (return-from post-order))
  (post-order (left-child tree-node))
  (post-order (right-child tree-node))
  (format t "~d " (value tree-node)))

(defun search-value (tree-node
                     value)
  (if (null tree-node) (return-from search-value nil))
  (if (equal value (value tree-node))
      (return-from search-value tree-node))
  (search-value (if (< value (value tree-node))
                    (left-child tree-node)
                    (right-child tree-node))
                value))

(defparameter root (create-node 1))

(dotimes (i 5)
  (insert-node root (random 100)))

(format t "~%~%Pre-order: ")
(pre-order root)
(format t "~%")
(format t "~&In--order: ")
(in-order root)
(format t "~%")
(format t "~&Pos-order: ")
(post-order root)
(format t "~%")

;; use C-c C-d h to read the documentation.
;; use C-u RET to input EOF in the SLIME REPL

;; (do ((in (read nil nil) (read nil nil)))
;;     ((null in) (format t "exit"))
;;   (format t "~&in = ~d~%" in))

;; another way to loop input from the STDIN

;; (format t "Search? ")
;; (loop for in = (read nil nil)
;;       while in
;;       do
;;          (format t "~&in = ~d~%" in)
;;          (format t "Search ? "))

(format t "Search? ")
(loop for in = (read nil nil)
      while in
      do
         (let ((found (search-value root in)))
           (if found
               (format t "Found ~d at ~a~%"
                       (value found)
                       found)
               (format t "No ~d in the tree.~%" in))
           (format t "Search? ")))
