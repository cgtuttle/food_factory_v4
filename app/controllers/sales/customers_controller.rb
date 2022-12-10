class Sales::CustomersController < ApplicationController
  before_action :define_resources, only: [:edit, :update, :show, :destroy]  

  def index
    @customers = Sales::Customer.includes(:account).all
  end

  def new
    @customer = Sales::Customer.new
    @account = Settings::Account.new
  end

  def create
    if Sales::Customer.create(customer_params)
      redirect_to customers_path, notice: "Successfully created new customer"
    else
      flash[:alert] = "Unable to create new customer"
      render new
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      redirect_to customer_path(@customer), notice: "Successfully updated customer"
    else
      flash.now[:alert] = "Could not update customer"
      render :edit
    end
  end

  def show
    @addresses = @customer.addresses
  end

  def destroy
    if @customer.destroy      
      redirect_to customers_path, notice: "Successfully deleted customer"
    else
      flash[:alert] = "Could not delete the customer"
    end
  end

  private

    def customer_params
      params.require(:sales_customer).permit(:id, account_attributes: [:name, :code])
    end

    def define_resources
      @customer = Sales::Customer.find(params[:id])
      @account = @customer.account
      session[:current_customer_id] = @customer.id
    end
end
