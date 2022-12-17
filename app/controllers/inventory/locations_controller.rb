class Inventory::LocationsController < ApplicationController

  before_action :define_resources

  def new
    @location = Inventory::Location.new
  end

  def create
    @location = Inventory::Location.new(location_params)
    if @location.save
      redirect_to locations_path, notice: "Successfully created new location"
    else
      flash.now[:alert] = "Could not create new location"
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to location_path(@location), notice: "Successfully updated location"
    else
      flash.now[:alert] = "Could not update location"
      render :edit
    end
  end

  def show
  end

  def index
    @locations = Inventory::Location.all
  end

  def destroy
    if @location.destroy      
      redirect_to locations_path, notice: "Successfully deleted location"
    else
      flash[:alert] = "Could not delete the location"
    end
  end

  private

    def location_params
      params.require(:inventory_location).permit(:name, :code, :account_id)
    end

    def define_resources
      @id = params[:id]
      @location = params[:id].present? ? Inventory::Location.find(params[:id]) : Inventory::Location.new
      @resource = @location
    end

end
