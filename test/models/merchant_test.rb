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
      merchant = merchants(:sponge)
      _(merchant).must_respond_to :products
      merchant.products.each do |prodcut|
        product.must_be_kind_of Product
      end
    end

    it 'is included in the list of products' do
      product = products(:aloe)
      merchant = merchants(:sponge)
      _(product).must_respond_to :merchant
      product.merchant.must_be_kind_of Merchant
    end

  #   it 'has a list of order_items' do
  #     merchant = merchants(:star)
  #     _(merchant).must_respond_to :order_items
  #     merchant.order_items.each do |order_item|
  #       order_item.must_be_kind_of OrderItem
  #     end
  #   end

  #   it 'is included in the list of order_items' do
  #     order_item = order_items(:oi_1)
  #     merchant = merchants(:star)
  #     _(order_item).must_respond_to :merchant
  #     order_item.merchant.must_be_kind_of Merchant
  #   end
  end

  # describe "custom method" do
  #   it "create a new merchant from github auth_hash" do
  #     test_auth_hash = {
  #       uid: 123,
  #       "info": {
  #         "name": "sandy",
  #         "email": "sandy@sam.com"
  #       },
  #       provider: "github"
  #     }

  #     merchant = Merchant.build_from_github(test_auth_hash)
  #     merchant.save

  #     expect(merchant).must_be_kind_of Merchant
  #   end
  # end
end