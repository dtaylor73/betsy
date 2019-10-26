Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :orders
  resources :categories
  resources :products
  resources :orders

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
