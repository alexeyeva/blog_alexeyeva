class CommentsController < ApplicationController
  before_action :get_comment, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, notice: "Comment was succesfully created"
    else
      redirect_to @comment.post, notice: "Sorry, can't create a comment"
    end

  end

  def update 
  end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: "Comment was succesfully deleted"
  end

  private

    def comment_params
      params.require(:comment).permit(:text)
    end

    def get_comment
      @comment = Comment.find(params[:id])
    end

end
