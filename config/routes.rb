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

  put '/playlist', to: 'playlists#add_track'
  put '/remove_track', to: 'playlists#remove_track'

  post '/playlists', to: 'playlists#create'

  delete '/remove_playlist', to: 'rooms#remove_playlist'
  delete '/remove_spotify', to: 'users#remove_spotify'

  resources :rooms

  devise_for :users, controllers: { registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
