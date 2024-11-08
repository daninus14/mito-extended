(defclass c6 ()
  ((name :col-type (or :null :text)
         :initarg :name)
   (secret :col-type (or :null :text)
           :sensitive t
           :initarg :secret 
           :validation-type string)
   (age :col-type (or :null :integer)
        :initarg :age 
        :validation-function (lambda (x) (when (< x 18) (error "Minors are not accepted")))))
  (:metaclass mito-extended:mito-extended-metaclass))

(com.inuoe.jzon:stringify (make-instance 'c6 :name "john" :secret "materasi" :age 19))

(setf mito:*auto-migration-mode* T)

(mito:connect-toplevel :postgres
                       :database-name "prueba"
                       :username "pruebauser"
                       :password "pruebauser")


(defclass c7 (mito-auth:has-secure-sensitive-password)
  ((name :col-type (or :null :text)
         :initarg :name)
   (secret :col-type (or :null :text)
           :sensitive t
           :initarg :secret 
           :validation-type string)
   (age :col-type (or :null :integer)
        :initarg :age 
        :validation-function (lambda (x) (when (< x 18) (error "Minors are not accepted")))))
  (:metaclass mito-extended:mito-extended-metaclass))

(mito:insert-dao
 (make-instance 'c7
                :name "john"
                :secret "materasi"
                :age 19
                :password "bourne"))

CL-USER> (mito:insert-dao
          (make-instance 'c7 :name "john"
                             :secret "materasi"
                             :age 19
                             :password "bourne"))
#<C7 {100B01EE13}>
CL-USER> (mito:select-dao 'c7)
(#<C7 {1008A00BB3}>)
#<SXQL-STATEMENT: SELECT * FROM c7>
CL-USER> (inspect *)

The object is a CONS.
0. CAR: #<C7 {1008A00BB3}>
1. CDR: NIL
> 0

The object is a STANDARD-OBJECT of type C7.
0. CREATED-AT: @2024-11-04T16:14:16.000000+02:00
1. UPDATED-AT: @2024-11-04T16:14:16.000000+02:00
2. PASSWORD-HASH: "43d92249b4e4babbb12373f898b701cde2b06a7712ad6cab2f6155cfec6a3a11"
3. PASSWORD-SALT: #(6 204 79 12 108 163 82 13 120 113 217 243 36 15 54 77 64
                    124 163 74)
4. SYNCED: T
5. ID: 1
6. NAME: "john"
7. SECRET: "materasi"
8. AGE: 19
> 
q
                                        ; No values
CL-USER> (com.inuoe.jzon:stringify (first (mito:select-dao 'c7)))
"{\"created-at\":{\"day\":9014,\"sec\":51256,\"nsec\":0},\"updated-at\":{\"day\":9014,\"sec\":51256,\"nsec\":0},\"synced\":true,\"id\":1,\"name\":\"john\",\"age\":19}"
CL-USER> 
