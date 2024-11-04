(in-package :mito-extended)

(defclass mito-extended-slot-definition-class nil nil)

(defclass mito-extended-metaclass
    (mito-auth-jzon:mito-auth-jzon-metaclass
     mito-validate:mito-validate-metaclass standard-class)
  nil)

(defmethod sb-mop:validate-superclass
    ((class mito-extended-metaclass) (superclass standard-class))
  t)

(defclass mito-extended-direct-slot-definition-class
    (mito-extended-slot-definition-class
     mito-auth-jzon::mito-auth-jzon-standard-direct-slot-definition
     mito-validate::mito-validate-standard-direct-slot-definition
     sb-mop:standard-direct-slot-definition)
  nil)

(defclass mito-extended-effective-slot-definition-class
    (mito-extended-slot-definition-class
     mito-auth-jzon::mito-auth-jzon-standard-effective-slot-definition
     mito-validate::mito-validate-standard-effective-slot-definition
     sb-mop:standard-effective-slot-definition)
  nil)

(defmethod sb-mop:direct-slot-definition-class
    ((class mito-extended-metaclass) &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-extended-direct-slot-definition-class))

(defmethod sb-mop:effective-slot-definition-class
    ((class mito-extended-metaclass) &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-extended-effective-slot-definition-class))

(defmethod sb-mop:compute-effective-slot-definition :around
    ((class mito-extended-metaclass) name direct-slot-definitions)
  (declare (ignore name))
  (let ((result (call-next-method)))
    (when result)
    result))
