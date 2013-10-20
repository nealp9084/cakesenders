class GoodiesController < ApplicationController
  before_action :set_goody, only: [:show, :edit, :update, :destroy]

  # GET /goodies
  # GET /goodies.json
  def index
    @goodies = Goody.all
  end

  # GET /goodies/1
  # GET /goodies/1.json
  def show
  end

  # GET /goodies/new
  def new
    @goody = Goody.new
  end

  # GET /goodies/1/edit
  def edit
  end

  # POST /goodies
  # POST /goodies.json
  def create
    @goody = Goody.new(goody_params)

    respond_to do |format|
      if @goody.save
        format.html { redirect_to @goody, notice: 'Goody was successfully created.' }
        format.json { render action: 'show', status: :created, location: @goody }
      else
        format.html { render action: 'new' }
        format.json { render json: @goody.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goodies/1
  # PATCH/PUT /goodies/1.json
  def update
    respond_to do |format|
      if @goody.update(goody_params)
        format.html { redirect_to @goody, notice: 'Goody was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goody.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goodies/1
  # DELETE /goodies/1.json
  def destroy
    @goody.destroy
    respond_to do |format|
      format.html { redirect_to goodies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goody
      @goody = Goody.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goody_params
      params.require(:goody).permit(:name, :description, :price)
    end
end
