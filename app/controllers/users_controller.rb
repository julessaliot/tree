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
    @users = User.all.where('id != ?', current_user.id)
    @all_friends = User.confirmed_friends(current_user)
    @pending_requests = User.pending_requests(current_user)
    @sent_requests = User.sent_requests(current_user)
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:photo, :username, :email, :bio, :interests)
  end
end
