(in-package :cl-user)
(defpackage <% @var name %>-asd
  (:use :cl :asdf))
(in-package :<% @var name %>-asd)

(defsystem <% @var name %>
  :version "0.1"
  :author "<% @var author %>"
  :license "<% @var license %>"
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop
               :lack-middleware-validation
               :jonathan    ;; Json
               :spinneret   ;; Html
               :parenscript ;; JavaScript
               :lass        ;; Css
               ;; Database
               :upanishad
               :shinrabanshou
               :sephirothic)
  :components ((:module "src"
                :components
                ;;
                ;;     [start]
                ;;        |   
                ;;      config    
                ;;        |       
                ;;       db       
                ;;        |       
                ;;      model     
                ;;        |         
                ;;  +-----+-----+  
                ;;  |     |     |  
                ;; html   js   css 
                ;;  |     |     |  
                ;;  +-----+-----+  
                ;;        |       
                ;;    controller  
                ;;        |       
                ;;      view      
                ;;        |       
                ;;       web      
                ;;        |       
                ;;       main     
                ;;        |
                ;;      [end]
                ;;
                ((:file "config")
                 (:file "db" :depends-on ("config"))
                 (:module "model" :depends-on ("db")
                  :components ((:file "package")))
                 (:module "html" :depends-on ("model")
                  :components ((:file "package")
                               (:file "index" :depends-on ("package"))))
                 (:module "js" :depends-on ("model")
                  :components ((:file "package")))
                 (:module "css" :depends-on ("model")
                  :components ((:file "package")))
                 (:module "controller" :depends-on ("html" "js" "css")
                  :components ((:file "package")))
                 (:file "view" :depends-on ("controller"))
                 (:file "web" :depends-on ("view"))
                 (:file "main" :depends-on ("web")))))
  :description "<% @var description %>"
  :in-order-to ((test-op (load-op <% @var name %>-test))))
