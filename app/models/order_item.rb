class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_one :merchant, through: :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0}
  validates :shipping_status, inclusion: { in: [ true, false ] }
  
  validate :active
  validate :available

  def subtotal
    subtotal = self.quantity * self.product.price
    return subtotal
  end

  private

  def active
    if product && product.status == false
      errors.add(:product_id, "this product is no longer available")
    end
  end

  def available
    if quantity && product && quantity > product.quantity
      errors.add(:quantity, "order quantity exceeds product in stock")
    end
  end 
end
