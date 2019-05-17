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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
