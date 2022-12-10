class Inventory::TransactionTypesController < ApplicationController

  before_action :define_resources, only: [:edit, :update, :show, :destroy, :index]

  def new
    @transaction_type = Inventory::TransactionType.new
  end

  def create
    @transaction_type = Inventory::TransactionType.new(transaction_type_params)
    if @transaction_type.save
      redirect_to transaction_types_path, notice: "Successfully created new transaction type"
    else
      flash.now[:alert] = "Could not create new transaction type"
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction_type.update_attributes(transaction_type_params)
      redirect_to transaction_type_path(@transaction_type), notice: "Successfully updated transaction type"
    else
      flash.now[:alert] = "Could not update transaction type"
      render :edit
    end
  end

  def show
  end

  def index
    @transaction_types = Inventory::TransactionType.all
  end

  def destroy
    if @transaction_type.destroy      
      redirect_to transaction_types_path, notice: "Successfully deleted transaction type"
    else
      flash[:alert] = "Could not delete the transaction type"
    end
  end

  private

    def transaction_type_params
      params.require(:inventory_transaction_type).permit(:code, :name, :default_direction)
    end

    def define_resources
      @id = params[:id]
      if params[:id]
        @transaction_type = Inventory::TransactionType.find(params[:id])
      else
        @transaction_type = Inventory::TransactionType.new
      end
    end

end