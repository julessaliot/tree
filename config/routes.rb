Rails.application.routes.draw do
  root to: "pages#landing_page"
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup', edit: 'profile/edit' }

  get '/auth/spotify', as: 'spotify_auth'
  get '/auth/spotify/callback', to: 'users#spotify'

  resources :posts do
    collection do
      get :search
    end

    resources :comments, only: %i[new create]
    resources :favorites, only: %i[create]
  end

  resources :favorites, only: [:destroy]

  get '/profile', to: 'users#profile'

  get '/terms', to: 'pages#terms'

  get '/home', to: 'pages#home'




  resources :users, only: %i[index show] do
    resources :friendships, only: %i[new index update edit create destroy]
    get 'profile', on: :member #user
  end
end
