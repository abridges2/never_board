class User < ApplicationRecord
  has_many :addresses
  has_many :orders
  # has_one :cart, dependant: :destroy
  # after_create :create_cart
  # has_many :cart_items, through: :cart

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :first_name, :last_name, presence: true

  #   def create_cart
  #     self.create_cart!
  #     session[:cart] ||= {}
  #   end
end
