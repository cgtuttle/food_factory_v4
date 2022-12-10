require 'test_helper'

class Sales::CustomerTest < ActiveSupport::TestCase
  def setup    
    @customer = Sales::Customer.create(name: "Test", code: "TEST")
    @address = Settings::Address.create(account_id: @customer.account.id, address_1: "1234 Main Street")
  end

  test "the truth" do
    assert true
  end

  test "new customer should create an account" do
    assert_equal "Test", @customer.account.name
  end

  test "customer should have an address" do    
    assert_equal @address.address_1, @customer.address.address_1
  end
end
