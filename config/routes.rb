Apothegm::Application.routes.draw do
  resources :users, except: [:index]
  resources :groups
  # resources :group_users
  # resources :text_messages
  resources :sessions, only: [:new, :create, :destroy]
  resources :polls, only: [:new, :create, :show, :destroy]
  
  root to: 'StaticPages#home'

  match '/signup', to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/help', to: 'StaticPages#help'
  match '/process_sms' => 'ReceiveMessages#process_sms'

  match '/group_messages', to: 'users#group_message'
  match '/group_messages/multiple', to: 'users#group_message_multiple'
  match '/group_messages/from_group', to: 'users#group_message_from_group'


  match '/group_users/multiple/create', to: 'group_users#multiple_create', via: :post
  match '/group_users/multiple/destroy', to: 'group_users#multiple_destroy', via: :post

  match '/group_users/add_users', to: 'group_users#add_users_to_group', via: :post
  match '/group_users/remove_users', to: 'group_users#remove_users_from_group', via: :post

  match '/dashboard' => 'ReportingDashboard#build'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
