class FavoritesController < ApplicationController
  before_action :authenticate_user!

  # will be called when the user clicks on the heart icon to like a post
  # will create a new like record in database with post_id and user_id attributes
  def index
    @favorites = Favorite.where(user: current_user)
  end

  def create
    @post = Post.find(params[:post_id])
    @favorite = Favorite.new(user: current_user, post: @post)
    @favorite.save
    respond_to do |format|
      format.text { render partial: "shared/favorite-post-link", locals: { post: @post }, formats: [:html] }
      format.html { redirect_to post_favorites_path }
    end
  end

  # will be called when the user clicks the heart icon again to unlike the post
  # will find and destroy the like record in database with the given post_id and user_id attributes
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    respond_to do |format|
      format.text { render partial: "shared/favorite-post-link", locals: { post: @favorite.post }, formats: [:html] }
      format.html { redirect_to posts_path }
    end
  end
end
