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

    merchant = Merchant.find_by(UID: auth_hash[:uid], provider: auth_hash[:provider])
    if merchant
      flash[:success] = "Logged in as returning merchant #{merchant.username}"
    else
      merchant = Merchant.build_from_github(
        username: auth_hash[:name],
        email: auth_hash[:email],
        UID: auth_hash[:uid],
        provider: auth_hash[:provider]
      )
      if merchant.save
        flash[:success] = "Logged in as new merchant #{merchant.username}"
      else
        flash[:error] = "Could not create new merchant account: #{merchant.errors.messages}"
        return redirect_to root_path
      end
    end

    session[:user_id] = merchant.id
    return redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end
end