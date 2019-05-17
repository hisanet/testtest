class ChangeDiscountToOrder < ActiveRecord::Migration[5.2]
  def change
  	change_column :orders, :mainte_discount, :float,default: 0
  end
end
