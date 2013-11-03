class GoodiesController < ApplicationController
  before_action :set_goodie, only: [:show, :edit, :update, :destroy]
  before_action :deny_nonadmins, only: [:new, :edit, :create, :update, :destroy]

  def deny_nonadmins
    unless admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."
      redirect_to :goodies
    end
  end

  # GET /goodies
  def index
    @goodies = Goodie.all
  end

  # GET /goodies/1
  def show
  end

  # GET /goodies/new
  def new
    @goodie = Goodie.new
  end

  # GET /goodies/1/edit
  def edit
  end

  # POST /goodies
  def create
    @goodie = Goodie.new(goodie_params)

    respond_to do |format|
      if @goodie.save
        format.html { redirect_to @goodie, notice: 'Goodie was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /goodies/1
  def update
    respond_to do |format|
      if @goodie.update(goodie_params)
        format.html do
          flash[:status] = 'alert-success'
          flash[:notice] = 'Goodie was successfully updated.'
          redirect_to @goodie
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /goodies/1
  def destroy
    @goodie.destroy
    respond_to do |format|
      format.html { redirect_to goodies_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goodie
      @goodie = Goodie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goodie_params
      params.require(:goodie).permit(:name, :description, :price, :image_url)
    end
end
