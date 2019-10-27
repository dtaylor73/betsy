Rails.application.routes.draw do
  resources :products
  resources :categories
  resources :orders
  
  resources :merchants do
    resources :products, only: [:index, :new]
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  post "/logout", to: "merchants#destroy", as: "logout"
  get "/merchants/current", to: "merchants#current", as: "current_merchant"
  
  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"
  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end