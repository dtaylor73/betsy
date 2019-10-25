class Order < ApplicationRecord
  has_many :order_items

  
  # def order_complete?(order)
  #   if order.status == "pending"


  # end 

  def total_earnings
    driver_trips = self.trips
    earnings = 0
    
    driver_trips.each do |trips|
      fee = (trips.cost - 1.65)
      driver_earnings = fee * 0.8
      earnings += driver_earnings
    end

    return earnings.round(2)
  end
end

# How do I create two views?