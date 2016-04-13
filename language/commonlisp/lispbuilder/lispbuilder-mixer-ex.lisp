(ql:quickload '(:lispbuilder-sdl-mixer :lispbuilder-sdl))

(defun initialize-my-parameters (music cover width height)
  (defparameter *window-width* width)
  (defparameter *window-height* height)
  (defparameter *root-path* #P"/home/liu/Hack/language/commonlisp/lispbuilder/")
  (defparameter *music* (sdl:create-path *root-path* music))
  (defparameter *cover* (sdl:create-path *root-path* cover)))
(initialize-my-parameters "sample.wav" "yinlin.png" 500 500)
(initialize-my-parameters "xiaoyaoxing.ogg" "xuwei.jpeg" 500 500)

(defun draw-box-load-image ()
  (sdl:draw-box
   (sdl:rectangle :x (floor (/ *window-width* 3))
                  :y (floor (/ *window-height* 3))
                  :w (floor (/ *window-width* 3))
                  :h (floor (/ *window-height* 3)))
   :color (sdl:color :r 200 :g 200 :b 200))
  (sdl:draw-surface-at-*
   (sdl:load-image *cover*
                   :alpha 90)
   (- (/ *window-width* 2) (floor (/ 145 2)))
   (- (/ *window-height* 2) (/ 220 2))))

(defun control-music ()
  (cond ((or (sdl:mouse-left-p)
             (sdl:key-down-p :sdl-key-c)
             (and (sdl:key-down-p :sdl-key-space)
                  (equal step 1)))
         (sdl-mixer:pause-music)
         (setf step 0))
        ((or (sdl:mouse-right-p)
             (sdl:key-down-p :sdl-key-r)
             (and (sdl:key-down-p :sdl-key-space)
                  (zerop step)))
         (sdl-mixer:resume-music)
         (setf step 1))))

(defun handle-keyboard-event ()
  (when (or (sdl:key-down-p :sdl-key-q)
            (sdl:key-down-p :sdl-key-escape))
    (sdl:push-quit-event)))

(sdl:with-init (sdl:sdl-init-video sdl:sdl-init-audio)
  (sdl:window *window-width* *window-height*)
  (sdl-mixer:OPEN-AUDIO)
  (let ((music
         (sdl-mixer:load-music
          *music*))
        (x *window-width*)
        (step 1))
    (sdl-mixer:play-music music :loop t)
    (sdl:with-events ()
      (:quit-event ()
                   (sdl-mixer:Halt-Music)
                   (sdl-mixer:free music)
                   (sdl-mixer:close-audio)
                   t)
      (:key-down-event () (handle-keyboard-event))
      (:idle ()
             (sdl:clear-display (sdl:color :r 127 :g 127 :b 127))
             (draw-box-load-image)
             (let ((playing 1))
               (control-music)
               (if (zerop playing)
                   (setf step 0)
                   (setf step 1)))
             (decf x step)
             (when (< x 0)
               (setf x *window-width*))
             (sdl:draw-vline x (- (floor (/ *window-height* 2)) 70)
                             (+ (floor (/ *window-height* 2)) 70)
                             :clipping nil
                             :color (sdl:color :r 150 :g 100 :b 200))
             (sdl:update-display)))))

(defun setup-and-draw-vline ()
  (let ((width 500) (height 500)
	(x 10))
    (sdl:with-init ()
      (sdl:window width height :title-caption "Setup and Draw, from Processing.org")
      (setf (sdl:frame-rate) 30)
      (sdl:with-events ()
	(:quit-event () t)
        (:key-down-event ()
                         (when (or (sdl:key-down-p :sdl-key-q)
                                   (sdl:key-down-p :sdl-key-escape))
                           (sdl:push-quit-event)))
	(:idle ()
               (sdl:clear-display (sdl:color :r 150 :g 100 :b 200))
               (decf x 1)
               (when (< x 0)
                 (setf x width))
               (sdl:draw-vline x (- height 40) height
                               :clipping nil
                               :color (sdl:color :r 255 :g 255 :b 255))
               (sdl:update-display))))))

(sdl-mixer:init-mixer :ogg)
(when  (sdl-mixer:open-audio)
  (setf yinlin (sdl-mixer:load-sample #P"xiaoyaoxing.ogg"))
  (sdl-mixer:register-sample-finished
   (lambda (channel)
     (declare (ignore channel))
     (format t "sample finished on channel: ~S" channel)
     nil))
  (sdl-mixer:allocate-channels 16)
  (sdl-mixer:play-sample yinlin :loop t))
(sdl-mixer:halt-sample :channel t)
(sdl-mixer:close-audio)

(when  (sdl-mixer:open-audio)
  (setf yinlin (sdl-mixer:load-sample #P"/home/liu/Hack/language/commonlisp/lispbuilder/sample.wav"))
  (setf yinlin (sdl-mixer:load-music #P"/home/liu/Hack/language/commonlisp/lispbuilder/sample.wav"))
  (sdl-mixer:register-sample-finished
   (lambda (channel)
     (declare (ignore channel))
     (format t "sample finished on channel: ~S" channel)
     nil))
  (sdl-mixer:allocate-channels 16)
  (sdl-mixer:play-sample yinlin :loop t))
