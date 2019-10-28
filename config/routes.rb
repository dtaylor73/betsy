Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :orders
  resources :categories
  resources :products
  # resources :reviews, only: [:new, :create]

   resources :products do
    resources :reviews, only: [:new, :create]
   
   end


  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  patch "/products/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
