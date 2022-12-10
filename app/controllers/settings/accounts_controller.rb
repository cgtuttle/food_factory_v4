class Settings::AccountsController < ApplicationController
  before_action :define_resources, only: [:edit, :update, :show, :destroy]

  def new
    @account = Settings::Account.new
  end

  def create
    @account = Settings::Account.new(account_params)
    if @account.save
      redirect_to accounts_path, notice: "Successfully created #{@account.name}"
    else
      flash.now[:alert] = "Unable to create #{account.name}"
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account), notice: "Successfully updated #{account.name}"
    else
      flash.now[:alert] = "Unable to update #{account.name}"
      render :edit
    end
  end

  def show
  end

  def index
    @accounts = Settings::Account.all
  end

  def destroy
    name = @account.name
    if @account.destroy
      redirect_to accounts_path, notice: "successfully deleted #{name}"
    else
      flash.now[:alert] = "Could not delete #{name}"
      render :show
    end
  end

  private

  def accounts_params
    params.require(:settings_account).permit(:code, :name, :default_relationship, :entity_type)
  end

  def define_resources
    @account = Settings::Account.find(params[:id])
  end

  def set_back_path
    @back_path = session[:back_path] if session[:back_path].present?
    case action_name
    when "show"
      @back_path = url_for(action: 'show')
    when "index"
      @back_path = url_for(action: 'index')
    else 
      @back_path || @back_path = url_for(action: 'index')
    end
    session[:back_path] = @back_path
  end

end