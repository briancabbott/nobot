;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: COMMON-LISP-USER; Base: 10 -*-
;;*******************************************************************;;
;;;         The Garnet User Interface Development Environment.      ;;;
;;*******************************************************************;;
;;; This code was written as part of the Garnet project at          ;;;
;;; Carnegie Mellon University, and has been placed in the public   ;;;
;;; domain.                                                         ;;;
;;*******************************************************************;;


;;; $Id::                                                             $
;;


(in-package "COMMON-LISP-USER")

(defparameter Interactors-Version-Number "1.0")

(format t "Loading Interactors...~%")

;; check first to see if pathname variable is set
(unless (boundp 'Garnet-Inter-PathName)
  (error "Load 'Garnet-Loader' first to set Garnet-Inter-PathName before loading interactors."))


;;; ---- Load interactors themselves

(Defvar Garnet-Inter-Files
  '(
    ;; key translation files
    "garnet-keytrans"
    "define-mouse-keys"

    "x-define-keys"
    "x-inter"

    ;; interactor files
    "interactors"
    "accelerators"
    "animation-process"
    "i-windows"
    "menuinter"
    "movegrowinter"
    "buttoninter"
    "twopointinter"
    "textkeyhandling"
    "textinter"
    "angleinter"
    "animatorinter"))

(dolist (file Garnet-Inter-Files)
  (load (merge-pathnames file Garnet-Inter-PathName)
	:verbose T))

(setf (get :garnet-modules :inter)  t)
(format t "...Done Interactors.~%")

