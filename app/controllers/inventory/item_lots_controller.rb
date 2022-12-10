class Inventory::ItemLotsController < ApplicationController

  before_action :define_resources, only: [:edit, :update, :show, :destroy]
  before_action :define_item, only: [:new, :create, :index]

  def new
    @item_lot = @item.lots.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # @item_lot = @item.lots.new(item_lot_params)
    @item_lot = @item.lots.build(item_lot_params)
    if @item_lot.save
      redirect_to item_lots_path, notice: "Successfully created new item lot"
    else
      flash.now[:alert] = "Could not create new item lot"
      render :new
    end
  end

  def edit
    @item = @item_lot.item
  end

  def update
    if @item_lot.update(item_lot_params)
      redirect_to item_lot_path(@item_lot), notice: "Successfully updated item lot"
    else
      flash.now[:alert] = "Could not update item lot"
      render :edit
    end
  end

  def show
  end

  def index
    @lots = @item.lots.order(lot_code: :desc)
  end

  def destroy
    if @item_lot.destroy      
      redirect_to item_lots_path, notice: "Successfully deleted item lot"
    else
      flash[:alert] = "Could not delete the item lot"
    end
  end

  private

    def item_lot_params
      params.require(:inventory_item_lot).permit(:item_id, :lot_code)
    end

    def define_resources
      @item_lot = Inventory::ItemLot.find(params[:id])
      @resource = @item_lot
    end

    def define_item
      @item = Inventory::Item.find(params[:item_id])
    end

end