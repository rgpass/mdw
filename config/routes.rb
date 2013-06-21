Mdw::Application.routes.draw do
#  get "users/new" was automatically created when the
# Users controller was, however it does not meet REST
# conventions, so it was deleted. See User pages layout.

# By adding in this line, users is made into a resource
# that can be utilized by HTTP, giving the application
# ALL the actions needed for a RESTful Users resource.
# This also provides several named routes automagically.
  resources :users

# This line is similar to the above, however we limit
# what is available as there would be no need to edit
# the session.
  resources :sessions, only: [:new, :create, :destroy]

# Do not need :edit or :update because it will be
# set up so once it's submitted, it's done. They
# can delete it and re-type, but cannot edit.
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy] do
    member { post :vote }
  end

# Static pages
  root to: 'posts#index'
  match '/faq', to: 'static_pages#faq'
  match '/signs', to: 'static_pages#signs'

# User pages
  match '/signup', to: 'users#new'

# Session pages
  match '/signin', to: 'sessions#new'
  # The via: :delete indicates it should be invoked
  # via a HTTP DELETE request.
  match '/signout', to: 'sessions#destroy', via: :delete

# Post pages
  match '/popular', to: 'posts#popular'
  match '/lame',    to: 'posts#lame'


  # Routes Layout
# Page       URI            Variable title
# Home       /              (blank)
# FAQ        /faq           FAQ
# Sign up    /signup        Sign Up
# Sign in    /signin        Sign In
# Sigh out   /signout       Sign Out

  # User pages layout
# HTTP request URI            Action  Named Routes          Purpose
# GET          /users         index   users_path            lists all users
# GET          /users/1       show    user_path(user)       show info for user 1
# GET          /users/new     new     new_user_path         make a new user
# POST         /users         create  users_path            create the new user
# GET          /users/1/edit  edit    edit_user_path(user)  edit for user 1
# PUT          /users/1       update  user_path(user)       update the info
# DELETE       /users/1       destroy user_path(user)       delete user 1

  # Post layout
# HTTP request URI            Action  Named Routes          Purpose
# GET          /posts         index   posts_path            lists all posts
# GET          /posts/new     new     new_post_path         make a new post
# POST         /posts         create  posts_path            create the new post
# DELETE       /posts/1       destroy user_path(user)       delete the post with id 1

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
