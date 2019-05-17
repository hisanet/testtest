class AddVirusSoftToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :virus_soft_price, :integer
  	add_column :orders, :virus_soft_ics, :integer
  	add_column :orders, :virus_soft_other, :integer
  end
end
