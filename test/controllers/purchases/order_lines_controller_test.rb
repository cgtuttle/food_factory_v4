require 'test_helper'

class Purchases::OrderLinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchase_order_lines_index_url
    assert_response :success
  end

  test "should get new" do
    get purchase_order_lines_new_url
    assert_response :success
  end

  test "should get edit" do
    get purchase_order_lines_edit_url
    assert_response :success
  end

  test "should get show" do
    get purchase_order_lines_show_url
    assert_response :success
  end

end
