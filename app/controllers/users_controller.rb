class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :spotify

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_user.country
    spotify_user.email
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
