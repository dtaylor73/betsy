require "test_helper"

describe OrderItemsController do
  describe "create" do
    it "succesfully creates an order_item with all valid fields" do
      start_count = OrderItem.count  

      test_param {
        quantity: 3,
        product: products(:aloe),
        order: orders(:o_1)
      }

      expect {
        post order_items_path, params: test_param
      }.must_change "start_count", 1
    end

    it "will not create an order_item if given an invalid quantity" do
      start_count = OrderItem.count  

      test_param {
        quantity: -1,
        product: products(:aloe),
        order: orders(:o_1)
      }

      expect {
        post order_items_path, params: test_param
      }.wont_change "start_count"
    end

    it "will not create an order_item if given an invalid product" do
      start_count = OrderItem.count  

      test_param {
        quantity: 3,
        product: products(:fake),
        order: orders(:o_1)
      }

      expect {
        post order_items_path, params: test_param
      }.wont_change "start_count"
    end

    it "will not create an order_item if given an invalid order" do
      start_count = OrderItem.count  

      test_param {
        quantity: -1,
        product: products(:aloe),
        order: orders(:404)
      }

      expect {
        post order_items_path, params: test_param
      }.wont_change "start_count"
    end

    it "will not create an order_item if the product is inactive" do
      start_count = OrderItem.count
      products(:aloe).status = false

      test_param {
        quantity: -1,
        product: products(:aloe),
        order: orders(:o_1)
      }

      expect {
        post order_items_path, params: test_param
      }.wont_change "start_count"
    end

    it "will not create an order_item if order quantity is more than product stock" do
      start_count = OrderItem.count

      test_param {
        quantity: 21,
        product: products(:aloe),
        order: orders(:o_1)
      }

      expect {
        post order_items_path, params: test_param
      }.wont_change "start_count"
    end
  end

  describe "shipped" do
    it "can mark order_item as shipped for complete order"
      text_params {
        quantity: 1,
        product: products(:aloe),
        order: orders(:o_1)
      }

      text_one = OrderItem.create(test_param)
      text_one.order.status = "complete"

      expect {
        patch shipped_path(id: text_one.id)
      }.must_equal true
    end

    it "can't mark order_item as shipped for pending order"
      text_params {
        quantity: 1,
        product: products(:fern),
        order: orders(:o_2)
      }
      
      text_two = OrderItem.create(test_param)
      text_two.order.status = "pending"

      expect {
        patch shipped_path(id: text_two.id)
      }.must_equal false
    end

    it "can't mark order_item as shipped if it's already marked as shipped"
      text_params {
        quantity: 1,
        product: products(:aloe),
        order: orders(:o_2)
      }

      text_three = OrderItem.create(test_param)
      text_three.status = true

      expect {
        patch shipped_path(id: text_three.id)
      }.must_equal false
    end
  end
end
