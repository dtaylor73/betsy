class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0}

  # def add_orderitem()
  #   current_product = params[:id]
  #   # product id on the show page

  #   order_item = OrderItem.new(quantity: params[:quantity], product_id: current_product, order_id: @cart, shipping_status: false)
  

  #   if order_item.quantity > current_product.quantity
  #     return false
  #   else
  #     current_product.quantity -= order_item.quantity
  #     return true 
  #   end 
  # end 
end
