class Inventory::ItemsController < ApplicationController

  before_action :define_resources

  def new
    @item = Inventory::Item.new
  end

  def create
    @item = Inventory::Item.new(item_params)
    if Inventory::BuildItem.call(@item)
      redirect_to items_path, notice: "Successfully created new item"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Successfully updated item"
    else
      flash.now[:alert] = "Could not update item"
      render :edit
    end
  end

  def show
  end

  def index
    @items = Inventory::Item.joins(:base_unit, :inventory_class).all
  end

  def destroy
    if @item.destroy      
      redirect_to items_path, notice: "Successfully deleted item"
    else
      flash[:alert] = "Could not delete the item"
    end
  end

  private

    def item_params
      params.require(:inventory_item).permit(:name, :code, :item_class_id, :base_unit_id, location_ids: [])
    end

    def define_resources
      @id = params[:id]
      @item = params[:id].present? ? Inventory::Item.joins(:base_unit, :inventory_class).find(params[:id]) : Inventory::Item.new
      @resource = @item
    end

end
