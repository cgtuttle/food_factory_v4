require 'test_helper'

class Sales::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_customers_index_url
    assert_response :success
  end

  test "should get new" do
    get sales_customers_new_url
    assert_response :success
  end

  test "should get edit" do
    get sales_customers_edit_url
    assert_response :success
  end

  test "should get show" do
    get sales_customers_show_url
    assert_response :success
  end

end
