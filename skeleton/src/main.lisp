(in-package :cl-user)
(defpackage <% @var name %>
  (:use :cl)
  (:import-from #:<% @var name %>.config
                #:config)
  (:import-from #:clack
                #:clackup)
  (:export #:start
           #:stop))
(in-package :<% @var name %>)

(defvar *appfile-path*
  (asdf:system-relative-pathname :<% @var name %> #P"app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key
                           (server (config :http :server :type))
                           (port (config :http :server :port))
                           debug &allow-other-keys)
  (declare (ignore debug))
  (unless server (error "(config :http :server :type) is nil"))
  (unless port (error "(config :http :server :port) is nil"))
  (unless <% @var name %>.db:*graph*
          (<% @var name %>.db:start))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* :server server :port port args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)
    (when <% @var name %>.db:*graph*
          (<% @var name %>.db:stop))))
