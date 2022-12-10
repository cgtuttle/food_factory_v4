require 'test_helper'

class Inventory::ShipmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inventory_shipments_new_url
    assert_response :success
  end

  test "should get show" do
    get inventory_shipments_show_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_shipments_edit_url
    assert_response :success
  end

  test "should get index" do
    get inventory_shipments_index_url
    assert_response :success
  end

end
