require "test_helper"

describe ReviewsController do
  describe "create" do
    let(:product) { products(:aloe)}
    
    it 'creates a new review successfully with valid data' do
      review_hash = {
        review: {
          rating: 5,
          text: 'It healed my wounds'
        }
      }
      expect {
        post product_reviews_path(product.id), params: review_hash
      }.must_differ 'Review.count', 1
      
      must_redirect_to product_path(product.id)
    end
  end
  
  # describe "current" do
  #   it "sets flash[:error] and redirects when the merchant review their product " do
  #     get current_merchant_path
  #     expect(flash[:error]).must_equal "You must be logged in to see this page"
  #     must_redirect_to reviews_path
  #   end
  # end
end
