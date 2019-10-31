require "test_helper"

describe OrderItem do
  before do
    @order_item = OrderItem.new(
      quantity: 3,
      product: products(:aloe),
      order: orders(:o_1),
    )
  end

  describe "validations" do
    it 'is valid when all fields are present' do
      result = @order_item.valid?
      expect(result).must_equal true
    end

    it 'is invalid without quantity' do 
      @order_item.quantity= nil
      result = @order_item.valid?
      expect(result).must_equal false
    end

    it 'has a default false value for shipping_status' do
      @order_item.save
      result = @order_item.shipping_status
      expect(result).must_equal false
    end

    it 'is invalid if quantity is not integer' do
      @order_item.quantity = "hello"
      result = @order_item.valid?
      expect(result).must_equal false
    end

    it 'is invalid if quantity is integer but less than 0' do
      @order_item.quantity = -1
      result = @order_item.valid?
      expect(result).must_equal false
    end

    # it 'is invalid if shipping_status is not boolean value' do
    #   test_oi = OrderItem.new(
    #     quantity: 2,
    #     order_id: orders(:o_1).id,
    #     product_id: products(:fern).id,
    #     shipping_status: "hi"
    #   )
    #   expect(test_oi.valid?).must_equal false
    # end

    it 'is invalid if the product is no longer active' do
      products(:aloe).status = false
      result = @order_item.valid?
      expect(result).must_equal false
    end

    it 'is invalid if the order quantity exceeds product in stock' do
      @order_item.quantity = 21
      result = @order_item.valid?
      expect(result).must_equal false
    end
  end

  describe "relationships" do
    it "belongs to a product" do
      @order_item.save
      expect(@order_item.product).must_equal products(:aloe)
    end

    it "belongs to an order" do
      @order_item.save
      expect(@order_item.order).must_equal orders(:o_1)
    end

    it "has a merchant through product" do
      @order_item.save
      expect(@order_item.merchant).must_equal products(:aloe).merchant
    end
  end

  describe "custom methods" do
    describe "subtotal" do
      it "can the subtotal for each oder_item" do
        result = order_items(:oi_2).subtotal
        expect(result).must_be_close_to 16
      end
    end
  end
end