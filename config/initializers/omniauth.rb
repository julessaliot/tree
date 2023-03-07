require 'rspotify/oauth'

Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV.fetch("SPOTIFY_CLIENT_ID"), ENV.fetch("SPOTIFY_SECRET"), scope: 'user-read-email user-library-read'
end


OmniAuth.config.allowed_request_methods = [:post,:get]
