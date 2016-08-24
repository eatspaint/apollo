Rails.application.routes.draw do
  root 'apollo#landing'
  get '/about', to: 'apollo#about', as: 'about'
  get '/auth/spotify/callback', to: 'users#spotify'
  get '/rooms_index', to: 'rooms#rooms_index'
  get '/playlist', to: 'playlists#show'
  get '/playlists/search', to: 'playlists#search'
  get '/songs/search', to: 'playlists#song_search'
  get '/find_room', to: 'rooms#find_room'
  get '/playlist_check', to: 'playlists#check'
  get '/rooms/rickroll', to: 'rooms#rickrolltest'

  get '/fyf', to: 'apollo#fyf', as: 'fyf'
  post '/fyf_top', to: 'apollo#find_top'
  post '/fyf_save', to: 'apollo#save_playlist'

  put '/playlist', to: 'playlists#add_track'
  put '/remove_track', to: 'playlists#remove_track'
  put '/rickroll', to: 'rooms#rickroll'

  post '/playlists', to: 'playlists#create'

  delete '/remove_playlist', to: 'rooms#remove_playlist'
  delete '/remove_spotify', to: 'users#remove_spotify'

  resources :rooms

  devise_for :users, controllers: { registrations: 'registrations' }

  # catchall
  get "*any", via: :all, to: "apollo#error"
end
