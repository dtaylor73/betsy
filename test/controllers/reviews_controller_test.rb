require "test_helper"

describe ReviewsController do
  it 'creates a new review successfully with valid data' do
      review_hash = {
        review: {
        name: "hdfhd",
        rating: 4,
        product: 'jgdkfjgk',
        }
      }
      expect {
        post reviews_path, params: review_hash
      }.must_differ 'review.count', 1

      must_redirect_to root_path
  end
end
