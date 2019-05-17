class AddOrdMainte2 < ActiveRecord::Migration[5.2]
  def change
  	add_column :ord_details,:mainte, :integer
  end
end
