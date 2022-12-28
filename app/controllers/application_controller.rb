class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user_session, :current_user, :current_customer, :current_company
  around_action :scope_current_company
  before_action :require_login, :update_path, :set_layout


  private
    def update_path
      if session[:current_path] != request.path # Refreshed - don't update breadcrumbs
        session[:previous_controller] = session[:current_controller] || "dashboard"
        session[:previous_action] = session[:current_action] || "show"
        session[:previous_path] = session[:current_path] || dashboard_path
        session[:current_controller] = controller_name
        session[:current_action] = action_name
        session[:current_path] = request.path
      end
    end

    def set_layout
      if action_name == 'welcome'
        self.class.layout 'welcome_container'
      else
        self.class.layout 'app_container'
      end
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = Security::UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def user_signed_in?
      !! current_user_session
    end

    def require_login
      if !user_signed_in?
        logger.debug "User not logged in"
        redirect_to welcome_path
      end
    end

    def current_company
      Security::Company.find_by id: session[:current_company_id]
    end

    def scope_current_company
      Security::Company.current_id = current_company.present? ? current_company.id : nil
      yield
    ensure
      Security::Company.current_id = nil
    end

    def current_filter
      @current_filter ||= session[:user_filter] &&
        Settings::Filter.find(session[:user_filter])
    end

    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      logger.info "Security path interrupted - user_not_authorized."
      redirect_to(request.referrer || root_path)
    end

    def current_customer
      @current_customer ||= session[:current_customer_id] &&
        Sales::Customer.find(session[:current_customer_id])
    end


end
