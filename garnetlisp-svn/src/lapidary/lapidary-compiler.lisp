;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: COMMON-LISP-USER; Base: 10 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         The Garnet User Interface Development Environment.      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This code was written as part of the Garnet project at          ;;;
;;; Carnegie Mellon University, and has been placed in the public   ;;;
;;; domain.  If you are using this code or any part of Garnet,      ;;;
;;; please contact garnet@cs.cmu.edu to be put on the mailing list. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Changes:
;;; 10/2/03 RGA --- New compile/load protocol
;;;     2/24/93 Andrew Mickish - Removed references to compile-opal/inter-p
;;;    10/01/92 Andrew Mickish - Removed *garnet-going-to-compile*
;;;     5/22/92 Brad Vander Zanden - Added kr-changes.lisp
;;; 	5/4/92 Ed Pervin - Changed Garnet-Lapidary-Pathname to 
;;;			  Garnet-Lapidary-Src.  Added "mouse-bindings"
;;;			  to list of files.
;;;

(in-package "COMMON-LISP-USER")


(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *debug-lapidary-mode* nil)
  (proclaim
   (if *debug-lapidary-mode*
       (and (boundp 'Garnet-Compile-Debug-Settings)
	    Garnet-Compile-Debug-Settings)
       ;; Global default settings.
       (and (boundp 'Default-Garnet-Proclaim) 
	    Default-Garnet-Proclaim))))


;; Only loads this file when not compiling all of Garnet.
(unless (get :garnet-modules :multifont)
  (garnet-load "opal:multifont-loader"))

(unless (get :garnet-modules :debug)
  (garnet-load "debug:debug-loader"))

;; load necessary gadgets
(dolist (pair '((:text-buttons "text-buttons-loader")
		(:motif-text-buttons "motif-text-buttons-loader")
		(:motif-check-buttons "motif-check-buttons-loader")
		(:motif-error-gadget "motif-error-gadget-loader")
		(:arrow-line "arrow-line-loader")
		(:labeled-box "labeled-box-loader")
		(:x-buttons "x-buttons-loader")
		(:motif-slider "motif-slider-loader")
		(:motif-scrolling-labeled-box "motif-scrolling-labeled-box-loader")
		(:motif-radio-buttons "motif-radio-buttons-loader")
		(:motif-scrolling-window "motif-scrolling-window-loader")
		(:motif-scrolling-menu "motif-scrolling-menu-loader")
		(:motif-menubar "motif-menubar-loader")
		(:prop-sheet-win "motif-prop-sheet-win-loader")))
  (unless (get :garnet-modules (car pair))
    (garnet-load (concatenate 'string "gadgets:" (cadr pair)))))

(unless (get :garnet-modules :gilt-functions)
  (garnet-load "gilt:gilt-functions-loader"))
(unless (get :garnet-modules :path-functions)
  (garnet-load "gilt:path-functions-loader"))
(unless (get :garnet-modules :c32)
  (load garnet-c32-loader))

;;; Create the Lapidary Directory
(eval-when (:execute :load-toplevel :compile-toplevel)
  (garnet-mkdir-if-needed Garnet-Lapidary-Pathname))


;;; Compile and load the constraint gadget

(defvar Garnet-Constraint-Dialog-Pathname Garnet-Lapidary-Pathname)
(defvar Garnet-Constraint-Dialog-Src Garnet-Lapidary-Src)

;;; If at cmu, then set up the search lists
#+cmu
(progn
  (setf (ext:search-list "constraint-dialog:")
	(list (namestring Garnet-Constraint-Dialog-PathName)))
  (setf (ext:search-list "constraint-dialog-src:")
	(list (namestring Garnet-Constraint-Dialog-Src))))


(garnet-load "lapidary-src:parameters")

(defparameter Garnet-Constraint-Dialog-Compiler
  (merge-pathnames "constraint-dialog-compiler" 
		    Garnet-Constraint-Dialog-PathName))

(garnet-load "lapidary-src:constraint-dialog-compiler")

(Defparameter Garnet-Lapidary-Files
  '(
        "lapidary-functions"
	"mouse-bindings"
	"parameters"
        "defs"
        "macros"
	"lapidary"  
	"dialog-parts2" "event-card" "card" "card1"
	"start-where" "prompt"
        "lapidary-objects"
	"feedback-objs"
	"support-misc"
	"support-selection1"	"support-selection2"   	"selection"
	"create-object"
	"delete-object"
        "delete-window"
	"move-grow"
	"aggregates"
	"aggparam" "create-parameters"
	"properties"
        "line-imp" "line-props"
	"fill-imp" "fill-props"
	"color-imp" "color-props"
	"shapes"
	"lap-draw"
	"support-menu-editor" #+(and) "motif-editor" #-(and) "new-editor"
        "text"   "text-properties"
        "gadgetcopy"
	"save-link-parameters"
        "lapidary-save"	"lapidary-read"	"support-save-restore" "save-restore"
	"add-gadget"
	"choice-inter" "text-inter"
	"move-grow-box" "support-move-grow-inter" "move-grow-inter" 
	"angle-inter" "two-point-inter"
	"support-inter" "by-demo"
	"interactors" "interactors-menu"))

(with-compilation-unit ()
  (dolist (file Garnet-Lapidary-Files)
    (garnet-compile (concatenate 'string "lapidary:" file))
    (garnet-load (concatenate 'string "lapidary:" file))))


(garnet-copy-files Garnet-Lapidary-Src Garnet-Lapidary-Pathname
		   '("lapidary-loader.lisp"
		     "lapidary-functions-loader.lisp"))
