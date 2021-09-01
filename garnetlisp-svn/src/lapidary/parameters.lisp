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
;;; This file contains the global parameters for lapidary.
;;; Designed by DSK

(in-package "LAPIDARY-DIALOGS")

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*box-constraint-menu-dimensions* *editor-window-dimensions* 
	    *shape-menu-dimensions* *shade-menu-dimensions*
	    *draw-fct-menu-dimensions* *line-menu-dimensions*
	    *new-vp-editor-left* *new-vp-editor-top*
	    *new-vp-editor-width* *new-vp-editor-height*
	    *dialog-title-font* *title-font* 
	    *radio-button-font* *text-button-font* *text-button-nonbold-font*
 	    *labeled-box-field-font* *labeled-box-label-font*
	    *slot-font*
	    *slot-frame-line-style* *misc-frame-line-style*)))

(defparameter *box-constraint-menu-dimensions* (list 880 20 490 560))
(defparameter *editor-window-dimensions* (list 100 #-apple 20 #+apple 50))
(defparameter *shape-menu-dimensions* (list 670 #-apple 20 #+apple 50
					    115 462))
(defparameter *shade-menu-dimensions* (list 551 #-apple 0 #+apple 50
					    115 295))
(defparameter *draw-fct-menu-dimensions* (list 666 251 0 215))
(defparameter *line-menu-dimensions* (list 666
					   #-apple 0 #+apple 50
					   110 252))
(defparameter *new-vp-editor-left* 50)
(defparameter *new-vp-editor-top* 170)
(defparameter *new-vp-editor-width* 600)
(defparameter *new-vp-editor-height* 600)

(defparameter *dialog-title-font* (opal:get-standard-font :sans-serif :bold-italic :very-large))
(defparameter *title-font* (opal:get-standard-font :sans-serif :bold-italic :large))
(defparameter *radio-button-font* opal:default-font)
(defparameter *text-button-font* (opal:get-standard-font :sans-serif :bold :small))
(defparameter *text-button-nonbold-font* opal:default-font)
(defparameter *labeled-box-field-font* opal:default-font)
(defparameter *labeled-box-label-font* opal:default-font)

(defparameter *slot-font* (opal:get-standard-font :sans-serif :bold-italic nil))

(defparameter *slot-frame-line-style* (create-instance nil opal:line-style
					(:line-thickness 2)
					(:foreground-color opal:blue)))

(defparameter *misc-frame-line-style* (create-instance nil opal:line-style
					(:line-thickness 2)
					(:foreground-color opal:orange)))
