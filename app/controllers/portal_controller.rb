class PortalController < ApplicationController
  skip_before_action :require_login

  def welcome
  	@user_session = Security::UserSession.new unless current_user_session
  end

end