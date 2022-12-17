class Settings::UnitsController < ApplicationController
  before_action :define_resources, only: [:edit, :update, :show, :destroy]

  def new
    @unit = Settings::Unit.new
  end

  def create
    @unit = Settings::Unit.new(unit_params)
    if @unit.save
      redirect_to units_path, notice: "Successfully created new unit of measure"
    else
      flash.now[:alert] = "Could not create new unit of measure"
      render :new
    end
  end

  def edit
  end

  def update
    if @unit.update(unit_params)
      redirect_to unit_path(@unit), notice: "Successfully updated unit of measure"
    else
      flash.now[:alert] = "Could not update unit of measure"
      render :edit
    end
  end

  def show
  end

  def index
    @units = Settings::Unit.all
    @unit = Settings::Unit.new
  end

  def destroy
    if @unit.destroy      
      redirect_to units_path, notice: "Successfully deleted unit"
    else
      flash[:alert] = "Could not delete the unit"
    end
  end

  private

  def unit_params
    params.require(:settings_unit).permit(:code, :name, :abbrev)
  end

  def define_resources
    @unit = Settings::Unit.find(params[:id])
    @resource = @unit
  end

end
