class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # if you are not an admin, you cannot view the user listing
  before_action :deny_nonadmins, only: [:index]
  # if the account is not yours, you cannot change it
  before_action :deny_nonself, only: [:show, :edit, :update, :destroy]
  # if you are logged in, you cannot create more accounts
  before_action :deny_loggedin, only: [:new, :create]

  def deny_nonadmins
    unless admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."
      redirect_to :root
    end
  end

  def deny_nonself
    unless current_user == @user || admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."
      redirect_to current_user || :root
    end
  end

  def deny_loggedin
    if logged_in? && !admin?
      flash[:status] = 'alert-warning'
      flash[:notice] = "You are already have an account (and are logged in)."
      redirect_to current_user
    end
  end

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.register
        # Send a welcome email
        UsersMailer.welcome_email(@user).deliver

        session[:user_id] = @user.id

        format.html do
          flash[:status] = 'alert-success'
          flash[:notice] = "Signup complete. You're one step closer to getting some delicious baked goods!"
          redirect_to :root
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:realname, :username, :password_hash, :email, :twitter_id)
    end
end
