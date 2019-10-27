require "test_helper"

describe Merchant do
  describe 'validations' do
    before do
      @merchant = Merchant.new(
        username: 'test merchant', 
        email: 'testing@email.com'
      )
    end

    it 'is valid when all fields are present' do
      result = @merchant.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a username' do 
      @merchant.username = nil
      result = @merchant.valid?
      expect(result).must_equal false
    end

    it 'is invalid without an email' do 
      @merchant.email = nil
      result = @merchant.valid?
      expect(result).must_equal false
    end

    it 'is invalid if username is not unique' do
      merchant_1 = Merchant.new(
        username: Merchant.first.username,
        email: 'testing_1@email.com'
      )
      result = merchant_1.valid?
      expect(result).must_equal false
    end

    it 'is invalid if email is not unique' do
      merchant_2 = Merchant.new(
        username: 'testing_2 merchant',
        email: Merchant.last.email
      )
      result = merchant_2.valid?
      expect(result).must_equal false
    end
  end

  describe 'relationships' do
    it 'has a list of products' do
      sponge = merchants(:sponge)
      sponge.must_respond_to :products
      sponge.products.each do |prodcut|
        product.must_be_kind_of Product
      end
    end

    it 'has a list of order_items' do
      star = merchants(:star)
      star.must_respond_to :order_items
      star.order_items.each do |order_item|
        order_item.must_be_kind_of OrderItem
      end
    end
  end

end
