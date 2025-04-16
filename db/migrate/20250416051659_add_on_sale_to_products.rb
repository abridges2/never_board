class AddOnSaleToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :on_sale, :boolean, default: false
    add_column :products, :sale_price_cents, :integer
  end
end
