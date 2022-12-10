class Inventory::TransactionsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :define_resources

  def new
    @transaction = Inventory::Transaction.new
    @items = Inventory::Item.order(:code)
  end

  def create
    if Inventory::BuildTransaction.call(transaction_params)
      redirect_to transactions_path, notice: "Successfully created new transaction"
    else
      flash.now[:alert] = "Could not create new transaction"
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction), notice: "Successfully updated transaction"
    else
      flash.now[:alert] = "Could not update transaction"
      render :edit
    end
  end

  def show
  end

  def index
    @transactions = Inventory::Transaction.with_running_sum()
  end

  def destroy
    if @transaction.destroy      
      redirect_to transactions_path, notice: "Successfully deleted transaction"
    else
      flash[:alert] = "Could not delete the transaction"
    end
  end

  def balances
    item = Inventory::Item.find(params[:item_id])
    lot_id = params[:lot_id]
    as_of = params[:transaction_date]
    balance = item.inventory_balance(as_of)
    lot_balance = item.lot_inventory_balance(lot_id, as_of)
    balances = [lot_balance, balance]

    respond_to do |format|
      format.json {render json: balances}
    end
  end


  private

    def transaction_params
      params.require(:inventory_transaction).permit(:item_lot_id, :transaction_type_id, :location_id, :transaction_date, :base_qty_increase, :base_qty_decrease, :item_id, :new_item_lot_code, :expire_date)
    end

    def define_resources
      @id = params[:id]
      if params[:id]
        @transaction = Inventory::Transaction.find(params[:id])
        @item = @transaction.item
        @lot = @transaction.item_lot
      else
        @transaction = Inventory::Transaction.new
      end
      @resource = @transaction
    end

    def sort_column
      columns.include?(params[:sort]) ? params[:sort] : "transaction_date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def columns
      ["inventory_items.code", "inventory_items.name", "transaction_date", "inventory_item_lots.lot_code", "inventory_locations.name", "type"]
    end

end
