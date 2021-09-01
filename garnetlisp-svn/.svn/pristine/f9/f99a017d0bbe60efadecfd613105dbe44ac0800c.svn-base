;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: LAPIDARY; Base: 10 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         The Garnet User Interface Development Environment.      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This code was written as part of the Garnet project at          ;;;
;;; Carnegie Mellon University, and has been placed in the public   ;;;
;;; domain.  If you are using this code or any part of Garnet,      ;;;
;;; please contact garnet@cs.cmu.edu to be put on the mailing list. ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; This file created by GILT V0.2: The Garnet Interface Builder
;;; on Dec 5, 1990, 10:49 AM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
============================================================
Change log:
    12/5/90 Brad Myers - hacked from created file
    12/5/90 Gilt - created
============================================================
|#

(in-package "LAPIDARY")

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *lapidary-save-load-files* 
    (list "motif-text-buttons"
	  "motif-radio-buttons"
	  "motif-check-buttons"))

  (dolist (file *lapidary-save-load-files*)
    (cl-user::garnet-load (concatenate 'string "gadgets:" file "-loader"))))

(create-instance 'SAVE-FILE OPAL:AGGREGADGET
  (:WINDOW-TITLE "Save File")
  (:WINDOW-LEFT 100)
  (:WINDOW-TOP 200)
  (:WINDOW-WIDTH 400)
  (:WINDOW-HEIGHT 228)
  (:PACKAGE-NAME "LAPIDARY")
  (:inter nil) ; indicates if interactor is being saved
  (:FUNCTION-FOR-OK `LAPIDARY::DO-SAVE-FILE)
  (:LEFT 0)
  (:TOP 0)
  (:WIDTH (o-formula (GVL :WINDOW :WIDTH) 316))
  (:HEIGHT (o-formula (GVL :WINDOW :HEIGHT) 228))
  (:parts `(
    (NIL ,OPAL:TEXT
      (:FONT ,*title-font*)
      (:BOX (9 8 35 14 ))
      (:STRING "Saving...")
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 9))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 8)))
    (:FILENAME ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:BOX (20 40 350 19 ))
      (:LABEL-STRING "Filename:")
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 40))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (:GADGET-NAME ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:LABEL-STRING "Top-level Gadget name:")
      (:BOX (20 70 350 18 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 70))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (:WIN-TITLE ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:LABEL-STRING "Window Title:")
      (:BOX (20 130 350 18 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 130))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (:PACKAGE-NAME ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:LABEL-STRING "Package name:")
      (:BOX (20 160 350 18 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 160))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (NIL ,GARNET-GADGETS:MOTIF-TEXT-BUTTON-PANEL
      (:SELECTION-FUNCTION lapidary::OKCANCEL-FUNCTION)
      (:GILT-REF "TYPE-OKCANCEL")
      (:SELECT-FUNCTION LAPIDARY::OKCANCEL-FUNCTION)
      (:FONT ,*text-button-font*)
      (:ITEMS ("OK" "Cancel" ))
      (:FINAL-FEEDBACK-P NIL)
      (:DIRECTION :HORIZONTAL)
      (:BOX (250 10 150 29 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 250))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 10)))
    (:EXPORT-P ,GARNET-GADGETS:MOTIF-CHECK-BUTTON-PANEL
      (:INDENT 0)
      (:V-ALIGN :TOP)
      (:H-SPACING 5)
      (:DIRECTION :VERTICAL)
      (:SELECT-FUNCTION NIL)
      (:H-ALIGN :RIGHT)
      (:TEXT-ON-LEFT-P T)
      (:V-SPACING 5)
      (:BUTTON-HEIGHT 20)
      (:FIXED-HEIGHT-P NIL)
      (:PIXEL-MARGIN NIL)
      (:RANK-MARGIN NIL)
      (:BUTTON-WIDTH 20)
      (:FONT ,*radio-button-font*)
      (:FIXED-WIDTH-P T)
      (:BOX (20 100 197 25 ))
      (:items ("Export Gadgets?"))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 100)))
    (:WIN-VALIDP ,OPAL:RECTANGLE
      (:visible ,(o-formula (or (gvl :parent :inter)
				(gv *selection-info* :selected))))
      (:DRAW-FUNCTION :AND)
      (:FILLING-STYLE ,OPAL:GRAY-FILL)
      (:LINE-STYLE NIL)
      (:BOX (14 126 297 30 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 14))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 126))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 297))
      (:HEIGHT ,(o-formula (FOURTH (GVL :BOX)) 30)))
    (:GAD-VALIDP ,OPAL:RECTANGLE
      (:visible ,(o-formula (or (gvl :parent :inter)
				(gv *selection-info* :selected))))
      (:DRAW-FUNCTION :AND)
      (:FILLING-STYLE ,OPAL:GRAY-FILL)
      (:LINE-STYLE NIL)
      (:BOX (14 66 297 30 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 14))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 66))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 297))
      (:HEIGHT ,(o-formula (FOURTH (GVL :BOX)) 30))))))

