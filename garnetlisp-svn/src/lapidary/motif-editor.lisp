;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: LAPIDARY; Base: 10 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         The Garnet User Interface Development Environment.      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This code was written as part of the Garnet project at          ;;;
;;; Carnegie Mellon University, and has been placed in the public   ;;;
;;; domain.  If you are using this code or any part of Garnet,      ;;;
;;; please contact garnet@cs.cmu.edu to be put on the mailing list. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (load "new-editor.lisp")
; (lapidary::editor-menu-do-go)

;;; CHANGE LOG
;;;
;;; 08/10/93 bvz - modified the editor menu so that it supported a selection
;;;                  mode in which users could indicate whether Lapidary
;;;                  should select leaves or top-level objects.

(in-package "LAPIDARY")

(declaim (special EDITOR-WIN))

(defun editor-menu-do-go ()
  
  (editor-menu-do-stop)

  (create-instance 'EDITOR-MENU gg:motif-menubar
		 (:constant '(t))
		 (:build-p t)
		 (:title-font (opal:get-standard-font :sans-serif :bold nil))
		 (:item-font (opal:get-standard-font :sans-serif :bold nil))
		 (:selection-function 'lap-menu-handler)
		 (:items '(
			   ("File" nil  (
					 ("load gadget")
					 ("save gadget")
					 ("add gadget")
					 ("quit")
					 ))
			   ("Edit" nil  (
					 ("make copy")
					 ("make instance")
					 ("delete object")
					 ("clear workspace")
					 ("delete window")
					 
					 ))
			   ("Properties" nil  (
					       ("filling style" )
					       ("line style")
					       ("draw function" )
					       ("list properties" )
					       ("text properties" )
					       ("name object" )
					       ("parameters")
					       ))
			   ("Arrange" nil  (
					    ("bring to front")
					    ("send to back")
					    ("make aggregadget" )
					    ("ungroup" )
					    ))
			   ("Constraints"   nil  (
						  ("line constraints")
						  ("box constraints" )
						  ("c32")
						  ))
			   ("Interactors"   nil  (
						  ("choice")
						  ("move/grow")
						  ("text")
						  ("two-point")
						  ("angle")
					    )) )))
  (create-instance 'EDITOR-WIN inter:interactor-window
		   (:title "editor menu")
		   (:left (first *editor-window-dimensions*))
		   (:top (second *editor-window-dimensions*))
		   (:width (g-value editor-menu :width)) 
;		   (:width 340)
		   (:height 130))

  (create-instance 'EDITOR-MENU-AGG opal:aggregate)
  (s-value editor-win :aggregate editor-menu-agg)
  (opal:add-component editor-menu-agg editor-menu)
  (opal:update editor-win)

  (opal:add-components 
   EDITOR-MENU-AGG
   (create-instance 'selection-mode-label opal:text
     (:string "Selection Mode:")
     (:font (opal:get-standard-font :sans-serif :bold :small))
     (:left 15)
     (:top (o-formula (+ (opal:bottom editor-menu) 10))))

   (create-instance 'selection-mode-gadget gg:motif-radio-button-panel
     (:text-on-left-p nil)
     (:direction :vertical)
     (:font (opal:get-standard-font :sans-serif :bold :small))
     (:selection-function #'(lambda (gadget value)
			      (declare (ignore gadget))
			      (declare (special *selection-info*))
			      (s-value *selection-info* :leaf
				       (string= value "leaves"))))
     (:items '("leaves" "top-level objects"))
     (:left 25)
     (:top (+ 10 (opal:bottom selection-mode-label)))))

  (opal:update editor-win)

  (opal:add-components
   EDITOR-MENU-AGG 
   (create-instance 'test-build-mode-label opal:text
     (:string "Test/Build Mode:")
     (:font (opal:get-standard-font :sans-serif :bold :small))
     (:left (o-formula (+ (ceiling (g-value EDITOR-WIN :width) 2) 15)))
     (:top (o-formula (+ (opal:bottom EDITOR-MENU) 10))))

  
   (create-instance 'test-build-obj gg:motif-radio-button-panel
     (:text-on-left-p nil)
     (:direction :vertical)
     (:font (opal:get-standard-font :sans-serif :bold :small))
     (:selection-function 'test-build-fct)
     (:left (o-formula (+ (ceiling (g-value EDITOR-WIN :width) 2) 25)))
     (:top (o-formula (+ 10 (opal:bottom test-build-mode-label))))
     (:items '("test" "build"))))

  (opal:update editor-win)

  (opal:add-component
   EDITOR-MENU-AGG
   (create-instance 'editor-menu-divider-line opal:line
     (:x1 (o-formula (ceiling (g-value EDITOR-WIN :width) 2) 230))
     (:x2 (o-formula (ceiling (g-value EDITOR-WIN :width) 2) 230))
     (:y1 (o-formula (gv editor-menu :height)))
     (:y2 (o-formula (gvl :window :height)))))

  (opal:notice-items-changed editor-menu)

  ;; initialize radio buttons
  (g-value test-build-obj :value)
  (s-value test-build-obj :value "build")

  ;; initialize selection mode
  (g-value selection-mode-gadget :value)
  (s-value selection-mode-gadget :value "top-level objects")
  (s-value *selection-info* :leaf nil)

  (opal:update EDITOR-WIN))

(defun editor-menu-do-stop ()
  (when (boundp 'EDITOR-WIN) (opal:destroy EDITOR-WIN)))
