class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :corporation_id
      t.integer :price

      t.timestamps
    end
  end
end
