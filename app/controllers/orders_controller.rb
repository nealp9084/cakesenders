class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # if you are not logged in, you cannot access anyone's order history
  before_action :deny_nonloggedin
  # if the order is not yours, you cannot access it
  before_action :deny_nonown, only: [:show, :edit, :update, :destroy]
  # if you are not an admin, you cannot modify an order
  before_action :deny_nonadmins, only: [:edit, :update, :destroy]

  def deny_nonloggedin
    unless logged_in?
      flash[:status] = 'alert-danger'
      flash[:notice] = 'You must be logged in to see your orders.'
      redirect_to :login
    end
  end

  def deny_nonown
    unless current_user == @order.user || admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."
      redirect_to :orders
    end
  end

  def deny_nonadmins
    unless admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."

      if current_user == @order.user
        redirect_to @order
      else
        redirect_to :orders
      end
    end
  end

  # GET /orders
  def index
    if admin?
      @orders = Order.all
    else
      @orders = Order.where(user: current_user)
    end
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new

    goodie = Goodie.find_by_id(params[:goodie_id])
    @order.goodie = goodie if goodie

    @order.user = current_user
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.user = current_user unless admin?

    respond_to do |format|
      if Goodie.exists?(order_params[:goodie_id]) && @order.save
        OrderMailer.confirmation_email(@order).deliver
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /orders/1
  def update
    @order.assign_attributes(order_params)
    @order.user = current_user unless admin?

    respond_to do |format|
      if Goodie.exists?(order_params[:goodie_id]) && @order.save
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :goodie_id, :destination, :charge_token)
    end
end
