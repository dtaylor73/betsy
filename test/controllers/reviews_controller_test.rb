require "test_helper"

describe ReviewsController do
  # before do 
  #   User.create!(username:"yasmin")
  # end
  describe "create" do
    let(:product) { product (:product1)}
  end

  it 'creates a new review successfully with valid data' do
      review_hash = {
      review: {
        rating: 5,
        product_id: 2,
        text: 'It healed my wounds'
        }
      }
      expect {
        post reviews_path, params: review_hash
      }.must_differ 'Review.count', 1

      must_redirect_to root_path
  end
  
  # describe "current" do
  #   it "sets flash[:error] and redirects when the merchant review their product " do
  #     get current_merchant_path
  #     expect(flash[:error]).must_equal "You must be logged in to see this page"
  #     must_redirect_to reviews_path
  #   end
  # end
end
