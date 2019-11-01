class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_merchant

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
