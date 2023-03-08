Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }

  get '/auth/spotify', as: 'spotify_auth'
  get '/auth/spotify/callback', to: 'users#spotify'

  resources :posts, only: %i[index new create edit update destroy] do
    resources :comments, only: %i[new create]
    resources :favorites, only: %i[create]
  end

  get '/profile', to: 'users#profile'
  get '/terms', to: 'pages#terms'
  mount FinePrint::Engine => "/fine_print"

  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create destroy]
  end
end
