module Inventory
  class CreateTransaction < ApplicationProcess

    def initialize(params)
      @params = params
      @item = Inventory::Item.find(transaction_params[:item_id])
    end

    def call
      @transaction = Inventory::Transaction.new(transaction_params)
      @transaction.item_lot_id = transaction_item_lot.id
      @transaction.save!
      @transaction
    end

    def transaction_item_lot
      if @params[:add_new]
        @params[:new_item_lot_text].present? ? lot_code = @params[:new_item_lot_text] : lot_code = @params[:new_item_lot_date]
        @item_lot = @item.lots.create!(lot_code: lot_code)
      else
        @item_lot = @item.lots.find(transaction_params[:item_lot_id])
      end
    end

    private

    def transaction_params
      @params.require(:inventory_transaction).permit(:item_lot_id, :transaction_type_id, :location_id, :transaction_date, :base_qty_increase, :base_qty_decrease, :item_id)
    end

  end
end