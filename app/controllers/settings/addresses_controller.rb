class Settings::AddressesController < ApplicationController
  before_action :define_resources, only: [:edit, :update, :show, :destroy]

  def new
    @address = Settings::Address.new
  end

  def create
    @address = Settings::Address.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "Successfully created new address"
    else
      flash.now[:alert] = "Could not create new address"
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to address_path(@address), notice: "Successfully updated address"
    else
      flash.now[:alert] = "Could not update address"
      render :edit
    end
  end

  def show
  end

  def index
    @addresses = Settings::Address.all
    @address = Settings::Address.new
  end

  def destroy
    if @address.destroy      
      redirect_to address_path, notice: "Successfully deleted address"
    else
      flash[:alert] = "Could not delete the address"
    end
  end

  private

  def address_params
    params.require(:settings_address).permit(:line_1, :line_2, :city, :state, :postal_code, :country_code, :name, :code)
  end

  def define_resources
    @address = Settings::Address.find_by(id: params[:id])
  end
end
