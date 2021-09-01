;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: LAPIDARY-DIALOGS; Base: 10 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         The Garnet User Interface Development Environment.      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This code was written as part of the Garnet project at          ;;;
;;; Carnegie Mellon University, and has been placed in the public   ;;;
;;; domain.  If you are using this code or any part of Garnet,      ;;;
;;; please contact garnet@cs.cmu.edu to be put on the mailing list. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; this file contains the formulas that can be attached to objects
;;; using the line constraint menu
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Change Log
;;;
;;; 5/10/93 bvz Created
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package "LAPIDARY-DIALOGS")

(eval-when (:execute :load-toplevel :compile-toplevel)
  (export '(*x1-to-box-left* *x1-to-box-center* *x1-to-box-right*
	    *x2-to-box-left* *x2-to-box-center* *x2-to-box-right*
	    *y1-to-box-top* *y1-to-box-center* *x1-to-box-bottom*
	    *y2-to-box-top* *y2-to-box-center* *x2-to-box-bottom*
	    *x1-to-circle-left-corner* *x1-to-circle-right-corner*
	    *x2-to-circle-left-corner* *x2-to-circle-right-corner*)))


(eval-when (:execute :load-toplevel :compile-toplevel)
  (import '(opal:half opal:q-min)))

;; line-to-line constraints 
(defvar *x1-to-x1*
  (o-formula (+ (gvl-fixnum :x1-over :x1) (gvl-fixnum :x1-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *x1-to-x2*
  (o-formula (+ (gvl-fixnum :x1-over :x2) (gvl-fixnum :x1-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *x2-to-x1*
  (o-formula (+ (gvl-fixnum :x2-over :x1) (gvl-fixnum :x2-offset))
	     0
	     (:menu-item (cons 2 0))))
(defvar *x2-to-x2*
  (o-formula (+ (gvl-fixnum :x2-over :x2) (gvl-fixnum :x2-offset))
	     0
	     (:menu-item (cons 2 2))))

(defvar *y1-to-y1*
  (o-formula (+ (gvl-fixnum :y1-over :y1) (gvl-fixnum :y1-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *y1-to-y2* 
  (o-formula (+ (gvl-fixnum :y1-over :y2) (gvl-fixnum :y1-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *y2-to-y1*
  (o-formula (+ (gvl-fixnum :y2-over :y1) (gvl-fixnum :y2-offset))
	     0
	     (:menu-item (cons 2 0))))
(defvar *y2-to-y2* 
  (o-formula (+ (gvl-fixnum :y2-over :y2) (gvl-fixnum :y2-offset))
	     0
	     (:menu-item (cons 2 2))))

;; line-to-box constraints 
(defvar *x1-to-box-left*
  (o-formula (+ (gvl-fixnum :x1-over :left) (gvl-fixnum :x1-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *x1-to-box-center* 
  (o-formula (+ (opal:gv-center-x (gvl-fixnum :x1-over))
		(gvl-fixnum :x1-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *x1-to-box-right* 
  (o-formula (+ (opal:gv-right (gvl-fixnum :x1-over))
		(gvl-fixnum :x1-offset))
	     0
	     (:menu-item (cons 0 2))))

(defvar *x2-to-box-left*
  (o-formula (+ (gvl-fixnum :x2-over :left) (gvl-fixnum :x2-offset))
	     0
	     (:menu-item (cons 2 0))))
(defvar *x2-to-box-center*
  (o-formula (+ (opal:gv-center-x (gvl-fixnum :x2-over))
		(gvl-fixnum :x2-offset))
	     0
	     (:menu-item (cons 2 1))))
(defvar *x2-to-box-right*
  (o-formula (+ (opal:gv-right (gvl-fixnum :x2-over))
		(gvl-fixnum :x2-offset))
	     0
	     (:menu-item (cons 2 2))))

(defvar *y1-to-box-top*
  (o-formula (+ (gvl-fixnum :y1-over :top) (gvl-fixnum :y1-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *y1-to-box-center* 
  (o-formula (+ (opal:gv-center-y (gvl-fixnum :y1-over))
		(gvl-fixnum :y1-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *y1-to-box-bottom*
  (o-formula (+ (opal:gv-bottom (gvl-fixnum :y1-over))
		(gvl-fixnum :y1-offset))
	     0
	     (:menu-item (cons 0 2))))

(defvar *y2-to-box-top*
  (o-formula (+ (gvl-fixnum :y2-over :top) (gvl-fixnum :y2-offset))
	     0
	     (:menu-item (cons 2 0))))
(defvar *y2-to-box-center*
  (o-formula (+ (opal:gv-center-y (gvl-fixnum :y2-over))
		(gvl-fixnum :y2-offset))
	     0
	     (:menu-item (cons 2 1))))
(defvar *y2-to-box-bottom*
  (o-formula (+ (opal:gv-bottom (gvl-fixnum :y2-over))
		(gvl-fixnum :y2-offset))
	     0
	     (:menu-item (cons 2 2))))

;; line-to-circle constraints 
(defvar *x1-to-circle-left-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :x1-over :width)
					(gvl-fixnum :x1-over :height)))))
	       (round (+ (gvl-fixnum :x1-over :left)
			 (* radius ,135deg)
			 (gvl-fixnum :x1-offset))))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *x1-to-circle-right-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :x1-over :width)
					(gvl-fixnum :x1-over :height)))))
	       (round (+ (gvl-fixnum :x1-over :left)
			 (* radius ,45deg)
			 (gvl-fixnum :x1-offset))))
	    0
	    (:menu-item (cons 0 2)))))

(defvar *x2-to-circle-left-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :x2-over :width)
					(gvl-fixnum :x2-over :height)))))
	       (round (+ (gvl-fixnum :x2-over :left)
			 (* radius ,135deg)
			 (gvl-fixnum :x2-offset))))
	    0
	    (:menu-item (cons 2 0)))))
(defvar *x2-to-circle-right-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :x2-over :width)
					(gvl-fixnum :x2-over :height)))))
	       (round (+ (gvl-fixnum :x2-over :left)
			 (* radius ,45deg)
			 (gvl-fixnum :x2-offset))))
	    0
	    (:menu-item (cons 2 2)))))

