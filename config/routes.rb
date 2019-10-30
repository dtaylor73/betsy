Rails.application.routes.draw do
  root "homepages#index"

  resources :products
  
  get "/orders/shopping_cart", to: "orders#shopping_cart", as: "shopping_cart"

  # delete "/orders/remove_product_from_cart", to: "orders#remove_product_from_cart", as: "remove_product_from_cart"

  resources :orders

  resources :order_items

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end


  patch "/products/:id/active", to: "products#toggle_active", as: "toggle_active"

  root 'homepages#index'

  get "/orders/:id/confirmation_page", to: "orders#confirmation_page", as: "confirmation_page"

  patch "/products/:id/inactive", to: "products#toggle_inactive", as: "toggle_inactive"

  post "/products/:id/add_product_to_cart", to: "products#add_product_to_cart", as: "add_product_to_cart"


  
end
