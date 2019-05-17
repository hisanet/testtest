class AddRepeymentToOder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :repayment, :integer,default: 0
  	add_column :orders, :other, :text, null: true
  end
end
