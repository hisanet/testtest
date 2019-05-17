class AddMainteYearPriceToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :mainte_year_price, :integer
  	add_column :orders, :mainte_year, :integer
  	add_column :orders, :mainte_type, :integer
  end
end
