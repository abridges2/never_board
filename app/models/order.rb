class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, :total, :gst, :pst, :hst, numericality: true
end
