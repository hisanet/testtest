# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  age        :integer
#  email      :string
#  name       :string
#  row_order  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#

class User < ApplicationRecord
	include RankedModel
	ranks :row_order
	
	validates :age,{presence: true}
	has_many :sales, dependent: :destroy
	belongs_to :user

	scope :search, lambda { |query| where('name LIKE ?', "%#{query}%").limit(100) }


end
