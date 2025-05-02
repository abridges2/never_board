class FixProvinceColumnOnOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :province, :string
    add_reference :orders, :province, foreign_key: true
  end
end
