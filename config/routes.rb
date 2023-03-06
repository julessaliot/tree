Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  get '/auth/spotify', as: 'spotify_auth'
  get '/auth/spotify/callback', to: 'users#spotify'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
