class AddMainteSpritPriceTotalToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_sprit_price_total, :integer,default: 0
  	add_column :orders, :mainte_sprit_discount_price_total, :integer,default: 0
  end
end
