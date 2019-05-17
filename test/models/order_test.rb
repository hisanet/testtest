# == Schema Information
#
# Table name: orders
#
#  id                                :integer          not null, primary key
#  kanyuu_price                      :integer
#  mainte_discount                   :float            default(0.0)
#  mainte_discount_add               :float            default(0.0)
#  mainte_discount_month             :integer          default(0)
#  mainte_discount_price             :integer          default(0)
#  mainte_month                      :integer          default(0)
#  mainte_price                      :integer
#  mainte_sprit_discount_price       :float            default(0.0)
#  mainte_sprit_discount_price_total :integer          default(0)
#  mainte_sprit_price                :float            default(0.0)
#  mainte_sprit_price_total          :integer          default(0)
#  mainte_type                       :integer          default(0)
#  mainte_year                       :integer          default(0)
#  mainte_year_price                 :integer          default(0)
#  name                              :string
#  ord_date                          :date
#  other                             :text
#  price                             :integer
#  repayment                         :integer          default(0)
#  ritu                              :integer          default(0)
#  tax_price                         :integer          default(0)
#  total                             :integer          default(0)
#  virus_soft_ics                    :integer          default(0)
#  virus_soft_other                  :integer          default(0)
#  virus_soft_price                  :integer          default(0)
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  corporation_id                    :integer
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
