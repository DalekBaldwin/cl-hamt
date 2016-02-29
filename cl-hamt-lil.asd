
(asdf:defsystem #:cl-hamt-lil
  :description "An interface for cl-hamt satisfying LIL's pure:<map>"
  :author "Kyle Littler"
  :license "BSD"
  :depends-on (#:cl-hamt #:lisp-interface-library)
  :serial t
  :components
  ((:module "lil"
    :serial t
    :components
    ((:file "package")
     (:file "hamt-lil")))))
