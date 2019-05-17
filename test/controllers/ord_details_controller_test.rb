require 'test_helper'

class OrdDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ord_detail = ord_details(:one)
  end

  test "should get index" do
    get ord_details_url
    assert_response :success
  end

  test "should get new" do
    get new_ord_detail_url
    assert_response :success
  end

  test "should create ord_detail" do
    assert_difference('OrdDetail.count') do
      post ord_details_url, params: { ord_detail: { order_id: @ord_detail.order_id, price: @ord_detail.price, product_id: @ord_detail.product_id, quantity: @ord_detail.quantity, unit_price: @ord_detail.unit_price } }
    end

    assert_redirected_to ord_detail_url(OrdDetail.last)
  end

  test "should show ord_detail" do
    get ord_detail_url(@ord_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_ord_detail_url(@ord_detail)
    assert_response :success
  end

  test "should update ord_detail" do
    patch ord_detail_url(@ord_detail), params: { ord_detail: { order_id: @ord_detail.order_id, price: @ord_detail.price, product_id: @ord_detail.product_id, quantity: @ord_detail.quantity, unit_price: @ord_detail.unit_price } }
    assert_redirected_to ord_detail_url(@ord_detail)
  end

  test "should destroy ord_detail" do
    assert_difference('OrdDetail.count', -1) do
      delete ord_detail_url(@ord_detail)
    end

    assert_redirected_to ord_details_url
  end
end
