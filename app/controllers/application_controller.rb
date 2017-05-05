class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end

  helper_method :logged_in?

  def admin?
    logged_in? && @current_user.role == 'admin'
  end
   helper_method :admin?

  def customer?
    logged_in? && @current_user.role == 'customer'
  end
    helper_method :customer?

  def shipper?
    logged_in? && @current_user.role == 'shipper'
  end
    helper_method :shipper?

  def manager?
    logged_in? && @current_user.role == 'manager'
  end
    helper_method :manager?




  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end






end
