class Sales::AddressesController < ApplicationController
  before_action :define_resources

  def new
    @address = @customer.addresses.new
  end

  def create
    @address = Settings::Address.new(customer_address_params)
    if @address.save
      if @customer_address = @customer.account_addresses.create(address: @address)
        redirect_to customer_addresses_path(@customer), notice: "Successfully added new address"
      else
        flash.now[:alert] = "Could not associate new address with customer"
        render :new
      end
    else
      flash.now[:alert] = "Could not create new address"
      render :new
    end
  end

  def index
  end

  def show
  end

private

  def customer_address_params
    params.require(:settings_address).permit(:code, :name, :company_id, :line_1, :line_2, :city, :state, :postal_code, :country_code)
  end

  def define_resources
    @customer = Sales::Customer.find(params[:customer_id])
    @address = Settings::Address.find(params[:id]) if params[:id]
    @addresses = @customer.addresses
  end

end