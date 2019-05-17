class AddOrdMainte < ActiveRecord::Migration[5.2]
  def change
  	add_column :ord_details, :mainte_bool, :boolean, default: true, null: false
  end
end
