module Entities
  class User < Grape::Entity
    expose :id, :email

    # Here we using if: { with_users: true } to eliminate infinite loop
    # which is occuring because of the circular reference between User and Company entities.
    expose :company, using: "Entities::Company", if: { with_company: true }
  end
end
