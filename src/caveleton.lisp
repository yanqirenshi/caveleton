(in-package :cl-user)
(defpackage caveleton
  (:use :cl)
  (:export :make-project
           :skeleton-directory))
(in-package :caveleton)

(defun skeleton-directory ()
  (asdf:system-relative-pathname :caveleton #p"skeleton/"))

(defun make-project (path &rest params)
  (let ((cl-project:*skeleton-directory* (skeleton-directory)))
    (apply #'cl-project:make-project path params)))



