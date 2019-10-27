require "test_helper"

describe ProductsController do
  describe "logged in merchants" do
    describe "index" do
      it "can get the index path" do
        get products_path

        must_respond_with :success
      end

      it "only views products if their status is active" do
        product = Product.first

        expect(product.status).must_equal true
        # Will need to pull changes from Master for the schema changes..
      end

      # it "should get a merchant's products' index" do

      # end

      # it "should respond with a 404 if user does not exist" do
      # end

      # it "should get a category's products' index" do
      # end

      # it "will respond with a 404 if the category does not exist" do
      # end
    end

    describe "show" do
      it "will show an individual product's page" do
        # get product_path(products(:fern).id)

        # must_respond_with :success
      end

      it "returns a 404 if the product doesn't exist" do
        get product_path(-1)

        must_respond_with :not_found
      end
    end

    describe "new" do
      it "will create a new product for a logged in user" do
        get new_product_path

        must_respond_with :success
      end
    end

    describe "create" do
    end
  end
end
