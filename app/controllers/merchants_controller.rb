class MerchantsController < ApplicationController
  def current
    @merchant = Merchant.find(session[:user_id])
    if @merchant.nil?
      head :not_found
      return
    end
  end

  def create
    auth_hash = request.env["omniauth.auth"]

    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: params[:provider])
    if merchant
      flash[:success] = "Logged in as returning merchant #{merchant.name}"
    else
      merchant = Merchant
    end
  end
end