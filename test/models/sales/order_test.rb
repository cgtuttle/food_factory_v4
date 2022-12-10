require 'test_helper'

class Sales::OrderTest < ActiveSupport::TestCase
  setup do 
    @customer = sales_customers(:customer_one)
    @order = sales_orders(:order_one)
  end

  test "the truth" do
    assert true
  end

  test "customer_should_have_an_order" do
    assert_equal 1, @customer.orders.count
  end

end
