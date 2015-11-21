(in-package :<% @var name %>.html)

(defun index.html ()
  (with-page (:title "Index.html")
    (:header
     (:h1 "Index.html"))
    (:section :id "contents")
    (:script :src "/js/index.js")))

