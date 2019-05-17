class ChangeRituToOrder < ActiveRecord::Migration[5.2]
  def change
  	change_column :orders, :ritu, :integer,default: 0
  end
end
