require "pry"

class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :toggle_active, :toggle_inactive]

  def index
    if params[:merchant_id]
      merchant = Merchant.find_by(id: params[:merchant_id])
      if merchant == nil
        return head :not_found
      else
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
  end

  def new
    if @login_merchant.nil?
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can create products"
      redirect_to root_path
    else
      @product = @login_merchant.products.new
    end
    if @login_merchant
      merchant = Merchant.find_by(id: params[:merchant_id])
      @products = Product.new
    else
      @product = Product.new
    end
  end

  def create
    if @login_merchant
      # if session[:user_id]
      @product = Product.new(product_params)
      # binding.pry
      # @product.merchant_id = @login_merchant
      @product.merchant_id = session[:user_id]
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
    # binding.pry
    # redirect_back fallback_location: products_path
  end

  def show; end

  def edit
    if @login_merchant && @login_merchant.id == @product.merchant_id
      @product = Product.find_by(id: session[:user_id])
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can edit their own products"
      redirect_to root_path
    end
  end

  def update
    if @login_merchant && session[:user_id] == @product.merchant_id
      # if session[:user_id] && (session[:user_id] == @product.merchant_id)
      if @product.update(product_params)
        flash[:status] = :success
        flash[:result_text] = "Product has been successfully updated"
        redirect_to product_path(@product)
        # else
        #   flash.now[:status] = :failure
        #   flash.now[:result_text] = "Invalid data. Please try again"
        #   render :edit, status: :not_found
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can update products"
      render :edit, status: :not_found
    end
  end

  # Do we need a destroy action if we're going to toggle the product's active status?
  # def destroy
  #   @product.destroy
  #   flash[:status] = :success
  #   flash[:result_text] = "Product has been sucessfully destroyed"
  #   return redirect_to products_path
  # end

  def toggle_active
    #   @product = Product.find_by(id: params[:id])

    #   if @product.nil?
    #     return redirect_to products_path
    #   else
    #     @product.status = true
    #     @product.save
    #     return redirect_to product_path(@product)
    #   end

    if @logged_in_merchant
      if @product.merchant_id == @logged_in_merchant.id && @product.status == false
        @product.status = true
        @product.save
        return redirect_to merchant_path(@merchant)
      else
        flash[:status] = :failure
        flash[:result_text] = "You may only change the status of your own products"
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to change the status of this product!"
    end
    redirect_to merchant_path(@merchant)
  end

  # end

  def toggle_inactive
    # @product = Product.find_by(id: params[:id])

    # if @product.nil?
    #   return redirect_to products_path
    # else
    #   @product.status = false
    #   @product.save
    #   return redirect_to product_path(@product)
    # end

    if @logged_in_merchant
      if @product.merchant_id == @logged_in_merchant.id && @product.status == true
        @product.status = false
        @product.save
        return redirect_to merchant_path(@merchant)
      else
        flash[:status] = :failure
        flash[:result_text] = "You may only change the status of your own products"
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to change the status of this product!"
    end
    redirect_to merchant_path(@merchant)
  end

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
