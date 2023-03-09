class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
