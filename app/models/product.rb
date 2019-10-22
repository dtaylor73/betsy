class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  belongs_to :merchant
  has_many :reviews
end
