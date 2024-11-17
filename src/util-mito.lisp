(in-package :mito-extended)

;; TODO error because the ghost slot is set to an empty string and it tries to get the
;; ID of an object which is that empty string. Need toa mito create object from a hashtable
;; which will check if a column is a reference and not set it unless it's another mito object
;; or maybe try to initialize a mito object if the data is not empty...

;; TODO need to mark certain slots as uneditable and then don't set those

;; TODO need to make a function to set non ghost slots (probably easier, but less extensible
;; than what I did below)

(defun get-slots-with-reference (class)
  (remove-if-not #'mito.class.column::table-column-references-column
                 (closer-mop:class-slots class)))

(defun get-foreign-model-slots (class)
  (remove-if #'null
             (mapcar (lambda (x) (mito.class.table::find-parent-column class x))
                     (closer-mop:class-slots class))))

(defun get-non-foreign-model-slots (class)  
  (let ((foreign-model-slots (get-foreign-model-slots class)))
    (remove-if (lambda (x) (member (closer-mop:slot-definition-name x)
                                   foreign-model-slots))
               (closer-mop:class-slots class))))

(defun add-non-foreign-model-slots-to-object (object ht)
  (loop for slot in (get-non-foreign-model-slots (class-of object))
        for slot-name = (closer-mop:slot-definition-name slot)
        for slot-key = (symbol-name slot-name)
        do (multiple-value-bind (value found) (gethash slot-key ht)
             (when found
               (setf (slot-value object slot-name) value))))
  object)

(defun create-mito-wo-foreign (class ht)
  (let ((obj (make-instance class)))
    (add-non-foreign-model-slots-to-object obj ht)))
