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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
