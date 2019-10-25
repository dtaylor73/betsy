Rails.application.routes.draw do

  resources :products

  resources :orders

  root 'homepages#index'

  get "/orders/:id/confirmation_page", to: "orders#confirmation_page", as: "confirmation_page_path"
end
