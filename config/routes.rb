Rails.application.routes.draw do
  resources :products

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

<<<<<<< HEAD
  root 'homepages#index'

  get "/orders/:id/confirmation_page", to: "orders#confirmation_page", as: "confirmation_page_path"
=======
  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
>>>>>>> master
end
