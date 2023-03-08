class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    if params[:search].present?
      @tracks = RSpotify::Track.search(params[:search][:tracks])
    end
  end

  # def create
  #   raise
  #   track = RSpotify::Track.find(params[:post][:track_id])
  #   @post = Post.new(post_params.merge(
  #     track_name: track.name,
  #     track_artist: track.artists.first.name,
  #     track_release_date: track.album.release_date,
  #     track_cover_url: track.album.images.first['url']
  #   ))
  #   @post.user = current_user
  #   if @post.save
  #     flash[:success] = "Post created!"
  #     redirect_to @post
  #   else
  #     render 'new'
  #   end
  # end

  # def search
  #   @tracks = RSpotify::Track.search(params[:q])
  # end


  def create
    @post = Post.new(post_params)
    @post.user = current_user

    track = RSpotify::Track.search(@post.content).first
    if track
      @post.spotify_track_id = track.id
      @post.album_cover_url = track.album.images.first["url"]
    end
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :track_id)
  end
end
