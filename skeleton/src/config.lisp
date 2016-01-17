(in-package :cl-user)
(defpackage <% @var name %>.config
            (:use :cl)
            (:import-from #:sephirothic
                          #:make-tree
                          #:get-sephirothic-context
                          #:fruit*
                          #:code)
            (:export #:config
                     #:*application-root*
                     #:*static-directory*))
(in-package :<% @var name %>.config)

(defparameter *application-root* (asdf:system-source-directory :gp-web))
(defparameter *static-directory* (merge-pathnames #P"static/" *application-root*))

(defvar *tree-stor* nil)
(defvar *tree* (make-tree (or *tree-stor* (error "*tree-stor* is empty."))))

(defvar *application-code* :<% @var name %>)

(defun get-environments-code (&key (name (uiop:getenv "APP_ENV")))
  (cond ((string= name "development") :development)
        ((string= name "production") :production)
        (t :unknown)))

(defun get-sephirothic-context ()
  (get-common-sephirothic-context :tree *tree*
                                  :application-code *application-code*
                                  :environment-code (get-environments-code)))

(defun config (&rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (fruit* tree (code appl) (code env) query)))

(defun (setf config) (value &rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (setf (fruit* tree (code appl) (code env) query)
          value)))

(defun init-config ()
  (setf (config :http :server :port) 55555)
  (setf (config :http :server :type) :woo)
  (setf (config :log :error :directory) nil)
  (setf (config :database :data :stor) nil))

(init-config)
