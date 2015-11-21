(in-package :cl-user)
(defpackage <% @var name %>.web
  (:use :cl
        :caveman2
        :lack-middleware-validation
        :<% @var name %>.config
        :<% @var name %>.view
        :<% @var name %>.db
        :<% @var name %>.html)
  (:export #:*web*))
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
  (index.html))

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  "404")
