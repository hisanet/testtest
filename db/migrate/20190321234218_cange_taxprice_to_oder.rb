class CangeTaxpriceToOder < ActiveRecord::Migration[5.2]
  def change
  	rename_column :orders, :sub_total, :total
  end
end
