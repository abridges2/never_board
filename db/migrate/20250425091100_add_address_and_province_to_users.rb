class AddAddressAndProvinceToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :address, :string
    add_reference :users, :province, foreign_key: true
  end
end
