# == Schema Information
#
# Table name: ord_details
#
#  id               :integer          not null, primary key
#  mainte           :integer
#  mainte_bool      :boolean          default(TRUE), not null
#  mainte_yearprice :integer
#  price            :integer
#  quantity         :integer
#  row_order        :integer
#  unit_price       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :integer
#  product_id       :integer
#

require 'test_helper'

class OrdDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
