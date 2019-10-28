Rails.application.routes.draw do
  root "homepages#index"

  resources :products

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  # nested reviews under products
  resources :products do
    resources :reviews, only: [:new, :create]
  end

  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  patch "/products/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"
end
