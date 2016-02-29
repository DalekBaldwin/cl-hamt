
(in-package #:cl-hamt-lil)

(interface:define-interface <hamt>
    (<copy-is-identity>
     <map-foldable-from-*>
     <map-fold-right*-from-fold-left*>
     <map-has-key-p-from-lookup>
     <map-join-from-fold-left*-insert>
     <map-singleton-from-insert>
     <map-update-key-from-lookup-insert-drop>
     <map-divide/list-from-divide>
     <map>)
  ()
  (:singleton)
  (:documentation "hash array-mapped trie"))

(defmethod fold-left* ((i <hamt>) map f seed)
  (dict-reduce f map seed))

(defmethod lookup ((i <hamt>) map key)
  (dict-lookup map key))

(defmethod for-each* ((i <hamt>) iterator f)
  (dict-reduce
   (lambda (accum key val)
     (funcall f (list key val))
     (values))
   iterator
   nil))

(defmethod alist-map ((i <hamt>) alist)
  (reduce (lambda (accum item)
            (dict-insert
             accum (car item) (cdr item)))
          alist
          :initial-value (empty-dict)))

#+nil
(defmethod create ((i <hamt>) contents))

(defmethod empty ((i <hamt>))
  (empty-dict))

(defmethod empty-p ((i <hamt>) object)
  (with-slots ((table cl-hamt::table))
      object
    (with-slots ((bitmap cl-hamt::bitmap)) table
      (zerop bitmap))))

#+nil
(defmethod iterator ((i <hamt>) fount))

#+nil
(defmethod next ((i <hamt>) iterator))

#+nil
(defmethod result ((i <hamt>) collector))

(defmethod insert ((i <hamt>) map key value)
  (dict-insert map key value))

(defmethod drop ((i <hamt>) map key)
  (multiple-value-bind (value foundp) (lookup i map key)
    (cond
      (foundp
       (values (dict-remove map key) value foundp))
      (t
       (values map value foundp)))))

(defmethod divide ((i <hamt>) collection)
  (dict-divide collection))
