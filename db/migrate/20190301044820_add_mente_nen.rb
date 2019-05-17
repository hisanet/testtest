class AddMenteNen < ActiveRecord::Migration[5.2]
  def change
  	add_column :ord_details,:mainte_yearprice, :integer
  end
end
