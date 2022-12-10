class Inventory::ItemTransactionsController < ApplicationController

  before_action :define_resources

  def new
    @transaction = @item.transactions.new
    gon.item_lot_format = @item.inventory_class.lot_format
  end

  def create
    if Inventory::BuildTransaction.call(params: transaction_params, item_id: params[:item_id])
      redirect_to item_transactions_path(@item), notice: "Successfully created new transaction"
    else
      flash.now[:alert] = "Could not create new transaction"
      render :new
    end
  end

  def index
    @transactions = Inventory::Transaction.with_running_sum({item_id: @item.id})
  end

  private

    def transaction_params
      params.require(:inventory_transaction).permit(:item_lot_id, :transaction_type_id, :location_id, :transaction_date, :base_qty_increase, :base_qty_decrease)
    end

    def define_resources
      @item = Inventory::Item.find(params[:item_id])
      @resource = @item
    end

    def get_item(params)
      Inventory::Item.find(params[:new_item_id]) if params[:new_item_id].present?
    end

end
