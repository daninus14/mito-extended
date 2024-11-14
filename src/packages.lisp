(cl:in-package #:common-lisp-user)

(defpackage mito-extended
  (:use :cl)
  (:export 
   #:mito-extended-metaclass
   #:get-slots-with-reference 
   #:get-foreign-model-slots 
   #:get-non-foreign-model-slots 
   #:add-non-foreign-model-slots-to-object
   #:create-mito-wo-foreign))


