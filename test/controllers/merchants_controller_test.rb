require "test_helper"

describe MerchantsController do
  describe "auth_callback" do
    it "logs in an exisiting merchant and redirects to the root route"
      start_count = Merchant.count
      perform_login
      must_redirect_to root_path

      expect(Merchant.count).must_equal start_count
    end

    it "creats an account for a new user and redirects to the root route" do
      new_merchant = Merchant.new(name:"SpongeBob", email: "whatev@git.com")
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      expect{ get auth_callback_path(:github) }.must_change "Merchant.count", 1

      # must_redirect_to root_path
    end
  
    it "redirects to the login route if given invalid merchant data" do
      new_merchant = Merchant.new(name:"PatrickStar", email: nil)
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      expect{ get auth_callback_path(:github) }.wont_change "Merchant.count"

      # must_redirect_to root_path
    end
  end

  describe "current" do 
  end
end
