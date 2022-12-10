class Inventory::ItemLotTransactionsController < ApplicationController

  before_action :define_resources

  def new
    @transaction = @lot.transactions.new
  end

  def create
    if Inventory::BuildTransaction.call(params: transaction_params, lot_id: params[:item_lot_id])
      redirect_to item_lot_transactions_path(@lot), notice: "Successfully created new transaction"
    else
      flash.now[:alert] = "Could not create new transaction"
      render :new
    end
  end

  def index
    @transactions = Inventory::Transaction.with_running_sum({item_id: @item.id, item_lot_id: @lot.id})
  end

  def destroy
    if @transaction.destroy      
      redirect_to transactions_path, notice: "Successfully deleted transaction"
    else
      flash[:alert] = "Could not delete the transaction"
    end
  end

  private

    def transaction_params
      params.require(:inventory_transaction).permit(:item_lot_id, :transaction_type_id, :location_id, :transaction_date, :base_qty_increase, :base_qty_decrease, :item_id)
    end

    def define_resources
      @lot = get_lot(params)
      @item = @lot.item
      @resource = @lot
    end

    def get_lot(params)
      if params[:item_lot_id].present?
        lot = Inventory::ItemLot.find(params[:item_lot_id])
      end
    end


end
