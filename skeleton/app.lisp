(ql:quickload :<% @var name %>)

(defpackage <% @var name %>.app
  (:use :cl)
  (:import-from #:lack.builder
                #:builder)
  (:import-from #:ppcre
                #:scan
                #:regex-replace)
  (:import-from #:<% @var name %>.web
                #:*web*)
  (:import-from #:<% @var name %>.config
                #:config
                #:productionp
                #:*static-directory*))
(in-package :<% @var name %>.app)

(builder
 (:static
  :path (lambda (path)
          (if (ppcre:scan "^(?:/images/|/css/|/js/|/lib/|/robot\\.txt$|/favicon\\.ico$)" path)
              path
              nil))
  :root *static-directory*)
 (if (productionp)
     nil
     :accesslog)
 (if (config+ :log :error :directory)
     `(:backtrace
       :output ,(config+ :log :error :directory))
     nil)
 :session
 :validation
 *web*)
