Rails.application.routes.draw do

  resources :products
  resources :categories
  resources :orders
  resources :merchants

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"

  delete "/logout", to: "merchants#destroy", as: "logout"
  get "/merchants/current", to: "merchants#current", as: "current_merchant"
end