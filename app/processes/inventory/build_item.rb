module Inventory
  class BuildItem < ApplicationProcess
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      @item.save!
      @item_lot = @item.lots.create!(lot_code: "None")
      return @item
    end

  end
end