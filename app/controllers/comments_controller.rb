class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  # if you are not logged in, you cannot change anything
  before_action :deny_nonloggedin, only: [:new, :create, :edit, :update, :destroy]
  # if the comment is not yours, you cannot modify it
  before_action :deny_nonown, only: [:edit, :update, :destroy]

  def deny_nonloggedin
    unless logged_in?
      flash[:status] = 'alert-danger'
      flash[:notice] = 'You must be logged in to do that.'
      redirect_to :login
    end
  end

  def deny_nonown
    unless current_user == @comment.user || admin?
      flash[:status] = 'alert-danger'
      flash[:notice] = "You don't have permission to do that."
      redirect_to @comment
    end
  end

  # GET /comments
  def index
    if admin?
      @comments = Comment.all
    else
      @comments = Comment.where(user: current_user)
    end
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user unless admin?

    respond_to do |format|
      if Goodie.exists?(comment_params[:goodie_id]) && @comment.save
        format.html { redirect_to @comment.goodie, notice: 'Comment was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    @comment.assign_attributes(comment_params)
    @comment.user = current_user unless admin?

    respond_to do |format|
      if Goodie.exists?(comment_params[:goodie_id]) && @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:goodie_id, :user_id, :content)
    end
end
