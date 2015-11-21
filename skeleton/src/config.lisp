(in-package :cl-user)
(defpackage <% @var name %>.config
  (:use :cl)
  (:import-from #:sephirothic
                #:make-tree
                #:make-application
                #:fruit*)
  (:export #:config
           #:*application-root*
           #:*static-directory*
           #:*template-directory*
           #:appenv
           #:developmentp
           #:productionp))
(in-package :<% @var name %>.config)

(defparameter *application-root*   (asdf:system-source-directory :gp-web))
(defparameter *static-directory*   (merge-pathnames #P"static/" *application-root*))

(defvar *tree-stor* nil)
(defvar *tree* (make-tree (or *tree-stor* (error "*tree-stor* is empty."))))

(defvar *environments* 
  '(("development" :development)
    ("production" :production)))

(setf (envy:config-env-var) "APP_ENV")

(defun appenv ()
  (uiop:getenv (config-env-var #.(package-name *package*))))

(defun developmentp ()
  (string= (appenv) "development"))

(defun productionp ()
  (string= (appenv) "production"))

(defun get-appenv-keyword (name)
  (let* ((environments *environments*)
         (keyword (second (assoc name environments :test 'string=))))
    (print keyword)
    (or keyword :unknown)))

(defun get-sephirothic-context ()
  (let* ((tree *tree*)
         (appl-code :gpc-web)
         (env-code (get-appenv-keyword (appenv)))
         (appl (sephirothic::ensure-application appl-code :tree tree)))
    (values tree
            appl-code
            env-code
            appl
            (sephirothic::ensure-environment appl env-code :tree tree))))

(defun config (&rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (fruit* tree appl env query)))

(defun (setf config) (value &rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (setf (fruit* tree appl env query)
          value)))

(defun init-config ()
  (setf (config :http :server :port) 55559)
  (setf (config :http :server :type) :woo)
  (setf (config :log :error :directory) nil)
  (setf (config :database :data :stor) nil))

(init-config)
