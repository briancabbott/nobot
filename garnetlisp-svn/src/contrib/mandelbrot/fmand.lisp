;;; -*- Mode: Lisp; Package: Common-Lisp-User -*-
;;;
;;; File: Mandelbrot.lisp
;;;
;;; Calculate and plot the Mandelbrot set
;;;
;;; Written by Fred Gilham; this file is in the public domain.
;;;
;;; $Id:: fmand.lisp 116 2017-03-24 02:46:45Z rotgut         $

(declaim (optimize (speed 2) (safety 3) (space 2) (debug 3) (compilation-speed 0)))
;;(declaim (optimize (speed 3) (safety 1) (space 0) (debug 1) (compilation-speed 0)))

(defpackage "FMAND"
  (:use :common-lisp :kr)
  (:nicknames "FM")
  (:export :do-start :do-stop))

(in-package "FMAND")

(eval-when (:compile-toplevel :load-toplevel :execute)
  (dolist (pair '((:motif-text-buttons "gg:motif-text-buttons-loader")
		  (:motif-save-gadget "gg:motif-save-gadget-loader")
		  (:motif-h-scroll "gg:motif-h-scroll-loader")
		  (:prop-sheet-win "gg:prop-sheet-win-loader")
		  (:mouseline "gg:mouseline-loader")
		  ))
    (unless (get :garnet-modules (first pair))
      (cl-user::garnet-load (second pair))))
)


;;;
;;; Window variables.
;;;
(declaim (special MANDELBROT-CANVAS MANDELBROT-TOP-AGG
		  MANDELBROT-PIXMAP MANDELBROT-PIXARRAY
		  CONTROL-WIN CONTROL-TOP-AGG
		  MANDELBROT-BANNER
		  MOUSELINE
		  MOVING-RECTANGLE OUTLINE-RECTANGLE
		  BUTTONS
		  SAVE-IMAGE-DIALOG LOAD-CMAP-DIALOG
		  SLIDER
		  INDICATOR INDICATOR-TEXT
		  PROP
		  *box-list*            ; x, y, width, height of outline rectangle.
		  *depth*
		  *colormap*))

(declaim (type (signed-byte 16) *plot-xy*))
(defparameter *plot-xy* 800)

(declaim (fixnum +black-index+ +white-index+))

;;; Set up the black colormap index.
(defvar +black-index+ (g-value opal:black :colormap-index)) ; Get black's colormap index.
(defvar +white-index+ (g-value opal:white :colormap-index)) ; Get white's colormap index.

;;;
;;; Graphics parameters.
;;;
(declaim (type (signed-byte 16) *iterations* *initial-iterations* *max-colors*))
(defparameter *initial-iterations* 128)
(defparameter *max-iterations*     2048)
(defparameter *iterations*         128)
(defparameter *max-colors*         256)

;;;
;;; Plot parameters.
;;;
(declaim (type long-float *real-center* *imaginary-center* *radius*))
(defvar *real-center*     -0.5l0)
(defvar *imaginary-center* 0.0l0)
(defvar *radius*           2.0l0)

