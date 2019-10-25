Rails.application.routes.draw do
  resources :products

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
