Rails.application.routes.draw do
  root "homepages#index"

  resources :products

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  root 'homepages#index'

  get "/orders/:id/confirmation_page", to: "orders#confirmation_page", as: "confirmation_page_path"
  patch "/drivers/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
  patch "/products/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
