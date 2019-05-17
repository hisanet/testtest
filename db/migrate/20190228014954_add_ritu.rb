class AddRitu < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders,:ritu, :integer
  	add_column :orders,:kanyuu_price, :integer
  	add_column :orders,:mainte_price, :integer
  end
end
