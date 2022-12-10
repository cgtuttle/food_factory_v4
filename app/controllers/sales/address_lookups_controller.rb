class Sales::AddressLookupsController < ApplicationController

  def index
    @account = Settings::Account.find(params[:customer_id])
    @addresses = @account.addresses.select(:id, :name)
    respond_to do |format|
      format.json {render json: @addresses}
    end
  end

end