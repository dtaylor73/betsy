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

    it "" do
    end
  end
end
