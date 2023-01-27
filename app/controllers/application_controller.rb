class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user_session, :current_user, :current_customer, :current_company
  around_action :scope_current_company
  before_action :require_login, :update_path, :set_layout, :update_paths

  def update_paths
    @previous_controller = session[:previous_controller]
    @previous_action = session[:previous_action]
    @previous_path = session[:previous_path]
    @current_controller = session[:current_controller]
    @current_action = session[:current_action]
    @current_path = session[:current_path]
    @current_module = self.class.name.deconstantize
    @current_page = self.class.name.demodulize
    logger.debug "@previous_controller: #{@previous_controller}"
    logger.debug "@previous_action: #{@previous_action}"
    logger.debug "@previous_path: #{@previous_path}"
    logger.debug "@current_controller: #{@current_controller}"
    logger.debug "@current_action: #{@current_action}"
    logger.debug "@current_path: #{@current_path}"
    logger.debug "@current_module: #{@current_module}"
    logger.debug "@current_page: #{@current_page}"
    current_pathnames = Pathname.new(@current_path).each_filename
    current_pathnames.each{ |name| logger.debug "current path split: #{name}"}
    logger.debug "current_module: #{current_pathnames.first}"
    previous_pathnames = Pathname.new(@previous_path).each_filename
    previous_pathnames.each{ |name| logger.debug "previous path split: #{name}"}
  end


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
