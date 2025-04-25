class Province < ApplicationRecord
  has_many :addresses
  has_many :users

  validates :name, presence: true
  validates :gst, :pst, :hst, presence: true, numericality: true
end
