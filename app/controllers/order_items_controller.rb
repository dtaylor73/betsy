class OrderItemsController < ApplicationController

  def create
    if session[:shopping_cart]
      order.create(order_item_params)
    else
      flash[:status] = :error
      flash[:result_text] = "there is currently no order_item to be generated from shopping cart"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id, :shipping_status)
  end
ends