(in-package :cl-user)
(defpackage <% @var name %>.router
  (:use :cl
        :caveman2
        :lack.middleware.validation
        :<% @var name %>.config
        :<% @var name %>.render)
  (:export #:*route*))
(in-package :<% @var name %>.router)

;;;;;
;;;;; Router
;;;;;
(defclass <router> (<app>) ())
(defvar *route* (make-instance '<router>))
(clear-routing-rules *route*)

;;;;;
;;;;; Routing rules
;;;;;
(defroute "/" ()
  "")

;;;;;
;;;;; Error pages
;;;;;
(defmethod on-exception ((app <router>) (code (eql 404)))
  (declare (ignore app))
  "404")
