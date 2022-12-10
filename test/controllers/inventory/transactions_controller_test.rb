require 'test_helper'

class Inventory::TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inventory_transactions_new_url
    assert_response :success
  end

  test "should get show" do
    get inventory_transactions_show_url
    assert_response :success
  end

  test "should get index" do
    get inventory_transactions_index_url
    assert_response :success
  end

  test "should get edit" do
    get inventory_transactions_edit_url
    assert_response :success
  end

end