(defvar *y1-to-circle-top-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :y1-over :width)
					(gvl-fixnum :y1-over :height)))))
	       (round (+ (gvl-fixnum :y1-over :top)
			 (* radius ,135deg)
			 (gvl :y1-offset))))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *y1-to-circle-bottom-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :y1-over :width)
					(gvl-fixnum :y1-over :height)))))
	       (round (+ (gvl-fixnum :y1-over :top)
			 (* radius ,45deg)
			 (gvl-fixnum :y1-offset))))
	    0
	    (:menu-item (cons 0 2)))))

(defvar *y2-to-circle-top-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :y2-over :width)
				      (gvl-fixnum :y2-over :height)))))
	       (round (+ (gvl-fixnum :y2-over :top)
			 (* radius ,135deg)
			 (gvl-fixnum :y2-offset))))
	    0
	    (:menu-item (cons 2 0)))))
(defvar *y2-to-circle-bottom-corner* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :y2-over :width)
				      (gvl-fixnum :y2-over :height)))))
	       (round (+ (gvl-fixnum :y2-over :top)
			 (* radius ,45deg)
			 (gvl-fixnum :y2-offset))))
	    0
	    (:menu-item (cons 2 2)))))

;; line-to-roundtangle constraints 
(defvar *x1-to-roundtangle-left-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (gvl-fixnum :x1-over :left) 
			  (* (gvl :x1-over :draw-radius) ,135deg)
			  (gvl :x1-offset)))
			    0
			    (:menu-item (cons 0 0)))))
(defvar *x1-to-roundtangle-right-corner*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (opal:gv-right (gvl-fixnum :x1-over))
			  (* (gvl :x1-over :draw-radius) ,135deg))
		       (gvl-fixnum :x1-offset)))
	    0
	    (:menu-item (cons 0 2)))))

(defvar *x2-to-roundtangle-left-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (gvl-fixnum :x2-over :left) 
			  (* (gvl :x2-over :draw-radius) ,135deg)
			  (gvl :x2-offset)))
			    0
			    (:menu-item (cons 2 0)))))
