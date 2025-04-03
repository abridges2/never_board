class User < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :first_name, :last_name, presence: true
end
