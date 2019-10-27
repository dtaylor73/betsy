require "test_helper"

describe ProductsController do
  let(:plant_one) { products(:aloe) }
  let(:category_one) { categories(:suc) }
  let(:merchant_one) { merchants(:bob) }
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

      it "will get all the products for a specific merchant" do
        plant_one.merchant_id = merchant_one.id

        get merchant_products_path(merchant_one.id)

        must_respond_with :success
      end

      it "should respond with a 404 if merchant does not exist" do
        get merchant_products_path(-1)
        must_respond_with :not_found
      end
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

      it "renders bad_request and does not update the DB for bogus data" do
        bad_product = { product: { name: nil, merchant: merchants(:bob), price: nil } }

        expect {
          post products_path, params: bad_product
        }.wont_change "Product.count"

        must_respond_with :bad_request
      end
    end
  end

  describe "guest users" do
    describe "index" do
      it "guest users can access all the products" do
        get products_path

        must_respond_with :success
      end
    end

    describe "create" do
      it "does not create a product for a guest user" do
        new_product = { product: { name: "Cinnamon Fern", price: 8, quantity: 20, description: "Tastes like cinnamon", photo_url: "https://i.imgur.com/7tkoo6m.jpg", status: true } }

        expect {
          post products_path, params: new_product
        }.wont_change "Product.count"
      end
    end
  end
end
