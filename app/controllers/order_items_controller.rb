class OrderItemsController < ApplicationController
  def create
    if session[:shopping_cart]
      @order_item = OrderItem.create(order_item_params)
      if @order_item.save
        flash[:status] = :success
        flash[:result_text] = "#{@order_item.product.name} has been added!"
      else
        flash[:status] = :error
        flash[:result_text] = "Could not add #{@order_item.product.name}.."
      end
    else
      flash[:status] = :error
      flash[:result_text] = "there is currently no order_item to be generated from shopping cart"
    end
  end

  def shipped
    if @order_item.order.status == "complete" && @order_item.status == false
      @order_item.status == true
      if @order_item.save
        flash[:status] = :success
        flash[:result_text] = "#{@order_item.product.name} has been marked as shipped"
      else
        flash[:status] = :error
        flash[:result_text] = "somthing went wrong. please try again"
      end
    else
      
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id, :shipping_status)
  end
end