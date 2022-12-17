class Inventory::ItemClassesController < ApplicationController

  before_action :define_resources

  def new
    @item_class = Inventory::ItemClass.new
  end

  def create
    @item_class = Inventory::ItemClass.new(item_class_params)
    if @item_class.save
      redirect_to item_classes_path, notice: "Successfully created new item_class"
    else
      flash.now[:alert] = "Could not create new item_class"
      render :new
    end
  end

  def edit
  end

  def update
    if @item_class.update(item_class_params)
      redirect_to item_class_path(@item_class), notice: "Successfully updated item_class"
    else
      flash.now[:alert] = "Could not update item_class"
      render :edit
    end
  end

  def show
  end

  def index
    @item_classes = Inventory::ItemClass.all
  end

  def destroy
    if @item_class.destroy      
      redirect_to item_classes_path, notice: "Successfully deleted item_class"
    else
      flash[:alert] = "Could not delete the item_class"
    end
  end

  private

    def item_class_params
      params.require(:inventory_item_class).permit(:name, :code, :lot_format, :product)
    end

    def define_resources
      @id = params[:id]
      @item_class = params[:id].present? ? Inventory::ItemClass.find(params[:id]) : Inventory::ItemClass.new
      @resource = @item_class
    end

end
