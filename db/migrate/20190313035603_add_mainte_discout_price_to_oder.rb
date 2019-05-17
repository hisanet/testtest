class AddMainteDiscoutPriceToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_discount_price, :integer
  end
end
