class Inventory::ItemTransactionsController < ApplicationController

  before_action :define_resources

  def new
    @transaction = @item.transactions.new
    gon.item_lot_format = @item.inventory_class.lot_format
    gon.item_id = @item.id
    logger.debug "gon.item_id = #{gon.item_id}"
  end

  def create
    if Inventory::BuildTransaction.call(transaction_params, @item.id)
      redirect_to item_transactions_path(@item), notice: "Successfully created new transaction"
    else
      flash.now[:alert] = "Could not create new transaction"
      render :new
    end
  end

  def index
    arg_hash = {item_id: @item.id}
    transactions = @item.transactions
    @transactions = transactions.with_running_sum(arg_hash)
    gon.item_id = @item.id
    logger.debug "gon.item_id = #{gon.item_id}"
  end

  private

    def transaction_params
      params.require(:inventory_transaction).permit(:item_id, :item_lot_id, :new_item_lot_code, :expire_date, :transaction_type_id, :location_id, :transaction_date, :base_qty_increase, :base_qty_decrease)
    end

    def define_resources
      @item = Inventory::Item.find(params[:item_id])
      if params[:transaction_id]
        @transaction = Inventory::Transaction.find(params[:transaction_id])
        @item = @transaction.item
        @lot = @transaction.item_lot
      else
        @transaction = Inventory::Transaction.new
      end
      @resource = @item
    end

    def get_item(params)
      Inventory::Item.find(params[:new_item_id]) if params[:new_item_id].present?
    end

end
