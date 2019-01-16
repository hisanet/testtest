class User < ApplicationRecord
	validates :age,{presence: true}
	has_many :sales, dependent: :destroy

	scope :search, lambda { |query| where('name LIKE ?', "%#{query}%").limit(100) }
end
