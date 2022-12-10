class Sales::OrdersController < ApplicationController
  before_action :define_resources
  helper_method :selection

  def index
  end

  def new
    @order = @customer.orders.new(customer_account_id: @customer.account.id) if params[:customer_id].present?
    @order.lines.build
  end

  def create
    @order = Sales::Order.new(order_params)
    if @order.save!
      redirect_to sales_orders_path, notice: "Successfully created order #{@order.order_number}"
    else
      flash.now[:alert] = "Could not create order"
      render :new
    end
  end

  def edit
    @order.lines.build
  end

  def update
    if @order.update!(order_params)
      redirect_to sales_order_path(@order), notice: "Successfully updated order #{@order.order_number}"
    else
      flash.now[:alert] = "Could not update order"
      render :edit
    end
  end

  def show
  end

  def destroy
    if @order.destroy
      redirect_to sales_orders_path, notice: "Successfully deleted order #{@order.order_number}"
    else
      flash.now[:alert] = "Could not delete order #{@order.order_number}"
      render :show
    end
  end

  private

  def order_params
    params.require(:sales_order).permit(:po_number, :po_pickup_date, :po_ship_date, :order_date, :customer_account_id, 
      :order_number, :bill_to_address_id, :ship_to_address_id, :ship_from_address_id,
      lines_attributes: [:id, :line_number, :item_id, :description, :po_qty, :po_price, :_destroy, :line_total])
  end

  def define_resources
    @id = params[:id]
    @order = params[:id].present? ? Sales::Order.find(params[:id]) : Sales::Order.new
    if params[:customer_id].present?
      @customer = Sales::Customer.find(params[:customer_id])
      @orders = @customer.orders      
    else
      @orders = Sales::Order.all.order(order_number: :desc)
        .includes(:customer_account)
        .includes(:bill_to_address)
        .includes(:ship_to_address)
        .includes(:ship_from_address)
        .includes(:lines)
    end
    @cust_accounts = Settings::Account.where(owner_type: "Sales::Customer").order(:name)
    @loc_accounts = Settings::Account.where(owner_type: "Inventory::Location").order(:name)
    @account_addresses = Settings::AccountAddress.all
  end
  
end
