class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.float :subtotal
      t.float :total
      t.float :gst
      t.float :pst
      t.float :hst

      t.timestamps
    end
  end
end
