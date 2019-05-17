class ChangeMainteTable < ActiveRecord::Migration[5.2]
  def change
  	rename_column :products, :hmodel_id, :category_id
  end
end
