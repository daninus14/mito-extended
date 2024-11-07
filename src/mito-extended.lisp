(in-package :mito-extended)


(defclass mito-extended-metaclass
    (mito-auth-jzon:mito-auth-jzon-metaclass
     mito-validate:mito-validate-metaclass)
  nil)

(defmethod closer-mop:validate-superclass
    ((class mito-extended-metaclass) (superclass standard-class))
  t)

(defclass mito-extended-metaclass-direct-slot-definition-class
    (mito-auth-jzon::mito-auth-jzon-standard-direct-slot-definition
     mito-validate::mito-validate-standard-direct-slot-definition
     closer-mop:standard-direct-slot-definition)
  nil)

(defclass mito-extended-metaclass-effective-slot-definition-class
    (mito-auth-jzon::mito-auth-jzon-standard-effective-slot-definition
     mito-validate::mito-validate-standard-effective-slot-definition
     closer-mop:standard-effective-slot-definition)
  nil)

(defmethod closer-mop:direct-slot-definition-class
    ((class mito-extended-metaclass) &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-extended-metaclass-direct-slot-definition-class))

(defmethod closer-mop:effective-slot-definition-class
    ((class mito-extended-metaclass) &rest initargs)
  (declare (ignorable initargs))
  (find-class 'mito-extended-metaclass-effective-slot-definition-class))

