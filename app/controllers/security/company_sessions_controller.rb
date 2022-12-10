class Security::CompanySessionsController < ApplicationController

  def new
    case current_user.companies.count
    when 0
      redirect_to new_company_path and return
    when 1
      @current_company = current_user.companies.first
      create
    end
    @companies = current_user.companies
  end

  def create
    @current_company = Security::Company.find(params[:current_company]) if params[:current_company].present?
    logger.debug "create new company session - @current_company: #{@current_company}"
    session[:current_company_id] = @current_company.id
    current_user.update!(company_id: @current_company.id)
    logger.debug "create new company session - session[:current_company_id]: #{session[:current_company_id]}"
    redirect_to dashboard_path
  end

  def destroy
    session[:current_company_id] = nil
  end

  private



end