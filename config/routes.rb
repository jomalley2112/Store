Store::Application.routes.draw do
  


  get "customers/orders"

  get "shopping_carts/show"

  get "shopping_carts/manage"

  get "products/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  get "products/list_by_category/:id" => "products#list_by_category", :as => "list_by_category"
  get "products/add_product_to_cart" => "products#add_to_cart", :as => "add_product_to_cart"
  get "shopping_carts/clear_cart" => "shopping_carts#clear_cart", :as => "clear_cart"
  
  get "shopping_carts/place_order" => "shopping_carts#place_order", :as => "place_order"
  get "customer/orders" => "customers#orders", :as => "customer_orders"
  get "products/admin" => "products#admin", :as => "admin_products"
  

  resources :product_categories
  resources :products do
    # collection do
    #   get 'list_by_category/:product_category_id', :action => 'list_by_category'
    # end
  end
  resources :shopping_carts
  resources :customers
  resources :orders

  root :to => 'products#index'


  #get "product/index"


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
