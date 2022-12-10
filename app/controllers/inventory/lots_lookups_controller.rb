class Inventory::LotsLookupsController < ApplicationController

  def index
    @item = Inventory::Item.find(params[:item_id])
    @lots = @item.lots.select(:id, :lot_code)
    respond_to do |format|
      format.json {render json: @lots}
    end
  end
end