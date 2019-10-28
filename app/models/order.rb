class Order < ApplicationRecord
  has_many :order_items

  
  def add_product(product_params)

    current_product = params[:id]
    # product id on the show page

    order_item = OrderItem.new(quantity: params[:quantity], product_id: current_product, order_id: @cart, shipping_status: false)
  

    if order_item.quantity > current_product.quantity
      return false
    else
      current_product.quantity -= order_item.quantity
      return true 
    end 
    
  end 


end

