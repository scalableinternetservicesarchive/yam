Rails.application.routes.draw do
  devise_for :users

  get 'game2048/show'   # Display latest board

  get 'game2048/game_json'   # for AJAX. MAKE THIS POST WHEN YOU CAN FIGURE IT OUT.

  get 'game2048/match_json'  # AJAX will check this for joining game2048

  post 'game2048/join_match'  # Join a new game or existing one

  get 'game2048/wait_room'

  post 'game2048/move'  # Player submits move for board and places piece
                        # Redirect to play to show latest board state

  post 'game2048/end_game' # End the game

  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/battle_2048_instructions'

  get 'static_pages/leaderboard'

  get 'users/:id' => 'users#show', as: "user_profile"

  resources :games

  root 'static_pages#home', as: 'home'
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
