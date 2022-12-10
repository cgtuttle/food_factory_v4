require 'test_helper'

class Inventory::ReceiptItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inventory_receipt_items_new_url
    assert_response :success
  end

  test "should get show" do
    get inventory_receipt_items_show_url
    assert_response :success
  end

  test "should get index" do
    get inventory_receipt_items_index_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_receipt_items_edit_url
    assert_response :success
  end

end
