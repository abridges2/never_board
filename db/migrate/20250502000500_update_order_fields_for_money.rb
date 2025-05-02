class UpdateOrderFieldsForMoney < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :subtotal, :float
    remove_column :orders, :total, :float
    remove_column :orders, :gst, :float
    remove_column :orders, :pst, :float
    remove_column :orders, :hst, :float

    add_column :orders, :subtotal_cents, :integer, default: 0
    add_column :orders, :total_cents, :integer, default: 0
    add_column :orders, :gst_cents, :integer, default: 0
    add_column :orders, :pst_cents, :integer, default: 0
    add_column :orders, :hst_cents, :integer, default: 0
  end
end
