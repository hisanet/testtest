class AddTaxpriceToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :tax_price, :integer,default: 0
  	add_column :orders, :sub_total, :integer,default: 0
  end
end
