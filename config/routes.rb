Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  

  resources :products do
    resources :reviews, only: [:new, :create]
  end



  resources :categories, only: [:new, :create, :index] do
    resources :products, only: [:index]
  end

  resources :orders
  resources :categories
  
  resources :merchants do
    resources :products, only: [:index, :new]
    resources :orders, only: [:index]
  end
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  post "/logout", to: "merchants#destroy", as: "logout"
  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"
  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