(defvar *x2-to-roundtangle-right-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (- (opal:gv-right (gvl :x2-over))
			     (* (gvl :x2-over :draw-radius) ,135deg))
			  (gvl :x2-offset)))
			    0
			    (:menu-item (cons 2 2)))))

(defvar *y1-to-roundtangle-top-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (gvl-fixnum :y1-over :top) 
			  (* (gvl :y1-over :draw-radius) ,135deg)
			  (gvl :y1-offset)))
			    0
			    (:menu-item (cons 0 0)))))
(defvar *y1-to-roundtangle-bottom-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (- (opal:gv-bottom (gvl :y1-over))
			     (* (gvl :y1-over :draw-radius) ,135deg))
			  (gvl :y1-offset)))
			    0
			    (:menu-item (cons 0 2)))))

(defvar *y2-to-roundtangle-top-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (gvl-fixnum :y2-over :top) 
			  (* (gvl :y2-over :draw-radius) ,135deg)
			  (gvl :y2-offset)))
			    0
			    (:menu-item (cons 2 0)))))
(defvar *y2-to-roundtangle-bottom-corner*
  (kr::make-into-o-formula 
      (formula `(round (+ (- (opal:gv-bottom (gvl :y2-over))
			     (* (gvl :y2-over :draw-radius) ,135deg))
			  (gvl :y2-offset)))
			    0
			    (:menu-item (cons 2 2)))))

;; box-to-line constraints 
(defvar *box-left-to-x1* 
  (o-formula (+ (gvl-fixnum :left-over :x1)
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *box-center-to-x1*
  (o-formula (+ (- (gvl-fixnum :left-over :x1)
		   (half (gvl-fixnum :width)))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 1 0))))
(defvar *box-right-to-x1*
  (o-formula (+ (- (gvl-fixnum :left-over :x1)
		   (gvl-fixnum :width))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 2 0))))

(defvar *box-left-to-line-center* 
  (o-formula (+ (opal:gv-center-x 
		 (gvl-fixnum :left-over))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 0 1))))

(defvar *box-center-x-to-line-center* 
  (o-formula (+ (opal:gv-center-x-is-center-of (gvl-fixnum :left-over))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 1 1))))

(defvar *box-right-to-line-center* 
  (o-formula (- (+ (opal:gv-center-x (gvl-fixnum :left-over))
		   (gvl :left-offset))
		(gvl-fixnum :width))
	     0
	     (:menu-item (cons 2 1))))
  
(defvar *box-left-to-x2*
  (o-formula (+ (gvl-fixnum :left-over :x2)
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *box-center-to-x2*
  (o-formula (+ (- (gvl-fixnum :left-over :x2)
		   (half (gvl-fixnum :width)))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 1 2))))
(defvar *box-right-to-x2* 
  (o-formula (+ (- (gvl-fixnum :left-over :x2)
		   (gvl-fixnum :width))
		(gvl-fixnum :left-offset))
	     0
	     (:menu-item (cons 2 2))))

(defvar *box-top-to-y1*
  (o-formula (+ (gvl-fixnum :top-over :y1)
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 0 0))))
(defvar *box-center-to-y1*
  (o-formula (+ (- (gvl-fixnum :top-over :y1)
		   (half (gvl-fixnum :height)))
		(gvl :top-offset))
	     0
	     (:menu-item (cons 1 0))))
(defvar *box-bottom-to-y1*
  (o-formula (+ (- (gvl-fixnum :top-over :y1)
		   (gvl-fixnum :height))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 2 0))))

(defvar *box-top-to-line-center* 
  (o-formula (+ (opal:gv-center-y (gvl :top-over))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 0 1))))
(defvar *box-center-y-to-line-center* 
  (o-formula (+ (opal:gv-center-y-is-center-of (gvl-fixnum :top-over))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 1 1))))
(defvar *box-bottom-to-line-center* 
  (o-formula (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
		   (gvl-fixnum :height))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 2 1))))

(defvar *box-top-to-y2*
  (o-formula (+ (gvl-fixnum :top-over :y2)
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 0 2))))
(defvar *box-center-to-y2*
  (o-formula (+ (- (gvl-fixnum :top-over :y2)
		   (half (gvl-fixnum :height)))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 1 2))))
(defvar *box-bottom-to-y2*
  (o-formula (+ (- (gvl-fixnum :top-over :y2)
		   (gvl-fixnum :height))
		(gvl-fixnum :top-offset))
	     0
	     (:menu-item (cons 2 2))))

;; circle-to-line constraints
(defvar *circle-left-corner-to-x1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :left-over :x1)
			    (* radius ,135deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *circle-center-to-x1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (gvl-fixnum :left-over :x1)
		     radius)
		  (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 1 0)))))
(defvar *circle-right-corner-to-x1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
				       (gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :left-over :x1)
			    (* radius ,45deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 2 0)))))


(defvar *circle-left-corner-to-line-center* 
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (opal:gv-center-x (gvl-fixnum :left-over))
			    (* radius ,135deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 0 1)))))

(defvar *circle-center-x-to-line-center*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (opal:gv-center-x (gvl-fixnum :left-over))
		     radius)
		  (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 1 1)))))
(defvar *circle-right-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (opal:gv-center-x (gvl-fixnum :left-over))
			    (* radius ,45deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 2 1)))))

(defvar *circle-left-corner-to-x2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :left-over :x2)
			    (* radius ,135deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 0 2)))))
(defvar *circle-center-to-x2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (gvl-fixnum :left-over :x2)
		     radius)
		  (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 1 2)))))
(defvar *circle-right-corner-to-x2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :left-over :x2)
			    (* radius ,45deg))
			 (gvl-fixnum :left-offset))))
	    0
	    (:menu-item (cons 2 2)))))

(defvar *circle-top-corner-to-y1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :top-over :y1)
			    (* radius ,135deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *circle-center-to-y1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (gvl-fixnum :top-over :y1)
		     radius)
		  (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 1 0)))))
(defvar *circle-bottom-corner-to-y1*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :top-over :y1)
			    (* radius ,45deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 2 0)))))

(defvar *circle-top-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
			    (* radius ,135deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 0 1)))))
(defvar *circle-center-y-to-line-center*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
		     radius)
		  (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 1 1)))))
(defvar *circle-bottom-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
			    (* radius ,45deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 2 1)))))

(defvar *circle-top-corner-to-y2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl :width)
					(gvl :height)))))
	       (round (+ (- (gvl-fixnum :top-over :y2)
			    (* radius ,135deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 0 2)))))
(defvar *circle-center-to-y2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (+ (- (gvl-fixnum :top-over :y2)
		     radius)
		  (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 1 2)))))
(defvar *circle-bottom-corner-to-y2*
  (kr::make-into-o-formula 
   (formula `(let ((radius (half (q-min (gvl-fixnum :width)
					(gvl-fixnum :height)))))
	       (round (+ (- (gvl-fixnum :top-over :y2)
			    (* radius ,45deg))
			 (gvl-fixnum :top-offset))))
	    0
	    (:menu-item (cons 2 2)))))

