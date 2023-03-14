class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :bio, :interests, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :bio, :interests, :photo])
  end

  def after_sign_in_path_for(_resource)
    home_path
  end
end
