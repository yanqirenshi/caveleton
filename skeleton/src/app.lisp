(ql:quickload :<% @var name %>)

(defpackage <% @var name %>.app
  (:use :cl)
  (:import-from #:lack.builder
                #:builder)
  (:import-from #:ppcre
                #:scan
                #:regex-replace)
  (:import-from #:<% @var name %>.router
                #:*route*)
  (:import-from #:<% @var name %>.api-v1
                #:*api-v1*)
  (:import-from #:<% @var name %>.config
                #:config))
(in-package :<% @var name %>.app)

(builder
 :accesslog
 (if (config :log :error :directory)
     `(:backtrace
       :output ,(config :log :error :directory))
     nil)
 :session
 :validation
 (:mount "/api/v1" *api-v1*)
 *route*)
