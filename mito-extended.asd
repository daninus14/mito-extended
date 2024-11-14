(defsystem "mito-extended"
  :version "0.1.0"
  :author "Daniel Nussenbaum"
  :license "MIT"
  :depends-on ("closer-mop"
               "mito-validate"
               "mito-auth-jzon")
  :components ((:module "src"
                :components
                ((:file "packages")
                 (:file "mito-extended")
                 (:file "util-mito"))))
  :description "Extended Mito ORM to have validations, mark sensitive slots, auth, etc")
