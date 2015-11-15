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
       ;; jquery 
       (:script :src "/lib/jquery-2.1.4.min.js")
       ;; bootstrap
       (:link :rel "stylesheet" :href "/lib/bootstrap/3.3.5/css/bootstrap.min.css" :type "text/css")
       (:link :rel "stylesheet" :href "/lib/bootstrap/3.3.5/css/bootstrap-theme.min.css" :type "text/css")
       (:script :src "/lib/bootstrap/3.3.5/js/bootstrap.min.js")
       ;; other js
       (:script :src "/lib/format4js.js")
       (:script :src "/lib/moment.min.js")
       (:link :rel "stylesheet" :href "/css/common.css" :type "text/css"))
      (:body ,@body))))
