class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
