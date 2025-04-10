class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image

  validates :title, :description, :price_cents, :category_id, presence: true
  validates :price_cents, numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_associations(auth_object = nil)
    %w[category order_items orders image_attachments image_blob]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description price_cents created_at updated_at image_url]
  end
end
