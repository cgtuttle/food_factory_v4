require 'test_helper'

class Sales::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_orders_index_url
    assert_response :success
  end

  test "should get new" do
    get sales_orders_new_url
    assert_response :success
  end

  test "should get edit" do
    get sales_orders_edit_url
    assert_response :success
  end

  test "should get show" do
    get sales_orders_show_url
    assert_response :success
  end

end
