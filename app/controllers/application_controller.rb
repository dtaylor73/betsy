class ApplicationController < ActionController::Base
  before_action :set_cart
 
  private
 
  def set_cart
    @cart = Order.find_by(id: session[:order_id])
    if @cart.nil?
      @cart = Order.new
      # empty cart. Not sure if I like this. 
      session[:order_id] = @cart.id
    end 
  end
end
