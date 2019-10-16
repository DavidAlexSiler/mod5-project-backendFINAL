Rails.application.routes.draw do
# OAuth
  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/auth', to: "auth#show"
      resources :users
      resources :playlists
      resources :songs
    end
  end
end
