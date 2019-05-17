require "application_system_test_case"

class OrdDetailsTest < ApplicationSystemTestCase
  setup do
    @ord_detail = ord_details(:one)
  end

  test "visiting the index" do
    visit ord_details_url
    assert_selector "h1", text: "Ord Details"
  end

  test "creating a Ord detail" do
    visit ord_details_url
    click_on "New Ord Detail"

    fill_in "Order", with: @ord_detail.order_id
    fill_in "Price", with: @ord_detail.price
    fill_in "Product", with: @ord_detail.product_id
    fill_in "Quantity", with: @ord_detail.quantity
    fill_in "Unit Price", with: @ord_detail.unit_price
    click_on "Create Ord detail"

    assert_text "Ord detail was successfully created"
    click_on "Back"
  end

  test "updating a Ord detail" do
    visit ord_details_url
    click_on "Edit", match: :first

    fill_in "Order", with: @ord_detail.order_id
    fill_in "Price", with: @ord_detail.price
    fill_in "Product", with: @ord_detail.product_id
    fill_in "Quantity", with: @ord_detail.quantity
    fill_in "Unit Price", with: @ord_detail.unit_price
    click_on "Update Ord detail"

    assert_text "Ord detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Ord detail" do
    visit ord_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ord detail was successfully destroyed"
  end
end
