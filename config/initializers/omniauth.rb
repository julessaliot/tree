require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "fe14b3fe7eff4b0d85ed67aeaf9cdb1f", "a553a9f5130645e2abe10a9b88825a1b", scope: 'user-read-email user-library-read'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
