class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :title, :description, :price_cents, :category_id, presence: true
  validates :price_cents, numericality: { only_integer: true, greater_than: 0 }
end
