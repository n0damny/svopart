Svopart::Application.routes.draw do

  resources :supports, :only => [:new, :create]

  devise_for :users #, :controllers => { :registrations => "registrations" }  

  resources :orders do
      member do
  			get :user_order_line_items
  		end
  end

  resources :line_items do
      member do
  			get :change_quantity
  		end
  end

  resources :templates

  resources :carts

  get "store/order_print"

  get "store/my_templates"
  #get "orders/order_print"

  get "store/index"
  
  get "store/akafilt"

  get "store/view_cart"

  get "store/about_product"
  
  get "store/information"

  get "store/delivery"

  get "store/vacancy"

  get "store/contacts"

  get "store/profile"

  get "store/advanced_search"

  get "store/users"
  post "products/file_upload"
#resources :excel_file_upload, :module => "products"
  resources :products do
    get :who_bought, :on => :member
    post :file_upload
  end
  
  root :to => 'store#index'

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
