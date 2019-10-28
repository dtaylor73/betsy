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
  protect_from_forgery with: :exception

  def current_merchant
    @current_merchant ||= Merchant.find(session[:user_id]) if session[:user_id]
  end

  private

  def find_merchant
    if session[:user_id]
      @login_merchant = Merchant.find_by(id: session[:user_id])
    end
  end
end
