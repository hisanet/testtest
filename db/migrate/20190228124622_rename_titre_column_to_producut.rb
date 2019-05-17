class RenameTitreColumnToProducut < ActiveRecord::Migration[5.2]
  def change
  	rename_column :products, :model_id, :hmodel_id
  end
end
