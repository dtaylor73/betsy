class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  belongs_to :merchant
  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :price , presence: true, numericality: {only_integer: true, greater_than: 0}

  def self.get_product_id
    session[:product_ids] = []
    session[:product_ids] << Product.find_by(id: params[:id])
  end 
  validates :price, presence: true, numericality: { only_float: true, greater_than: 0 }

  # def average_rating
  #   self.reviews[0].rating / self.reviews.count
  # end

  def self.top_products
    top_items = Product.all.sort_by { |product| product.reviews.count }.reverse
    return top_items[0..7]
  end
end
