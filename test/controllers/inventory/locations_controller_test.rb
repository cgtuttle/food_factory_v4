require 'test_helper'

class Inventory::LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inventory_locations_index_url
    assert_response :success
  end

  test "should get new" do
    get inventory_locations_new_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_locations_edit_url
    assert_response :success
  end

  test "should get show" do
    get inventory_locations_show_url
    assert_response :success
  end

end
