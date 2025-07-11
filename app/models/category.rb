class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[order_items orders]
  end
end
