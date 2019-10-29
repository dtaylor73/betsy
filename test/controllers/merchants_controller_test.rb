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

      must_redirect_to root_path
    end
  
    it "redirects to the login route if given invalid merchant data" do
      new_merchant = Merchant.new(name:"Sam", email: nil)
      
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      expect{ get auth_callback_path(:github) }.wont_change "Merchant.count"

      must_redirect_to root_path
    end
  end

  let(:merchant_test) { merchants(:sponge) }
  describe "Logged_in Merchants" do
    before do
      perform_login(merchant_test)
    end

    describe "index" do
      it "can view the list of all merchants" do
        get merchants_path
        must_respond_with :success
      end
    end

    describe "show" do
      it "will show my merchant dashboard page" do
        get merchant_path(merchant_test.id)
        must_respond_with :success
      end
    end
  end

  describe "Guest Users" do
    describe "index" do
      it "guest users can access all the products" do
        get products_path
        must_respond_with :success
      end
    end

    describe "show" do
      it "will not allow a guest user to see any merchant's dashboard page" do
        get merchant_path(merchant_test.id)
        must_respond_with :failure 
      end
    end
  end
end