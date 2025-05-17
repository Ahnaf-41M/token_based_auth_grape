class User < ApplicationRecord
  has_secure_password
  belongs_to :company

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