;; roundtangle-to-line constraints
(defvar *roundtangle-left-corner-to-x1*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :left-over :x1)
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *roundtangle-right-corner-to-x1*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :left-over :x1) 
			  (gvl-fixnum :width))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 2 0)))))

(defvar *roundtangle-left-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (opal:gv-center-x (gvl-fixnum :left-over))
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 0 1)))))
(defvar *roundtangle-right-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (opal:gv-center-x (gvl-fixnum :left-over))
			  (gvl-fixnum :width))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 2 1)))))

(defvar *roundtangle-left-corner-to-x2*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :left-over :x2)
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 0 2)))))
(defvar *roundtangle-right-corner-to-x2*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :left-over :x2) 
			  (gvl-fixnum :width))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :left-offset)))
	    0
	    (:menu-item (cons 2 2)))))

(defvar *roundtangle-top-corner-to-y1*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :top-over :y1)
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 0 0)))))
(defvar *roundtangle-bottom-corner-to-y1*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :top-over :y1) 
			  (gvl-fixnum :height))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 2 0)))))

(defvar *roundtangle-top-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 0 1)))))
(defvar *roundtangle-bottom-corner-to-line-center*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (opal:gv-center-y (gvl-fixnum :top-over))
			  (gvl-fixnum :height))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 2 1)))))

