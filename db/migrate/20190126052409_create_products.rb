class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :name_kana
      t.integer :price
      t.integer :purchase_cost

      t.timestamps
    end
  end
end
