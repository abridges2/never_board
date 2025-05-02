class AddPriceCentsToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :order_items, :price_cents, :integer
  end
end
