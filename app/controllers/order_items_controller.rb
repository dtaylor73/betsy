class OrderItemsController < ApplicationController


  # def create
  #   result = @cart.add_orderitem(product_params)

  #   if result
  #     @cart.save
  #     flash[:success] = "This item was successfully added to your shopping cart."
  #     render :show
  #     return
  #   else
  #     flash[:failure] = "This item is out of stock"
  #     render :show
  #     return 
  #   end 
  # end 

  private
  
  def product_params
    params.require(:product).permit(:name, :price, :quantity, :merchant_id, :description, :photo_url, :status, category_ids: [])
  end
end