;;;
;;; For balloon help.
;;;
(defparameter *pixmap-balloon-help*
  "Click left mouse button and drag to select region.
Click middle mouse button to zoom in to selected region.
Click right mouse button to zoom out by a factor of 2.")

;;;
;;; Color stuff.
;;;
(declaim (type simple-vector *default-color-values*))
(defparameter *default-color-values*
  #((  0     0     0)
    (200   204   188)
    (188   196   184)
    (176   184   180)
    (160   176   176)
    (148   164   168)
    (136   152   164)
    (120   144   160)
    (108   132   152)
    ( 96   120   148)
    ( 80   112   144)
    ( 68   100   136)
    ( 56    88   132)
    ( 40    80   128)
    ( 28    68   120)
    ( 16    56   116)
    (  0    44   108)
    ( 12    52   112)
    ( 24    64   116)
    ( 36    72   120)
    ( 52    84   128)
    ( 64    96   132)
    ( 76   104   136)
    ( 92   116   144)
    (104   128   148)
    (116   136   152)
    (132   148   160)
    (144   156   164)
    (156   168   168)
    (172   180   176)
    (184   188   180)
    (196   200   184)
    (212   212   192)
    (212   204   184)
    (212   192   176)
    (212   180   168)
    (212   168   160)
    (212   160   152)
    (212   148   144)
    (212   136   136)
    (208   124   128)
    (208   116   120)
    (208   104   112)
    (208    92   104)
    (208    80    96)
    (208    72    88)
    (208    60    80)
    (208    48    72)
    (204    36    60)
    (204    44    64)
    (204    56    72)
    (204    64    76)
    (204    76    84)
    (204    84    92)
    (204    96    96)
    (204   108   104)
    (208   116   112)
    (208   128   116)
    (208   136   124)
    (208   148   132)
    (208   156   136)
    (208   168   144)
    (212   180   152)
    (204   188   152)
    (192   196   156)
    (184   204   160)
    (172   212   164)
    (160   224   168)
    (152   224   172)
    (140   220   176)
    (128   220   184)
    (120   216   188)
    (108   212   196)
    ( 96   212   200)
    ( 88   208   208)
    ( 76   208   212)
    ( 64   204   220)
    ( 56   200   224)
    ( 44   200   232)
    ( 32   196   236)
    ( 20   192   244)
    ( 28   192   240)
    ( 36   192   236)
    ( 44   196   232)
    ( 52   196   228)
    ( 60   200   224)
    ( 68   200   220)
    ( 76   204   216)
    ( 84   204   212)
    ( 92   204   204)
    (100   208   200)
    (108   208   196)
    (116   212   192)
    (124   212   188)
    (132   216   184)
    (140   216   180)
    (148   220   176)
    (156   220   172)
    (168   224   164)
    (160   212   168)
    (152   200   172)
    (140   188   176)
    (132   172   184)
    (120   160   188)
    (112   148   192)
    (100   132   200)
    ( 92   120   204)
    ( 80   108   208)
    ( 72    96   212)
    ( 60    80   220)
    ( 52    68   224)
    ( 40    56   228)
    ( 32    40   236)
    ( 20    28   240)
    ( 12    16   244)
    (  0     0   252)
    ( 12    12   248)
    ( 24    28   244)
    ( 36    40   236)
    ( 48    56   232)
    ( 60    68   228)
    ( 72    84   220)
    ( 84    96   216)
    ( 96   112   208)
    (108   124   204)
    (120   140   200)
    (132   152   192)
    (144   168   188)
    (156   180   184)
    (168   196   176)
    (180   208   172)
    (196   224   164)
    (188   216   168)
    (176   208   172)
    (164   200   176)
    (152   188   184)
    (140   180   188)
    (128   172   192)
    (116   164   200)
    (104   152   204)
    ( 96   144   208)
    ( 84   136   216)
    ( 72   128   220)
    ( 60   116   224)
    ( 48   108   232)
    ( 36   100   236)
    ( 24    92   240)
    ( 12    80   248)
    (  0    72   252)
    ( 12    80   248)
    ( 24    88   244)
    ( 36    96   236)
    ( 48   104   232)
    ( 60   116   224)
    ( 72   124   220)
    ( 84   132   216)
    ( 96   140   208)
    (112   152   204)
    (124   160   196)
    (136   168   192)
    (148   176   188)
    (160   188   180)
    (172   196   176)
    (184   204   168)
    (196   212   164)
    (228   224   184)
    (216   212   180)
    (204   196   172)
    (192   184   168)
    (180   172   160)
    (168   160   156)
    (156   148   152)
    (140   132   144)
    (128   120   140)
    (116   108   136)
    (104    96   128)
    ( 92    80   124)
    ( 80    68   120)
    ( 68    56   112)
    ( 56    44   108)
    ( 40    32   104)
    ( 32    20   100)
    ( 40    32   104)
    ( 56    44   108)
    ( 68    56   112)
    ( 80    68   120)
    ( 92    80   124)
    (104    96   128)
    (116   108   136)
    (128   120   140)
    (140   132   144)
    (156   148   152)
    (168   160   156)
    (180   172   160)
    (192   184   168)
    (204   196   172)
    (216   212   180)
    (228   224   184)
    (232   220   180)
    (236   212   172)
    (240   204   168)
    (248   196   160)
    (248   192   148)
    (248   188   136)
    (244   184   124)
    (244   180   116)
    (244   180   104)
    (244   176    92)
    (240   172    80)
    (240   168    68)
    (240   164    60)
    (236   164    48)
    (236   160    36)
    (236   156    24)
    (232   152    16)
    (236   156    24)
    (236   160    36)
    (236   164    48)
    (240   164    60)
    (240   168    68)
    (240   172    80)
    (244   176    92)
    (244   180   104)
    (244   180   116)
    (244   184   124)
    (248   188   136)
    (248   192   148)
    (248   196   160)
    (252   196   172)
    (252   200   184)
    (240   200   180)
    (228   196   172)
    (216   196   168)
    (204   192   160)
    (196   184   152)
    (184   172   144)
    (172   160   132)
    (164   148   124)
    (152   140   116)
    (140   128   104)
    (128   116    96)
    (120   104    88)
    (108    92    76)
    ( 96    84    68)
    ( 88    72    60)
    ( 76    60    48)
    ( 64    48    40)
    ( 52    36    28)
    ( 60    44    36)
    ( 72    56    44)
    ( 84    68    56)
    (100    88    76)
    (120   112   100)
    (140   136   120)
    (160   156   144)
    (180   180   164)))


