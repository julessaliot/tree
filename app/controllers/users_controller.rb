class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :spotify

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access private data
    spotify_user.country
    spotify_user.email

   #create devise user
   @user = User.from_omniauth(request.env["omniauth.auth"])

   if @user.persisted?
     sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
   else
    redirect_to root_path
   end
  end
end
