Rails.application.routes.draw do
  root "homepages#index"

  resources :products
  resources :categories
  resources :orders

  resources :merchants do
    resources :products, only: [:index, :new]
    resources :orders, only: [:index]
  end

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  # nested reviews under products
  resources :products do
    resources :reviews, only: [:new, :create]
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  post "/logout", to: "merchants#destroy", as: "logout"
  get "/merchants/current", to: "merchants#current", as: "current_merchant"

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"
  patch "/products/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
