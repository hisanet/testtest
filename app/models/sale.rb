# == Schema Information
#
# Table name: sales
#
#  id         :integer          not null, primary key
#  sale_co    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Sale < ApplicationRecord
	validates :user_id,{presence: true}
	validates :sale_co,{presence: true}

	belongs_to :user


end
