(in-package :cl-user)
(defpackage <% @var name %>.db
  (:use :cl)
  (:import-from #:<% @var name %>.config
                #:config)
  (:export #:*graph*
           #:start
           #:stop))
(in-package :<% @var name %>.db)

(defparameter *graph* nil)

(defun start ()
  (when *graph* (error "aledy started graph."))
  (let ((data-stor (config :database :data :stor)))
    (unless data-stor
      (error "(config :database :data :stor) is nil"))
    (setf *graph*
          (shinra:make-banshou 'shinra:banshou data-stor))))

(defun stop ()
  (when *graph*
    (up:close-open-streams *graph*)
    (setf *graph* nil)))
