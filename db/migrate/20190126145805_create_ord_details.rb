class CreateOrdDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :ord_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :unit_price
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
