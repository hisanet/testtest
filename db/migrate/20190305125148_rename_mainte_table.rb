class RenameMainteTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :mainte, :boolean
  	add_column :products, :mainte_yearprice, :integer
  end
end