(defvar *roundtangle-top-corner-to-y2*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :top-over :y2)
			  (* (gvl :draw-radius) ,135deg))
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 0 2)))))
(defvar *roundtangle-bottom-corner-to-y2*
  (kr::make-into-o-formula 
   (formula `(round (+ (- (gvl-fixnum :top-over :y2) 
			  (gvl-fixnum :height))
		       (* (gvl :draw-radius) ,135deg)
		       (gvl-fixnum :top-offset)))
	    0
	    (:menu-item (cons 2 2)))))

;;; vectors of constraints that are passed to attach-constraint. The
;;; button chosen by the user in a constraint menu has an index
;;; associated with it that chooses a formula in the formula vector

(defvar *x1-to-line* 
  (make-array 2 :initial-contents (list *x1-to-x1* *x1-to-x2*)))
(defvar *x2-to-line* 
  (make-array 2 :initial-contents (list *x2-to-x1* *x2-to-x2*)))

(defvar *y1-to-line* 
  (make-array 2 :initial-contents (list *y1-to-y1* *y1-to-y2*)))
(defvar *y2-to-line* 
  (make-array 2 :initial-contents (list *y2-to-y1* *y2-to-y2*)))

(defvar *line-to-box*
  (make-array '(3 2) 
	      :initial-contents
	      `((((,*x1-to-circle-left-corner*
		   ,*x1-to-box-left*
		   ,*x1-to-circle-left-corner*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-circle-right-corner*
		   ,*x1-to-box-right*
		   ,*x1-to-circle-right-corner*)
		  ,*y1-to-circle-top-corner*
		  ,*y1-to-box-center*
		  ,*y1-to-circle-bottom-corner*
		  ,*y1-to-box-top*
		  ,*y1-to-box-center*
		  ,*y1-to-box-bottom*
		  ,*y1-to-circle-top-corner*
		  ,*y1-to-box-center*
		  ,*y1-to-circle-bottom-corner*)
		 ((,*x2-to-circle-left-corner*
		   *x2-to-box-left*
		   *x2-to-circle-left-corner*
		   *x2-to-box-center*
		   *x2-to-box-center*
		   *x2-to-box-center*
		   *x2-to-circle-right-corner*
		   *x2-to-box-right*
		   *x2-to-circle-right-corner*)
		  ,*y2-to-circle-top-corner*
		  *y2-to-box-center*
		  *y2-to-circle-bottom-corner*
		  *y2-to-box-top*
		  *y2-to-box-center*
		  *y2-to-box-bottom*
		  *y2-to-circle-top-corner*
		  *y2-to-box-center*
		  *y2-to-circle-bottom-corner*))
		(((,*x1-to-roundtangle-left-corner*
		   ,*x1-to-box-left*
		   ,*x1-to-roundtangle-left-corner*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-roundtangle-right-corner*
		   ,*x1-to-box-right*
		   ,*x1-to-roundtangle-right-corner*)
		  ,*y1-to-roundtangle-top-corner*
		  ,*y1-to-box-center*
		  ,*y1-to-roundtangle-bottom-corner*
		  ,*y1-to-box-top*
		  ,*y1-to-box-center*
		  ,*y1-to-box-bottom*
		  ,*y1-to-roundtangle-top-corner*
		  ,*y1-to-box-center*
		  ,*y1-to-roundtangle-bottom-corner*)
		 ((,*x2-to-roundtangle-left-corner*
		   ,*x2-to-box-left*
		   ,*x2-to-roundtangle-left-corner*
		   ,*x2-to-box-center*
		   ,*x2-to-box-center*
		   ,*x2-to-box-center*
		   ,*x2-to-roundtangle-right-corner*
		   ,*x2-to-box-right*
		   *x2-to-roundtangle-right-corner*)
		  ,*y2-to-roundtangle-top-corner*
		  ,*y2-to-box-center*
		  ,*y2-to-roundtangle-bottom-corner*
		  ,*y2-to-box-top*
		  ,*y2-to-box-center*
		  ,*y2-to-box-bottom*
		  ,*y2-to-roundtangle-top-corner*
		  ,*y2-to-box-center*
		  *y2-to-roundtangle-bottom-corner*))
		(((,*x1-to-box-left*
		   ,*x1-to-box-left*
		   ,*x1-to-box-left*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-box-center*
		   ,*x1-to-box-right*
		   ,*x1-to-box-right*
		   ,*x1-to-box-right*)
		  ,*y1-to-box-top*
		  ,*y1-to-box-center*
		  ,*y1-to-box-bottom*
		  ,*y1-to-box-top*
		  ,*y1-to-box-center*
		  ,*y1-to-box-bottom*
		  ,*y1-to-box-top*
		  ,*y1-to-box-center*
		  ,*y1-to-box-bottom*)
		 ((,*x2-to-box-left*
		   ,*x2-to-box-left*
		   ,*x2-to-box-left*
		   ,*x2-to-box-center*
		   ,*x2-to-box-center*
		   ,*x2-to-box-center*
		   ,*x2-to-box-right*
		   ,*x2-to-box-right*
		   ,*x2-to-box-right*)
		  ,*y2-to-box-top*
		  ,*y2-to-box-center*
		  ,*y2-to-box-bottom*
		  ,*y2-to-box-top*
		  ,*y2-to-box-center*
		  ,*y2-to-box-bottom*
		  ,*y2-to-box-top*
		  ,*y2-to-box-center*
		  ,*y2-to-box-bottom*)))))

(defvar *box-to-line*
  (make-array '(3 3)
	      :initial-contents
	      `((((,*circle-left-corner-to-x1*
		   ,*box-left-to-x1*
		   ,*circle-left-corner-to-x1*
		   ,*circle-center-to-x1*
		   ,*circle-center-to-x1*
		   ,*circle-center-to-x1*
		   ,*circle-right-corner-to-x1*
		   ,*box-right-to-x1*
		   ,*circle-right-corner-to-x1*)
		  ,*circle-top-corner-to-y1*
		  ,*circle-center-to-y1*
		  ,*circle-bottom-corner-to-y1*
		  ,*box-top-to-y1*
		  ,*circle-center-to-y1*
		  ,*box-bottom-to-y1*
		  ,*circle-top-corner-to-y1*
		  ,*circle-center-to-y1*
		  ,*circle-bottom-corner-to-y1*)
		 ((,*circle-left-corner-to-line-center*
		   ,*box-left-to-line-center*
		   ,*circle-left-corner-to-line-center*
		   ,*circle-center-x-to-line-center*
		   ,*circle-center-x-to-line-center*
		   ,*circle-center-x-to-line-center*
		   ,*circle-right-corner-to-line-center*
		   ,*box-right-to-line-center*
		   ,*circle-right-corner-to-line-center*)
		  ,*circle-top-corner-to-line-center*
		  ,*circle-center-y-to-line-center*
		  ,*circle-bottom-corner-to-line-center*
		  ,*box-top-to-line-center*
		  ,*circle-center-y-to-line-center*
		  ,*box-bottom-to-line-center*
		  ,*circle-top-corner-to-line-center*
		  ,*circle-center-y-to-line-center*
		  ,*circle-bottom-corner-to-line-center*)
		 ((,*circle-left-corner-to-x2*
		   ,*box-left-to-x2*
		   ,*circle-left-corner-to-x2*
		   ,*circle-center-to-x2*
		   ,*circle-center-to-x2*
		   ,*circle-center-to-x2*
		   ,*circle-right-corner-to-x2*
		   ,*box-right-to-x2*
		   ,*circle-right-corner-to-x2*)
		  ,*circle-top-corner-to-y2*
		  ,*circle-center-to-y2*
		  ,*circle-bottom-corner-to-y2*
		  ,*box-top-to-y2*
		  ,*circle-center-to-y2*
		  ,*box-bottom-to-y2*
		  ,*circle-top-corner-to-y2*
		  ,*circle-center-to-y2*
		  ,*circle-bottom-corner-to-y2*))
		(((,*roundtangle-left-corner-to-x1*
		   ,*box-left-to-x1*
		   ,*roundtangle-left-corner-to-x1*
		   ,*box-center-to-x1*
		   ,*box-center-to-x1*
		   ,*box-center-to-x1*
		   ,*roundtangle-right-corner-to-x1*
		   ,*box-right-to-x1*
		   ,*roundtangle-right-corner-to-x1*)
		  ,*roundtangle-top-corner-to-y1*
		  ,*box-center-to-y1*
		  ,*roundtangle-bottom-corner-to-y1*
		  ,*box-top-to-y1*
		  ,*box-center-to-y1*
		  ,*box-bottom-to-y1*
		  ,*roundtangle-top-corner-to-y1*
		  ,*box-center-to-y1*
		  ,*roundtangle-bottom-corner-to-y1*)
		 ((,*roundtangle-left-corner-to-line-center*
		   ,*box-left-to-line-center*
		   ,*roundtangle-left-corner-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*roundtangle-right-corner-to-line-center*
		   ,*box-right-to-line-center*
		   ,*roundtangle-right-corner-to-line-center*)
		  ,*roundtangle-top-corner-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*roundtangle-bottom-corner-to-line-center*
		  ,*box-top-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*box-bottom-to-line-center*
		  ,*roundtangle-top-corner-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*roundtangle-bottom-corner-to-line-center*)
		 ((,*roundtangle-left-corner-to-x2*
		   ,*box-left-to-x2*
		   ,*roundtangle-left-corner-to-x2*
		   ,*box-center-to-x2*
		   ,*box-center-to-x2*
		   ,*box-center-to-x2*
		   ,*roundtangle-right-corner-to-x2*
		   ,*box-right-to-x2*
		   ,*roundtangle-right-corner-to-x2*)
		  ,*roundtangle-top-corner-to-y2*
		  ,*box-center-to-y2*
		  ,*roundtangle-bottom-corner-to-y2*
		  ,*box-top-to-y2*
		  ,*box-center-to-y2*
		  ,*box-bottom-to-y2*
		  ,*roundtangle-top-corner-to-y2*
		  ,*box-center-to-y2*
		  ,*roundtangle-bottom-corner-to-y2*))
		(((,*box-left-to-x1*
		   ,*box-left-to-x1*
		   ,*box-left-to-x1*
		   ,*box-center-to-x1*
		   ,*box-center-to-x1*
		   ,*box-center-to-x1*
		   ,*box-right-to-x1*
		   ,*box-right-to-x1*
		   ,*box-right-to-x1*)
		  ,*box-top-to-y1*
		  ,*box-center-to-y1*
		  ,*box-bottom-to-y1*
		  ,*box-top-to-y1*
		  ,*box-center-to-y1*
		  ,*box-bottom-to-y1*
		  ,*box-top-to-y1*
		  ,*box-center-to-y1*
		  ,*box-bottom-to-y1*)
		 ((,*box-left-to-line-center*
		   ,*box-left-to-line-center*
		   ,*box-left-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*box-center-x-to-line-center*
		   ,*box-right-to-line-center*
		   ,*box-right-to-line-center*
		   ,*box-right-to-line-center*)
		  ,*box-top-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*box-bottom-to-line-center*
		  ,*box-top-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*box-bottom-to-line-center*
		  ,*box-top-to-line-center*
		  ,*box-center-y-to-line-center*
		  ,*box-bottom-to-line-center*)
		 ((,*box-left-to-x2*
		   ,*box-left-to-x2*
		   ,*box-left-to-x2*
		   ,*box-center-to-x2*
		   ,*box-center-to-x2*
		   ,*box-center-to-x2*
		   ,*box-right-to-x2*
		   ,*box-right-to-x2*
		   ,*box-right-to-x2*)
		  ,*box-top-to-y2*
		  ,*box-center-to-y2*
		  ,*box-bottom-to-y2*
		  ,*box-top-to-y2*
		  ,*box-center-to-y2*
		  ,*box-bottom-to-y2*
		  ,*box-top-to-y2*
		  ,*box-center-to-y2*
		  ,*box-bottom-to-y2*)))))