(defun get-color-index-of-color-values (i color-values)
  (let* ((color-triple (aref color-values i))
	 (red (/ (the fixnum (first color-triple)) 256))
	 (green (/ (the fixnum (second color-triple)) 256))
	 (blue (/ (the fixnum (third color-triple)) 256)))
    (gem:color-to-index 
     gem::*root-window* 
     (create-instance nil opal:color
       (:red red)
       (:green green)
       (:blue blue)))))


(defun create-colormap ()
  (setf *colormap* (make-array *max-colors* 
			       :initial-element (create-schema nil)
			       :element-type 'kr:schema))
  (dotimes (i *max-colors*)
    (setf (aref *colormap* i)
	  (get-color-index-of-color-values i *default-color-values*))))


;;;
;;; Initialize a plot window.
;;;
(defun init (&optional (title "Plot") (size *plot-xy*))
  (unless (and (boundp 'MANDELBROT-CANVAS) MANDELBROT-CANVAS)       ; Only do it once.

    (create-plot-window title size)
    (create-control-panel)
    (create-dialogs)

    (create-colormap)
      
    (create-feedback-rectangles)
    (create-interactors)
    (create-mouseline)
  ))

;;;
;;; Create rectangles used to select area to zoom.
;;;
(defun create-feedback-rectangles ()
  (unless (and (boundp 'MOVING-RECTANGLE) MOVING-RECTANGLE)
    (create-instance 'MOVING-RECTANGLE opal:rectangle
      (:box (list 0 0 0 0))
      (:left (o-formula (first (gvl :box))))
      (:top (o-formula (second (gvl :box))))
      (:width (o-formula (third (gvl :box))))
      (:height (o-formula (fourth (gvl :box))))
      (:line-style opal:white-line))
    (create-instance 'OUTLINE-RECTANGLE opal:rectangle
      (:line-style opal:white-line)
      (:visible nil)
      (:left 0)
      (:top 0)
      (:width 0)
      (:height 0)))
  (opal:add-components MANDELBROT-TOP-AGG MOVING-RECTANGLE OUTLINE-RECTANGLE))

;;;
;;; Create interactors that allow us to manipulate the plot.
;;;
(defun create-interactors ()
  ;; This lets us select an area of the plot to enlarge.
  (create-instance nil inter:two-point-interactor
    (:window MANDELBROT-CANVAS)
    (:start-event :leftdown)
    (:start-action #'(lambda (i p)
		       (declare (ignore i p))
		       (s-value OUTLINE-RECTANGLE :visible nil)
		       ))
    (:start-where T)
    (:final-function #'set-outline-rectangle)
    (:feedback-obj MOVING-RECTANGLE)
    (:line-p nil)
    (:Min-height 0)
    (:Min-width 0))

  ;; This starts the enlargement.
  (create-instance nil inter:button-interactor
    (:window MANDELBROT-CANVAS)
    (:start-event :middledown)
    (:start-where T)
    (:continuous nil)
    (:final-function #'zoom-in))

  ;; This zooms out by a factor of 2.
  (create-instance nil inter:button-interactor
    (:window MANDELBROT-CANVAS)
    (:start-event :rightdown)
    (:start-where T)
    (:continuous nil)
    (:final-function #'zoom-out))
  )


;;;
;;; Callbacks for interactors.
;;;

(declaim (inline mm))
(defun mm ()
  #+(and cmu garnet-processes) (mp:make-process #'m)
  #+:allegro (mp:process-run-function "Plotter" #'m)
  #+:sb-thread (sb-thread:make-thread #'m :name "Plotter")
  #+:ccl (ccl:process-run-function "Plotter" #'m)
  #-:garnet-processes (m)
)




(defun set-outline-rectangle (int box-list)
  (declare (ignore int))
  (when box-list
    (setf *box-list* box-list)
    (s-value OUTLINE-RECTANGLE :left (first box-list))
    (s-value OUTLINE-RECTANGLE :top (second box-list))
    (s-value OUTLINE-RECTANGLE :width (third box-list))
    (s-value OUTLINE-RECTANGLE :height (fourth box-list))
    (s-value OUTLINE-RECTANGLE :visible t)))


(defun zoom-in (int obj)
  (declare (ignore int obj))
  (s-value OUTLINE-RECTANGLE :visible nil)

  (let* ((x-point (+ (the fixnum (first *box-list*)) 
		     (floor (third *box-list*) 2)))
	 (y-point (+ (the fixnum (second *box-list*))
		     (floor (fourth *box-list*) 2)))
	 (plot-center (floor *plot-xy* 2))
	 (scale-factor (/ (* 2 *radius*) *plot-xy*))
	 (new-x-unscaled (- x-point plot-center))
	 (new-y-unscaled (- y-point plot-center)))
    (setf *radius* (* *radius* (/ (third *box-list*) *plot-xy*)))
    (setf *real-center*
	  (+ *real-center* (* new-x-unscaled scale-factor))
	  *imaginary-center*
	  (+ *imaginary-center* (* new-y-unscaled scale-factor))))
  (mm))


(defun zoom-out (int obj)
  (declare (ignore int obj))
  (s-value OUTLINE-RECTANGLE :visible nil)
  (setf *radius* (* *radius* 2.0l0))
  (mm))


(defparameter button-help
  `(("Reset Plot" "Reset plot to original Mandelbrot set.")
    ("Re-do Plot" "Re-do plot with same location and radius, maybe changed iterations.")
    ("Save Image" "Save plot image to XPM file.")
    ("Load Colors" "Load a colormap file to set colors.")
    ("Quit" "Quit Mandelbrot plotter.")))

(defparameter iter-help "Change number of iterations used to decide
whether a point is in the Mandelbrot set.")

(defparameter prop-help "Displays parameters for current display:
Real Center --- the location of the center of the plot on the real axis
Imaginary Center --- the location of the center of the plot on the imaginary axis
Radius --- the radius of the plot around the center.")

(defparameter indicator-help "Displays percentage of plot that has been completed.")

(defun create-pixmap (size)
  ;; Set up pixmap and pixarray
  (let ((width size)
	(height size))
    (create-instance 'MANDELBROT-PIXMAP opal:pixmap
      (:image (opal:create-pixmap-image width height))))
  (opal:add-component MANDELBROT-TOP-AGG MANDELBROT-PIXMAP :where :back)
  (setf MANDELBROT-PIXARRAY (g-value MANDELBROT-PIXMAP :pixarray))

  ;; Set up balloon help.
  (s-value MANDELBROT-PIXMAP :help-string *pixmap-balloon-help*))

(defun create-plot-window (title size)
  ;; Create window and aggregate.
  (create-instance 'MANDELBROT-CANVAS inter:interactor-window
    (:title title)
    (:width size)
    (:height (o-formula (gvl :width) size))
    (:left (floor (- gem:*screen-width* size) 2)) (:top 350)
    (:double-buffered-p t)
    (:foreground-color opal:blue)
    (:background-color opal:white))

  (s-value MANDELBROT-CANVAS :aggregate
	   (create-instance 'MANDELBROT-TOP-AGG opal:aggregate))

  (opal:update MANDELBROT-CANVAS)
  (setf *depth* (gem::x-window-depth MANDELBROT-CANVAS))

  (create-pixmap size))


(defun create-control-panel ()
  (unless (and (boundp 'CONTROL-WIN) 
	       CONTROL-WIN
	       (not (eq CONTROL-WIN 'kr::*destroyed*)))
    (create-instance 'CONTROL-WIN inter:interactor-window
      (:title "Control Window")
      (:width 500) (:height 300)
      (:left (floor (- gem:*screen-width* 500) 2)) (:top 20)
      (:foreground-color opal:black)
      (:background-color opal:motif-blue))

    (s-value CONTROL-WIN :aggregate
	     (create-instance 'CONTROL-WIN-TOP-AGG opal:aggregate))
    
    (opal:update CONTROL-WIN)

    (create-instance 'MANDELBROT-BANNER opal:text
      (:string "Mandelbrot Set Explorer"))
  
    (create-instance 'BUTTONS gg:motif-text-button-panel
;;;   (:font (opal:get-standard-font nil :bold :small))
      (:font (opal:get-standard-font :sans-serif :roman :small))
      ;; can't be constant since we want to center it.
      (:items '(("Reset Plot"   reset-plot)
		("Re-do Plot"   do-plot)
		("Save Image"   do-save)
		("Load Colors"  do-load-colors)
		("Quit" do-stop)))
      (:left (o-formula (- (round (gvl :parent :window :width) 2)
			   (round (gvl :width) 2))))
      (:top 5)
      (:h-align :center)
      (:direction :horizontal)
      )

    (s-value CONTROL-WIN :width (+ 5 (g-value BUTTONS :width)))
    (opal:update CONTROL-WIN)
  
    ;; set up help strings for the mouseline gadget.
    (dolist (button (g-value buttons :button-list :components))
      (s-value button :help-string (cadr (assoc (g-value button :string)
						button-help
						:test #'string=))))
    (create-instance 'SLIDER-LABEL opal:text
      (:left (o-formula (- (the fixnum (round (gvl :parent :window :width) 2))
			   (the fixnum (round (gvl :width) 2)))))
      (:top (o-formula (+ (the fixnum (opal:gv-bottom buttons)) 15)))
      (:string "Iterations"))

    (create-instance 'SLIDER gg:motif-h-scroll-bar
      (:constant T :except :foreground-color)
      (:left (o-formula (- (round (gvl :parent :window :width) 2)
			   (round (gvl :width) 2))))
      (:top (o-formula (+ (opal:gv-bottom slider-label) 5)))
      (:h-align :center)
      (:val-1 *max-colors*)
      (:val-2 *max-iterations*)
      (:scr-incr 100)
      (:percent-visible .05)
      (:active-p T)
      (:selection-function
       #'(lambda (gadget value)
	   (declare (ignore gadget))
	   (setf *iterations* value))))

    (s-value slider :help-string iter-help)

    (create-instance 'ITERATION-TEXT opal:text
      (:left (o-formula (- (round (gvl :parent :window :width) 2)
			   (round (gvl :width) 2))))
      (:top (o-formula (+ (opal:gv-bottom slider) 5)))
      (:string (o-formula (format nil "~D" (gv slider :value)))))
     
    (create-instance 'PROP gg:prop-sheet
      (:left (o-formula (ceiling (gvl :parent :window :width) 10)))
      (:width (o-formula (- (gvl :parent :window :width) 50)))
      (:top (o-formula (+ (opal:gv-bottom iteration-text) 15)))
      (:items
       `(("Real Center" ,(o-formula (format nil "~A" *real-center*)))
	 ("Imaginary Center" ,(o-formula (format nil "~A" *imaginary-center*)))
	 ("Radius" ,(o-formula (format nil "~A" *radius*))))))

    (s-value PROP :help-string prop-help)
  
    (create-instance 'INDICATOR gg:motif-h-scroll-bar
      (:left (o-formula (- (round (gvl :parent :window :width) 2)
			   (round (gvl :width) 2))))
      (:top (o-formula (+ (opal:gv-bottom prop) 15)))
      (:h-align :center)
      (:val-1 0)
      (:val-2 *plot-xy*)
      (:scr-incr 100)
      (:scr-trill-p nil)
      (:percent-visible 0.0)
      (:active-p T))

    (s-value INDICATOR :help-string indicator-help)

    (create-instance 'INDICATOR-TEXT opal:text
	    (:left (o-formula (- (round (gvl :parent :window :width) 2)
				 (round (gvl :width) 2))))
	    (:top (o-formula (+ (opal:gv-bottom indicator) 5)))
	    (:string "Percent Complete: 0"))

    (opal:add-components CONTROL-WIN-TOP-AGG
			 BUTTONS
			 SLIDER-LABEL SLIDER ITERATION-TEXT
			 PROP
			 INDICATOR INDICATOR-TEXT)
    (opal:update CONTROL-WIN)))


(defun create-dialogs ()
  (create-instance 'SAVE-IMAGE-DIALOG gg:motif-save-gadget
    (:parent-window MANDELBROT-CANVAS)
    (:query-message "replace existing file")
    (:modal-p t)
    (:selection-function #'save-xpm))

  (create-instance 'LOAD-CMAP-DIALOG gg:motif-load-gadget
    (:min-gadget-width 250)
    (:top 20)
    (:parent-window CONTROL-WIN)
    (:selection-function #'setup-colormap-from-file)
    (:modal-p T)
    (:check-filenames-p t)
    (:parts
     `(:dir-input
       :file-menu
       :file-input
       :message
       (:text ,opal:text
	      (:constant T :except :string)
	      (:left 10) (:top 10)
	      (:font ,(opal:get-standard-font NIL :bold-italic :large))
	      )
	     
       (:OK-cancel-buttons :modify
			   (:top ,(o-formula (+ (gvl :parent :file-input :top)
						(gvl :parent :file-input :height)
						20))))))
    ))


(defun create-mouseline ()
  (create-instance 'MOUSELINE gg:mouselinepopup
    (:wait-amount 1)
    (:windows `(,MANDELBROT-CANVAS ,CONTROL-WIN))))

(declaim (inline update-iterations-scroll))
(defun update-iterations-scroll ()
  (s-value SLIDER :value *iterations*))

(defun update-propsheet ()
  (gg:reusepropsheet
   PROP
   `(("Real Center" ,(o-formula (format nil "~A" *real-center*)))
     ("Imaginary Center" ,(o-formula (format nil "~A" *imaginary-center*)))
     ("Radius" ,(o-formula (format nil "~A" *radius*))))))


(defun update-indicator (current)
  (declare (fixnum current))
  (let ((done (float (/ current *plot-xy*))))
    (s-value INDICATOR :percent-visible done)
    (s-value INDICATOR-TEXT :string
	     (format nil "Percent Complete: ~D"
		     (ceiling (* done 100))))))



#+:cmu
(declaim (ext:start-block m))

;;;
;;; Function to plot a point in the pixmap.
;;;
(declaim (inline plot-point))
(defun plot-point (x y color)
  (declare (optimize (speed 3) (safety 0) (space 0)))
  (declare (fixnum x y color))
  (setf (aref MANDELBROT-PIXARRAY y x) color))

(declaim (inline f))
(defun f (i)
  (declare (fixnum i))
#+cmu  (declare (values fixnum))
  (let ((scale (/ *iterations* *max-colors*)))
    (aref *colormap* (floor i scale ))))

(defun tst (k rec imc)
  (declare (fixnum k)
	   (long-float rec imc))
#+cmu  (declare (values fixnum))
  (declare (optimize (speed 3) (safety 0) (space 0)))
  (let ((re rec)
	(im imc))
    (declare (long-float re im))
    (dotimes (j (- k 2) 0)
      (declare (fixnum j))
      (let ((re2 (* re re))
	    (im2 (* im im)))
	(declare (long-float re2 im2))
	(when (> (+ re2 im2) 256)
	  (return-from tst (f j)))
	(setf im (+ (* 2 re im) imc)
	      re (+ (- re2 im2) rec))))))


;;;
;;;  Function M  is called to calculate the Mandelbrot set
;;; for complex points around the complex number zero.
;;;

(defun M ()
  (declare (optimize (speed 3) (safety 0) (space 0)))
  ;; Set up window stuff.
  (init "Mandelbrot Plot" *plot-xy*)
  (opal:raise-window MANDELBROT-CANVAS)

  ;; Do the plot.
  (opal:with-hourglass-cursor
   (let* ((w *plot-xy*)
	  (half-w (truncate w 2))
	  (r *radius*)
	  (s (* 2.0l0 (/ r w)))
	  (recen *real-center*)
	  (imcen *imaginary-center*)
	  (k *iterations*))
     (declare (fixnum w k)
	      (long-float r s recen imcen))

     (update-iterations-scroll)
     (update-propsheet)
     (opal:update CONTROL-WIN)

     (dotimes (y w)
       (declare (fixnum y))
       (update-indicator y)
       (opal:update CONTROL-WIN)
       #+(and :cmu :garnet-processes) (mp:process-yield)
       (dotimes (x w)
	 (declare (fixnum x))
	 (let ((rec (+ (* s (- x half-w)) recen))
	       (imc (+ (* s (- y half-w)) imcen)))
	   (declare (long-float rec imc))
	   (plot-point x y (tst k rec imc))))))
   (opal:update MANDELBROT-CANVAS t)
   (opal:update CONTROL-WIN t)))


#+cmu
(declaim (ext:end-block))

(defun do-stop (g v)
  (declare (ignore g v))
  (kr-send MOUSELINE :destroy-me MOUSELINE)
  (opal:destroy CONTROL-WIN)
  (opal:destroy MANDELBROT-CANVAS)
  (setf CONTROL-WIN nil)
  (setf MANDELBROT-CANVAS nil)
  (setf MOVING-RECTANGLE nil)
  )


(defun do-start (&optional (size *plot-xy* argsupplied))
  (when argsupplied
    (setf *plot-xy* size))
  (setf *radius* 2.0l0)
  (setf *real-center* -0.5l0)
  (setf *imaginary-center* 0.0l0)
  (setf *iterations* *initial-iterations*)
  (m)
  )

(defun reset-plot (&optional g v)
  (declare (ignore g v))
  (setf *radius* 2.0l0)
  (setf *real-center* -0.5l0)
  (setf *imaginary-center* 0.0l0)
  (setf *iterations* *initial-iterations*)
  (mm)
)

(defun do-plot (g v)
  (declare (ignore g v))
  (mm))

(defvar *last-filename* "mand.xpm")

(defun save-xpm (gadget filename)
  (declare (ignore gadget))
  (opal:with-hourglass-cursor
   (opal:write-xpm-file MANDELBROT-PIXMAP filename))
  (setf *last-filename* filename)
)


(defun do-save (gadgets-object item-string)
  (declare (ignore gadgets-object item-string))
  (gg:display-save-gadget-and-wait SAVE-IMAGE-DIALOG *last-filename*)
  (opal:update-all t))


(defun do-load-colors (gadgets-object item-string)
  (declare (ignore gadgets-object item-string))
  (gg:display-load-gadget-and-wait LOAD-CMAP-DIALOG)
  (opal:update CONTROL-WIN T)
  (do-plot nil nil)
  (opal:update-all t))


(defun determine-divisor (filename)
  (let ((namestring (namestring filename)))
    (if (string= "map" namestring :start2 (- (length namestring) 3))
	65536
	256
	)))


(defun setup-colormap-from-file (g v)
  (declare (ignore g))
  (let* ((filename v)
	 (divisor (determine-divisor filename))
	 (i 0))
    (with-open-file (f filename)
      (loop
	 (let ((line (read-line f nil nil))
	       trimmed-line
	       red green blue
	       next)
	   (when (or (not line)
		     (equal (setf trimmed-line (string-trim '(#\space) line)) ""))
	     (return))
	   (multiple-value-setq (red next)
	     (parse-integer trimmed-line :junk-allowed t))
	   (unless red
	     (return))
	   (multiple-value-setq (green next) 
	     (parse-integer trimmed-line :start next :junk-allowed t))
	   (unless green
	     (return))
	   (setf blue (parse-integer trimmed-line :start next :junk-allowed t))
	   (setf (aref *colormap* i)
		 (gem:color-to-index
		  gem::*root-window*
		  (create-instance nil opal:color
		    (:red (/ red divisor))
		    (:green (/ green divisor))
		    (:blue (/ blue divisor))))))
	 (incf i)))
    (opal:update CONTROL-WIN)))

#+(and cmu notdefined)
(defun save-fmand ()
  (flet ((fmand-top-level ()
	   (fm:do-start)
	   (lisp::%top-level)))
    (opal:make-image "fmand" :executable t :init-function #'fmand-top-level)
  ))


