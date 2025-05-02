class Province < ApplicationRecord
  has_many :addresses
  has_many :users
  has_many :orders

  validates :name, presence: true
  validates :gst, :pst, :hst, presence: true, numericality: true
end
