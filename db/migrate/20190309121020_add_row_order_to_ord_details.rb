class AddRowOrderToOrdDetails < ActiveRecord::Migration[5.2]
  def change
  	add_column :ord_details, :row_order, :integer
  end
end
