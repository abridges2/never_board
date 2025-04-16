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

  # This method is used to determine whether the product is on sale or not.
  # Returns the sale price or the regular price depending on if the
  # product is on sale.
  def on_sale_price
    if on_sale && sale_price_cents.present?
      sale_price_cents
    else
      price_cents
    end
  end
end
