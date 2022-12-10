class Inventory::ProductsController < ApplicationController

  before_action :define_resources
  before_action :define_item, only: [:new, :edit, :show, :index]

  def new
    @product = Inventory::Product.new
  end

  def create
    @product = Inventory::Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Successfully created new product"
    else
      flash.now[:alert] = "Could not create new product"
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Successfully updated product"
    else
      flash.now[:alert] = "Could not update product"
      render :edit
    end
  end

  def show
  end

  def index
    if @item
      @products = @item.products
    else
      @products = Inventory::Product.all
    end
  end

  def destroy
    if @product.destroy      
      redirect_to products_path, notice: "Successfully deleted product"
    else
      flash[:alert] = "Could not delete the product"
    end
  end

  private

    def product_params
      params.require(:inventory_product).permit(:item_id, :name, :code, :unit_qty, :gtin_14, :unit_upc, :height, :length, :width, :weight, :layer_qty, :pallet_layers)
    end

    def define_resources
      @id = params[:id]
      @product = params[:id].present? ? Inventory::Product.find(params[:id]) : Inventory::Product.new
      @resource = @product
    end

    def define_item
      if params[:item_id].present?
        @item = Inventory::Item.find(params[:item_id])
      end
    end

end