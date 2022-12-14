module Inventory
  class BuildItem < ApplicationProcess
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      if @item.save
        @item_lot = @item.lots.create!(lot_code: "None")
        return @item
      end
      return false
    end
  end
end