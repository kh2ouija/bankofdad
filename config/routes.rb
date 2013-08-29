Bankofdad::Application.routes.draw do

  devise_for :users

  authenticated do
    root 'customers#index', as: :authenticated_root
  end

  root 'guest#landing'
  
  resources :customers, only: [:index, :show, :new, :create, :destroy] do
    resources :transactions, only: [:index, :new, :create]
    resource :allowance, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'customers/:id/account/edit' => 'accounts#edit', as: :edit_customer_account
  patch 'customers/:id/account' => 'accounts#update', as: :account

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
