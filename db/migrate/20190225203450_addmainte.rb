class Addmainte < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :mainte, :integer
  end
end
