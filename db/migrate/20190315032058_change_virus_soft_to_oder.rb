class ChangeVirusSoftToOder < ActiveRecord::Migration[5.2]
  def change
  	change_column  :orders, :virus_soft_price, :integer,default: 0
  	change_column  :orders, :virus_soft_ics, :integer,default: 0
  	change_column  :orders, :virus_soft_other, :integer,default: 0
  end
end
