require 'test_helper'

class Inventory::ItemClassesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inventory_item_classes_index_url
    assert_response :success
  end

  test "should get new" do
    get inventory_item_classes_new_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_item_classes_edit_url
    assert_response :success
  end

  test "should get show" do
    get inventory_item_classes_show_url
    assert_response :success
  end

end
