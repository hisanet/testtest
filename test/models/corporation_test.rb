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

require 'test_helper'

class CorporationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
