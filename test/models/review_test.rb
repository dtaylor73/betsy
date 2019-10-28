require "test_helper"

describe Review do
  describe 'validations' do
    before do
      # Arrange
      @review = Review.new(rating: 3, text: text, product_id: 5)
    end

    it 'is valid when all fields are present' do
      result = @review.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a name' do
      @review.name = nil

      expect(@review.valid?).must_equal false
      expect(@review.errors.messages).must_include :name
    end

    it 'is invalid if the name is not unique' do
      @review.name = reviews(:yasmins).name

      expect(@review.valid?).must_equal false
      expect(@review.errors.messages).must_include :name
    end

    it 'is invalid without rating' do
      @review.rating = 4

      expect(@review.valid?).must_equal false
      expect(@review.errors.messages).must_include :rating

      @review.rating = nil
       expect(@review.valid?).must_equal false
       expect(@review.errors.messages).must_include :rating

      @review.rating = "kjfdk"

      expect(@review.valid?).must_equal false
      expect(@review.errors.messages).must_include :rating
    end
  
    
    it 'is invalid when rating is not between 1 and 5' do
      @review.rating = 0
      expect(@review.valid?).must_equal false
      expect(@review.errors.messages).must_include :rating[1..5]
    end
  end

  describe 'relations' do
    it "has a product" do
      review = reviews(:review1)
      review.product.must_equal products[:aloe]
    end
  end
end

