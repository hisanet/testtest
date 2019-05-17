class ChangeDataTitleProduct < ActiveRecord::Migration[5.2]
  def change
  	change_column :products, :mainte, :boolean
  end
end
