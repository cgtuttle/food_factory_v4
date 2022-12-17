class Security::UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = Security::User.new
    @companies = Security::Company.all
  end

  def create
    @user = Security::User.new(user_params)
    @user.active = true
    @user.approved = true
    @user.confirmed = true
    if @user.save!
      redirect_to users_path, notice: "Successfully created new user"
    else
      flash.now[:alert] = "Could not create new user"
      render :new
    end
  end

  def edit
    @user = Security::User.find(params[:id])
    @companies = Security::Company.all
  end

  def update
    @user = Security::User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to dashboard_path if !current_user.admin?
      redirect_to users_path if current_user.admin?
    else
      flash.now[:alert] = "Could not update user"
      render :edit
    end
  end

  def index
    authorize current_user
    @users = Security::User.all.order(:email)
  end

  def destroy
  end

  private

  def user_params
    params.require(:security_user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :admin, company_ids:[])
  end
end
