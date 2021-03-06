Radio::Application.routes.draw do
  resources :pitches

  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end
  
  resources :conferences

  resources :episodes do
    
    get 'page/:page', :action => :index, :on => :collection
    
    resources :questions do
      collection do
        post 'sort'
      end
    end
    resources :stories
    
    collection do
      get 'schedule'
    end
    member do
      get 'script'
      get 'email'
      post 'send_email'
      get "wordpress"
      post "publish_wordpress"
    end
  end
  
  match 'tags' => "tags#index"
  match 'tags/:name' => "tags#show"
  
  #just for sorting
  resources :questions do
    post :sort, on: :collection
  end
  
  resources :stories do
    post :sort, on: :collection
  end
  
  resources :guests
  resources :hosts
  resources :users
  
  match '/about' => 'home#about', :as => :about
  match '/contact' => 'home#contact', :as => :contact
  match '/staff' => 'home#staff', :as => :staff
  
  root :to => "home#index"
  

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
