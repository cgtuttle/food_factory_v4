module Inventory
  class BuildTransaction < ApplicationProcess

    def initialize(params, item_id = nil, lot_id = nil)
      @params = params
      @item_id = @params[:item_id] ? @params[:item_id] : item_id
      @item = Inventory::Item.find(@item_id)    
      @lot_id = lot_id || "None"
    end

    def call
      @transaction = @item.transactions.new(@params)
      @item_lot = define_item_lot
      @transaction.item_lot = @item_lot
      @transaction.save!
    end

    # def define_item_lot
    #   if @params[:add_new]
    #     @params[:new_item_lot_text].present? ? lot_code = @params[:new_item_lot_text] : lot_code = @params[:new_item_lot_date]
    #     @item_lot = @item.lots.create!(lot_code: lot_code)
    #   else
    #     # item_lot_transactions returns item_lot_id outside of transaction_params
    #     lot_id = @params[:item_lot_id] ? @params[:item_lot_id] : @lot_id
    #     @item_lot = @item.lots.find(lot_id)
    #   end
    # end

    def define_item_lot
      if @params[:item_lot_id] == "new"
        @item_lot = @item.lots.create!(lot_code: @params[:new_item_lot_code], expire_date: @params[:expire_date])
      else
        # @item_lot = @item.lots.find(@params[:new_item_lot_code])
        @item_lot = @item.lots.find(@params[:item_lot_id])
      end
    end

  end
end