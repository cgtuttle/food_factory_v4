require 'test_helper'

class Purchases::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchase_orders_index_url
    assert_response :success
  end

  test "should get new" do
    get purchase_orders_new_url
    assert_response :success
  end

  test "should get edit" do
    get purchase_orders_edit_url
    assert_response :success
  end

  test "should get show" do
    get purchase_orders_show_url
    assert_response :success
  end

end
