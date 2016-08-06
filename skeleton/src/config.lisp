(in-package :cl-user)
(defpackage <% @var name %>.config
            (:use :cl)
            (:import-from #:sephirothic
                          #:make-tree
                          #:fruit*
                          #:code)
            (:export #:config
                     #:print-config
                     #:*application-root*
                     #:*static-directory*))
(in-package :<% @var name %>.config)

(defparameter *application-root* (asdf:system-source-directory :<% @var name %>))
(defparameter *static-directory* (merge-pathnames #P"static/" *application-root*))

(defvar *tree-stor* (merge-pathnames #P"src/data/" *application-root*))
(defvar *tree* (make-tree (ensure-directories-exist *tree-stor*)))

(defvar *application-code* :<% @var name %>)

(defun get-environments-code (&key (name (uiop:getenv "APP_ENV")))
  (cond ((string= name "development") :development)
        ((string= name "production") :production)
        (t :unknown)))

(defun get-sephirothic-context ()
  (sephirothic:get-sephirothic-context :tree *tree*
                                       :application-code *application-code*
                                       :environment-code (get-environments-code)))

(defun config (&rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (fruit* tree (code appl) (code env) query)))

(defun print-config ()
  (multiple-value-bind (graph appl env appl-code env-code)
      (get-sephirothic-context)
    (format t "Graph: ~a~%" graph)
    (format t " Appl: ~a => ~a~%" appl appl-code)
    (format t "  Env: ~a => ~a~%" env env-code)))

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
