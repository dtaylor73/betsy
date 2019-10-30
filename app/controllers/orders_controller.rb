class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end 

  def show
    # @order = Order.find_by(id: params[:id])

    # if @order.status == "paid"
    #   redirect_to confirmation_page_path
    # end

    # if @order
    #   head :not_found
    #   return
    # end 
  end

  def create 
    @order = Order.new(order_params)

    if @order.save

      session[:shopping_cart].each do |product_ids, quantity|
        product = Product.find_by(id: product_ids)
        product.quantity -= quantity 
      end 

      @order.status = "paid"
      session[:shopping_cart].clear
      redirect_to confirmation_page_path(@order.id)
      return
    else
      @order.errors.each do |column, message|
        flash.now[:failure] = "Could not create new order. #{column.capitalize} #{message}"
      end
      render :new 
      return 
    end
  end 

  def new
    @order = Order.new
  end 

  # def update
 
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

  def shopping_cart
    @product_ids = session[:shopping_cart].keys
  end 

  def confirmation_page
    
  end


  # def remove_product_from_cart
  #   # product = Product.find_by(id: params[:id])
  #   session[:shopping_cart].delete(product.id)
  # end 



  private

  def order_params
    params.require(:order).permit(:name, :address, :email, :credit_card_num, :cvv, :zip, :expiration_date)
  end

end
