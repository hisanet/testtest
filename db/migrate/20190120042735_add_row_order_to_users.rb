class AddRowOrderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :row_order, :integer
  end
end
