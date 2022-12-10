require 'test_helper'

class Inventory::LocationTest < ActiveSupport::TestCase
  def setup    
    @location = Sales::Customer.create(name: "Test", code: "TEST")
    @address = Settings::Address.create(account_id: @location.account.id, address_1: "1234 Main Street")
  end

  test "the truth" do
    assert true
  end

  test "new location should create an account" do
    assert_equal "Test", @location.account.name
  end

  test "location should have an address" do    
    assert_equal @address.address_1, @location.address.address_1
  end
end
