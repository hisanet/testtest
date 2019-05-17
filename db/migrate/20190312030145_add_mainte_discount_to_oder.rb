class AddMainteDiscountToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_discount, :float
  end
end
