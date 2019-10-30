require "test_helper"

describe MerchantsController do
  let(:merchant_one) { merchants(:sponge) }

  describe "Logged_in Merchants" do
    before do
      perform_login(merchants(:sponge))
    end

    describe "index" do
      it "will show a list of all merchants" do
        get merchants_path
        must_respond_with :success
      end
    end

    describe "show" do
      it "will show my merchant dashboard page" do
        get merchant_path(merchant_one.id)
        must_respond_with :success
      end
    end
  end

  describe "Guest Users" do
    describe "index" do
      it "can access a list of all the products" do
        get products_path
        must_respond_with :success
      end
    end

    describe "show" do
      it "will not allow a guest user to see any merchant's dashboard page" do
        get merchant_path(merchant_one.id)
        must_respond_with :bad_request
      end
    end
  end
  
  describe "auth_callback" do
    it "logs in an exisiting merchant and redirects to the root route" do
      start_count = Merchant.count
      merchant = merchants(:sponge)
      perform_login(merchant)

      expect(session[:merchant_id]).must_equal merchant.id
      expect(Merchant.count).must_equal start_count
      must_redirect_to root_path
    end

    it "creats an account for a new user and redirects to the root route" do
      start_count = Merchant.count
      merchant = Merchant.new(username:"Sandy", email: "whatev@git.com", UID: 123, provider: "github")
      perform_login(merchant)

      expect(session[:merchant_id]).must_equal merchant.id
      expect(Merchant.count).must_equal start_count + 1
      must_redirect_to root_path
    end
  
    it "redirects to the login route if given invalid merchant data" do
      start_count = Merchant.count
      merchant = Merchant.create(username:"Sam", email: nil)
      perform_login(merchant)      

      expect{ get auth_callback_path(:github) }.wont_change start_count
      must_redirect_to root_path
    end
  end
end