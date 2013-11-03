module ApplicationHelper
  def has_flash?
    flash[:status] != nil
  end

  def flash_class
    'alert ' + flash[:status]
  end

  def flash_notice
    flash[:notice]
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

  def partial(file, locals = {})
    render partial: file, locals: locals
  end
end
