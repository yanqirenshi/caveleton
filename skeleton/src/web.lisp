(in-package :cl-user)
(defpackage <% @var name %>.web
  (:use :cl
        :caveman2
        :<% @var name %>.config
        :<% @var name %>.view
        :<% @var name %>.db)
  (:export :*web*))
(in-package :<% @var name %>.web)

;;;;;
;;;;; Application
;;;;;
(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "Welcome Cavelton")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  "404")
