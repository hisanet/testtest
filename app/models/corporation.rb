# == Schema Information
#
# Table name: corporations
#
#  id         :integer          not null, primary key
#  name       :string
#  name_kana  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Corporation < ApplicationRecord
	has_many :orders
end
