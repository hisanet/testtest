class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :user_id
      t.integer :sale_co

      t.timestamps
    end
  end
end
