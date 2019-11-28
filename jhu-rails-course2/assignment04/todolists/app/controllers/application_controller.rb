class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_login
  helper_method :logged_in?, :current_user

  protected
  def ensure_login
	redirect_to login_path, notice: "You must login first" unless session[:user_id]
  end 

  def logged_in?
  	session[:user_id]
  end

  def current_user
  	current_user ||= User.find_by(id: session[:user_id])
  end

end
