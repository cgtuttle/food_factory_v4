class Settings::FiltersController < ApplicationController

  def new
    @filter = Settings::Filter.new
  end

  def create
    @filter = Settings::Filter.new(filter_params)
    @filter.build
    session[:user_filter] = @filter.id
  end

  def destroy
    @filter = settings::Filter.find(params[:id])
    @filter.destroy
    session[:user_filter] = nil
  end

  private

  def filters_params
    params.require(:filter).permit(:name, :user_id, :company_id, :columns[])
  end

end