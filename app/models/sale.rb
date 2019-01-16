class Sale < ApplicationRecord
	validates :user_id,{presence: true}
	validates :sale_co,{presence: true}

	belongs_to :user


end
