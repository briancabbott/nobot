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
;;; on Dec 5, 1990, 10:55 AM
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
  (defparameter *lapidary-read-load-files* 
    (list "motif-text-buttons"
	  "motif-radio-buttons"))

  (dolist (file *lapidary-read-load-files*)
    (cl-user::garnet-load (concatenate 'string "gadgets:" file "-loader"))))



(create-instance 'READ-FILE OPAL:AGGREGADGET
  (:WINDOW-TITLE "Read File")
  (:WINDOW-LEFT 120)
  (:WINDOW-TOP 220)
  (:WINDOW-WIDTH 316)
  (:WINDOW-HEIGHT 166)
  (:PACKAGE-NAME "LAPIDARY")
  (:FUNCTION-FOR-OK `LAPIDARY::DO-READ-FILE)
  (:LEFT 0)
  (:TOP 0)
  (:WIDTH (o-formula (GVL :WINDOW :WIDTH) 316))
  (:HEIGHT (o-formula (GVL :WINDOW :HEIGHT) 139))
  (:parts `(
    (NIL ,OPAL:TEXT
      (:FONT ,*title-font*)
      (:BOX (9 8 35 14 ))
      (:STRING "Reading...")
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 9))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 8)))
    (:FILENAME ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:GILT-REF "TYPE-SCROLLING-LABELED-BOX")
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:BOX (20 40 285 19 ))
      (:LABEL-STRING "Filename:")
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 40))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (:WINDOWNAME ,GARNET-GADGETS:MOTIF-SCROLLING-LABELED-BOX
      (:GILT-REF "TYPE-SCROLLING-LABELED-BOX")
      (:MIN-FRAME-WIDTH NIL)
      (:SELECT-FUNCTION NIL)
      (:FIELD-FONT ,*labeled-box-field-font*)
      (:FIELD-OFFSET 2)
      (:LABEL-OFFSET 5)
      (:LABEL-FONT ,*labeled-box-label-font*)
      (:BOX (20 68 285 53 ))
      (:LABEL-STRING "Windowname:")
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 20))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 68))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 285)))
    (NIL ,GARNET-GADGETS:MOTIF-TEXT-BUTTON-PANEL
      (:SELECTION-FUNCTION LAPIDARY::OKCANCEL-FUNCTION)
      (:GILT-REF "TYPE-OKCANCEL")
      (:SELECT-FUNCTION LAPIDARY::OKCANCEL-FUNCTION)
      (:FONT ,*text-button-font*)
      (:ITEMS ("OK" "Cancel" ))
      (:FINAL-FEEDBACK-P NIL)
      (:DIRECTION :HORIZONTAL)
      (:BOX (175 6 117 29 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 175))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 6)))
    (:ADD-REPLACE ,GARNET-GADGETS:MOTIF-RADIO-BUTTON-PANEL
      (:GILT-REF "TYPE-RADIO-BUTTON-PANEL")
      (:INDENT 0)
      (:V-ALIGN :TOP)
      (:H-SPACING 5)
      (:DIRECTION :VERTICAL)
      (:SELECT-FUNCTION NIL)
      (:H-ALIGN :RIGHT)
      (:TEXT-ON-LEFT-P T)
      (:V-SPACING 5)
      (:FIXED-HEIGHT-P T)
      (:PIXEL-MARGIN NIL)
      (:RANK-MARGIN NIL)
      (:BUTTON-DIAMETER 23)
      (:FONT ,*radio-button-font*)
      (:FIXED-WIDTH-P T)
      (:BOX (22 96 129 53 ))
      (:ITEMS ("Add to existing objects" "Replace existing objects" ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 22))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 96)))
    (:ADD-REPLACE-VALID ,OPAL:RECTANGLE
      (:GILT-REF "TYPE-RECTANGLE")
      (:DRAW-FUNCTION :AND)
      (:FILLING-STYLE ,OPAL:GRAY-FILL)
      (:LINE-STYLE NIL)
      (:BOX (15 92 216 66 ))
      (:LEFT ,(o-formula (FIRST (GVL :BOX)) 15))
      (:TOP ,(o-formula (SECOND (GVL :BOX)) 92))
      (:WIDTH ,(o-formula (THIRD (GVL :BOX)) 216))
      (:HEIGHT ,(o-formula (FOURTH (GVL :BOX)) 66))))))
