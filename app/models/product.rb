# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  code             :string
#  mainte_yearprice :integer
#  name             :string
#  name_kana        :string
#  price            :integer
#  purchase_cost    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_id      :integer
#

class Product < ApplicationRecord
	belongs_to :category
	has_many :ord_details
	scope :search, lambda { |query| where('name LIKE ?', "%#{query}%").order(category_id: "ASC").order(updated_at: "desc").limit(100) }
end
