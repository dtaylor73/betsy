class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  belongs_to :merchant
  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_float: true, greater_than: 0 }
end
