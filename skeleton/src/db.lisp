(in-package :cl-user)
(defpackage <% @var name %>.db
  (:use :cl)
  (:import-from :<% @var name %>.config
                :config)
  (:export :*graph*
           :start
           :stop))
(in-package :<% @var name %>.db)

(defparameter *graph* nil)

(defun config-data-stor ()
  (getf (config :databases) :data-stor))

(defun start ()
  (when *graph* (error "aledy started graph."))
  (let ((data-stor (config-data-stor)))
    (setf *graph*
          (shinra:make-banshou 'shinra:banshou data-stor))))

(defun stop ()
  (when *graph*
    (up:close-open-streams *graph*)))
