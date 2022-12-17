class Purchases::VendorsController < ApplicationController
  before_action :define_resources, only: [:edit, :update, :show, :destroy]  

  def index
    @vendors = Purchases::Vendor.all
  end

  def new
    @vendor = Purchases::Vendor.new
  end

  def create
    @vendor = Purchases::Vendor.new(vendor_params)
    if @vendor.process_new
      redirect_to vendors_path, notice: "Successfully created new vendor"
    else
      render new
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to vendor_path(@vendor), notice: "Successfully updated vendor"
    else
      flash.now[:alert] = "Could not update vendor"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @vendor.destroy      
      redirect_to vendors_path, notice: "Successfully deleted vendor"
    else
      flash[:alert] = "Could not delete the vendor"
    end
  end

  private

    def vendor_params
      params.require(:purchases_vendor).permit(:name, :code)
    end

    def define_resources
      @vendor = Purchases::Vendor.find(params[:id])
    end

end
