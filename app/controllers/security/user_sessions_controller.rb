class Security::UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new
    @user_session = Security::UserSession.new
  end

  def create
    @user_session = Security::UserSession.new(user_session_params.to_h)
    logger.debug "user_session retrieved: #{@user_session.inspect}"
    if @user_session.save
      if current_user.company_id.present?
        session[:current_company_id] = current_user.company_id
        redirect_to dashboard_path, notice: "successfully logged in #{current_user.email}"
      else
        logger.debug "No company session - creating one"
        redirect_to new_company_session_path and return
      end
    else
      logger.debug @user_session.errors.inspect
      flash[:error] = "Could not log in user"
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:security_user_session).permit(:email, :password, :remember_me)
  end
end