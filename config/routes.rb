Emporium::Application.routes.draw do

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  resources :users

 get "about/index"

  namespace :admin do
    resources :authors, :controller => 'author'
    resources :publishers
    resources :books
    resources :users
  end

#  get "catalog/index"
#  get "catalog/show/:id"
#  get "catalog/search"
#  get "catalog/latest"
#  get "catalog/brief"
 resources :catalog do
    collection do
      get 'search','brief','latest'
    end
 end

  #
  # get carts/id    show
  # post carts/cart_id/items   add(create)
  resources :carts

  # get /cart_items      index          cart_items_path
  # get /cart_items/new  new            new_cart_items_path
  # post /cart_items     create         cart_items_path
  # get /cart_items/1    show           cart_item_path
  # get /cart_items/1/edit    edit      edit_cart_item_path
  # put /cart_items/1     update        cart_item_path
  # delete /cart_items/1  destroy       cart_item_path
  resources :cart_items

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
   root :to => 'catalog#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
