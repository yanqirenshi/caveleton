(in-package :cl-user)
(defpackage <% @var name %>.view
  (:use :cl)
  (:import-from #:<% @var name %>.config
                #:*template-directory*)
  (:import-from #:caveman2
                #:*response*
                #:response-headers)
  (:export #:render
           #:render-json))
(in-package :<% @var name %>.view)

(defun render-json (object)
  (setf (getf (response-headers *response*) :content-type) "application/json")
  (jonathan:to-json object))
