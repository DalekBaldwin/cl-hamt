
(defpackage #:cl-hamt-lil
  (:nicknames #:hamt-lil)
  (:use #:cl
        #:pure
        #:hamt)
  (:shadowing-import-from #:hamt
                          #:set-union
                          #:set-intersection))
