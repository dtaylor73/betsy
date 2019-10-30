class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :toggle_active, :toggle_inactive, :add_product_to_cart]

  def index
    if params[:merchant_id]
      merchant = Merchant.find_by(id: params[:merchant_id])
      if merchant == nil
        return head :not_found
      else
        # merchant = Merchant.find_by(id: params[:merchant_id])
        @products = merchant.products
      end
    elsif params[:category_id]
      category = Category.find_by(id: params[:category_id])
      if category == nil
        return head :not_found
      else
        @products = category.products
      end
    else
      @products = Product.where(status: true)
    end
    # @products = Product.where(status: true)
  end

  def new
    @product = Product.new
  end

  def create
    if @login_merchant
      # if session[:user_id]
      @product = Product.new(product_params)
      @product.merchant_id = @login_merchant
      # @product.merchant_id = session[:user_id]

      if @product.save
        flash[:status] = :success
        flash[:result_text] = "Product has been successfully created"
        redirect_to products_path
      else
        flash[:status] = :failure
        flash[:result_text] = "Invalid product info. Please try again."
        render :new, status: :bad_request
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can create products"
      render :new, status: :bad_request
    end
  end

  def show; end

  def edit; end

  def update
    if @login_merchant && @login_merchant == @product.merchant_id
      # if session[:user_id] && (session[:user_id] == @product.merchant_id)
      if @product.update(product_params)
        flash[:status] = :success
        flash[:result_text] = "Product has been successfully updated"
        redirect_to product_path(@product)
      else
        flash[:status] = :failure
        flash[:result_text] = "Invalid data. Please try again"
        render :edit, status: :not_found
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can update products"
      render :edit, status: :not_found
    end
  end

  def add_product_to_cart
    current_product = @product
    product_order_quantity = params[:quantity].to_i

    if current_product.quantity > product_order_quantity
      session[:shopping_cart][current_product.id] = product_order_quantity
      flash[:success] = "This item was successfully added to your shopping cart."
      render :show
      return
    elsif current_product.quantity < product_order_quantity
      flash[:failure] = "This item is out of stock"
      render :show
      return 
    end 
  end 

  # Do we need a destroy action if we're going to toggle the product's active status?
  # def destroy
  #   @product.destroy
  #   flash[:status] = :success
  #   flash[:result_text] = "Product has been sucessfully destroyed"
  #   return redirect_to products_path
  # end

  # def toggle_active
  #   @product = Product.find_by(id: params[:id])

  #   if @product.nil?
  #     return redirect_to products_path
  #   else
  #     @product.status = true
  #     @product.save
  #     return redirect_to product_path(@product)
  #   end

  #   if @logged_in_merchant
  #     if @product.merchant_id == @logged_in_merchant.id && @product.status == false
  #       @product.status = true
  #       @product.save
  #       return redirect_to merchant_path(@merchant)
  #     else
  #       flash[:status] = :failure
  #       flash[:result_text] = "You may only change the status of your own products"
  #     end
  #   else
  #     flash[:status] = :failure
  #     flash[:result_text] = "You must be logged in to change the status of this product!"
  #   end
  #   redirect_to merchant_path(@merchant)
  # end
  # end

  # def toggle_inactive
  # @product = Product.find_by(id: params[:id])

  # if @product.nil?
  #   return redirect_to products_path
  # else
  #   @product.status = false
  #   @product.save
  #   return redirect_to product_path(@product)
  # end

  #   if @logged_in_merchant
  #     if @product.merchant_id == @logged_in_merchant.id && @product.status == true
  #       @product.status = false
  #       @product.save
  #       return redirect_to merchant_path(@merchant)
  #     else
  #       flash[:status] = :failure
  #       flash[:result_text] = "You may only change the status of your own products"
  #     end
  #   else
  #     flash[:status] = :failure
  #     flash[:result_text] = "You must be logged in to change the status of this product!"
  #   end
  #   redirect_to merchant_path(@merchant)
  # end

  private

  def product_params
    # Need to add additional fields for Product such as photo_url, status, etc.
    params.require(:product).permit(:name, :price, :quantity, :merchant_id, :description, :photo_url, :status, category_ids: [])
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    head :not_found unless @product
  end
end
