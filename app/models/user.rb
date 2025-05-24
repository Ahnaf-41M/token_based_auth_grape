class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  belongs_to :company

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
