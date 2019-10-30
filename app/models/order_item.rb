class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_one :merchant, through: :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0}
  validate :shipping_status, inclusion: {
    in: [true, false],
    message: "shipping status must be boolean value: true or false"
  }
  
  def subtotal
    subtotal = self.quantity * self.product.price
    return subtotal
  end

  private

  def not_inactive
    if product && product.status == false
      errors.add(:product_id, "this product is no longer available")
    end
  end

  def in_stock
    if quantity && product && quantity > product.stock
      errors.add(:quantity, "order quantity exceeds product in stock")
    end
  end 
end
