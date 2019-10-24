require "test_helper"

describe ProductsController do
  describe "index" do
    it "can get the index path" do
      get products_path

      must_respond_with :success
    end

    it "should get a merchant's products' index" do
    end

    it "should respond with a 404 if user does not exist" do
    end

    it "should get a category's products' index" do
    end

    it "will respond with a 404 if the category does not exist" do
    end
  end

  describe "show" do
    it "will show an individual product's page" do
    end

    it "returns a 404 if the product doesn't exist" do
    end
  end
end
