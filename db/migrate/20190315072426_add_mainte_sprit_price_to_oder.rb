class AddMainteSpritPriceToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_sprit_price, :float,default: 0
  	add_column :orders, :mainte_sprit_discount_price, :float,default: 0
  end
end
