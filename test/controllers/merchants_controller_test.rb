require "test_helper"

describe MerchantsController do
  describe "auth_callback" do
    it "logs in an exisiting merchant and redirects to the root route" do
      start_count = Merchant.count
      merchant = merchants(:sponge)

      perform_login(merchant)
      session[:user_id].must_equal merchant.id

      Merchant.count.must_equal start_count
      must_redirect_to root_path
    end

    it "creats an account for a new user and redirects to the root route" do
      new_merchant = Merchant.new(username:"Sandy", email: "whatev@git.com")
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      expect{ get auth_callback_path(:github) }.must_change "Merchant.count", 1

      # must_redirect_to root_path
    end
  
    it "redirects to the login route if given invalid merchant data" do
      new_merchant = Merchant.new(name:"Sam", email: nil)
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      expect{ get auth_callback_path(:github) }.wont_change "Merchant.count"

      # must_redirect_to root_path
    end
  end
end
