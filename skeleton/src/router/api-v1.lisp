(in-package :cl-user)
(defpackage <% @var name %>.api-v1
  (:use :cl
        :caveman2
        :lack.middleware.validation
        :<% @var name %>.config
        :<% @var name %>.render)
  (:export #:*api-v1*))
(in-package :<% @var name %>.api-v1)

;;;;;
;;;;; Application
;;;;;
(defclass <router> (<app>) ())
(defvar *api-v1* (make-instance '<router>))
(clear-routing-rules *api-v1*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "api-v1")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
