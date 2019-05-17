class ChangeMainteToOrder < ActiveRecord::Migration[5.2]
  def change
  	change_column :orders, :mainte_discount_month, :integer,default: 0
  	change_column :orders, :mainte_discount_price, :integer,default: 0
  	change_column :orders, :mainte_month, :integer,default: 0
  	change_column :orders, :mainte_year_price, :integer,default: 0
  	change_column :orders, :mainte_year, :integer,default: 0
  	change_column :orders, :mainte_type, :integer,default: 0
  end
end
