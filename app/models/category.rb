# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  mainte_add :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
	has_many :products
	has_many :ord_details,through: :products
end
