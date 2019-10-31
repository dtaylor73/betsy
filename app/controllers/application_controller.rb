class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :find_merchant

  def current_merchant
    @current_merchant ||= Merchant.find(session[:user_id]) if session[:user_id]
  end

  private

  def find_merchant
    if current_merchant.nil?
      flash[:status] = :error
      flash[:result_text] = "You must log in to access this page"
      return redirect_to root_path
    end
  end
end