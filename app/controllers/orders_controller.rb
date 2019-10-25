class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end 

  def show
    @order = Order.find_by(id: params[:id])

    if @order.status == "paid"
      redirect_to confirmation_page_path
    end


    
    if @order.nil?
      head :not_found
      return
    end 
  end

  def new
    @order = Order.new
  end 

  def create
    @order = Order.new(order_params)
    
    if @order.save
      flash[:success] = "Order created successfully"
      redirect_to root_path
      return
    else
      @order.errors.each do |column, message|
        flash.now[:failure] = "Could not create new order. #{column.capitalize} #{message}"
      end
      render :new 
      return 
    end
  end 

  private

  def order_params
    params.require(:order).permit(:name, :address, :email, :credit_card_num, :cvv, :zip, :expiration_date )
  end

end
