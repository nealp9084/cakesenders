class UserSessionsController < ApplicationController
  # if you are logged in, you shouldn't be able to log in again
  before_action :deny_loggedin, only: [:login, :login_attempt]
  # if you are logged out, you can't log out again
  before_action :deny_loggedout, only: [:logout]

  def deny_loggedin
    if logged_in?
      flash[:status] = 'alert-warning'
      flash[:notice] = 'You are already logged in.'
      redirect_to :root
    end
  end

  def deny_loggedout
    unless logged_in?
      flash[:status] = 'alert-warning'
      flash[:notice] = 'You are already logged out.'
      redirect_to :root
    end
  end

  def login
    # login form page
  end

  def login_attempt
    # authentication stuff
    us_params = params[:user_session]
    authorized_user = User.authenticate(us_params[:username], us_params[:password])

    respond_to do |format|
      if authorized_user
        reset_session
        session[:user_id] = authorized_user.id

        flash[:status] = 'alert-success'
        flash[:notice] = 'Successfully logged in.'
        format.html { redirect_to :root }
      else
        flash[:status] = 'alert-danger'
        flash[:notice] = 'Incorrect username or password.'
        format.html { render action: 'login' }
      end
    end
  end

  def logout
    session[:user_id] = nil
    reset_session

    flash[:status] = 'alert-success'
    flash[:notice] = 'Successfully logged out.'
    redirect_to :root
  end
end
