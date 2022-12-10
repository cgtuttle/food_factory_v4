class Sales::OrderLinesController < ApplicationController

  def new
  end

  def create
    @order_line = Sales::Order.new(order_line_params)
    if @order_line.save!
      redirect_to sales_order_path(@order_line.order), notice: "Successfully added order line #{@order_line.line_number}"
    else
      flash[:alert] = "Unable to create new line for order #{@order.order_number}"
    end
  end

  def edit
  end

  def update
    if @order_line.update(order_line_params)
      redirect_to sales_order_path(@order_line.order), notice: "Successfully updated order line #{@order_line.line_number}"
    else
      flash[:alert] = "Unable to update order line #{@order_line.line_number}"
    end
  end

  def destroy
    if @order_line.destroy
      flash.now[:notice] = "Successfully deleted order #{@order_line.line_number}"
    else
      flash.now[:alert] = "Could not delete line #{@order_line.line_number}"
    end
    redirect_to sales_order_path(@order_line.order)
  end

  private

  def order_line_params
    params.require(:sales_order_line).permit(:number, :description, :qty, :order_id, :item_id)
  end

  def define_resources
    if params[:order_id].present?
      @order = Sales::Order.find(params[:order_id])
      @order_line = @order.lines.new
    end
    if params[:id].present?
      @order_line = Sales::OrderLine.find(params[:id])
      @order = @order_line.order
    end
  end

end
