class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_merchant
    @current_merchant ||= Merchant.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    @current_user = Merchant.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path, status: :forbidden
    end
  end


  private

  def find_merchant
    if session[:user_id]
      @login_merchant = Merchant.find_by(id: session[:user_id])
    end
  end
end
