class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates :gst, :pst, :hst, presence: true, numericality: true
end
