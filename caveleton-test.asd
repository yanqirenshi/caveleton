#|
  This file is a part of caveleton project.
  Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage caveleton-test-asd
  (:use :cl :asdf))
(in-package :caveleton-test-asd)

(defsystem caveleton-test
  :author "Satoshi Iwasaki"
  :license "MIT"
  :depends-on (:caveleton
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "caveleton"))))
  :description "Test system for caveleton"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
