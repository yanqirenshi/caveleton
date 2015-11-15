(in-package :cl-user)
(defpackage <% @var name %>.html
  (:use :cl)
  (:import-from #:<% @var name %>.config
                #:config)
  (:export :index.html))
(in-package :<% @var name %>.html)

(defmacro with-page ((&key title) &body body)
  `(spinneret:with-html-string
     (:doctype)
     (:html
      (:head
       (:title ,title)
       (:link :rel "stylesheet" :href "/css/common.css" :type "text/css")
       (:script :src "https://code.jquery.com/jquery-2.1.4.min.js"))
      (:body ,@body))))
