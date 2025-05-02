class AddTotalCentsToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :order_items, :total_cents, :integer
  end
end
