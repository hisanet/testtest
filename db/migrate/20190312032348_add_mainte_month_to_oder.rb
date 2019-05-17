class AddMainteMonthToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_month, :integer
  end
end
