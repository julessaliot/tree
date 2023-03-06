class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access private data
    spotify_user.country
    spotify_user.email

    # Get user's top played artists and tracks
    spotify_user.top_artists
    spotify_user.top_tracks(time_range: 'short_term')

    # Check doc for more
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
