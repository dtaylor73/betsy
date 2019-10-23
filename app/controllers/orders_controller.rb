class OrdersController < ApplicationController
  def index
  end 

  def show
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      head :not_found
      return
    end 
  end
end
