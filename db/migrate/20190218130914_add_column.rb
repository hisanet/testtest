class AddColumn < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :ord_date, :date
  end
end
