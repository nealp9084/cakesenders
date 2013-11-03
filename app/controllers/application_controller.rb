class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    else
      redirect_to(:controller => 'user_sessions', :action => 'login')
      return false
    end
  end

  def logged_in?
    session[:user_id] != nil
  end

  def current_user
    if logged_in?
      User.find_by_id session[:user_id]
    else
      nil
    end
  end

  def admin?
    u = current_user
    u && u.admin
  end
end
