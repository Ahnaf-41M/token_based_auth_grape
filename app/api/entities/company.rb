module Entities
  class Company < Grape::Entity
    expose :id, :name, :industry, :address

    # Here we using if: { with_users: true } to eliminate infinite loop
    # which is occuring because of the circular reference between User and Company entities.
    expose :users, using: "Entities::User", if: { with_users: true }
  end
end
