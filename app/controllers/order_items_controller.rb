class OrderItemsController < ApplicationController

  def create
    if session[:order_id] && Order.find_by(id: session[:order_id]).status == 'complete'
      
      
    end

  end

end
