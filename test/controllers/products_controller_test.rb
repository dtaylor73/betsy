require "test_helper"

describe ProductsController do
  let(:plant_one) { products(:aloe) }
  let(:category_one) { categories(:suc) }
  describe "logged in merchants" do
    describe "index" do
      it "can get the index path" do
        get products_path

        must_respond_with :success
      end

      it "only views products if their status is active" do
        product = Product.first

        expect(product.status).must_equal true
      end

      it "will get all the products for a specific category" do
        plant_one.category_ids = category_one.id

        get category_products_path(category_one.id)

        must_respond_with :success
      end

      it "will respond with a 404 if the category does not exist" do
        get category_products_path(-1)

        must_respond_with :not_found
      end

      # it "will get all the products for a specific merchant" do
      # get merchant_products_path(plant_one)
      # end

      # it "should respond with a 404 if merchant does not exist" do
      # get merchant_products_path(-1)
      # must_respond_with :not_found
      # end

    end

    describe "show" do
      it "will show an individual product's page" do
        get product_path(products(:fern).id)

        must_respond_with :success
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
      it "creates a product with valid data" do
        new_product = { product: { name: "Cinnamon Fern", price: 8, quantity: 20, description: "Tastes like cinnamon", photo_url: "https://i.imgur.com/7tkoo6m.jpg", status: true } }

        expect {
          post products_path, params: new_product
        }.must_change "Product.count", 1
      end

      it "does not create a product for a guest user" do
        new_product = { product: { name: "Cinnamon Fern", price: 8, quantity: 20, description: "Tastes like cinnamon", photo_url: "https://i.imgur.com/7tkoo6m.jpg", status: true } }

        expect {
          post products_path, params: new_product
        }.wont_change "Product.count"
      end
    end
  end
end
