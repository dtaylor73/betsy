class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    # if params[:merchant_id]
    #   merchant = Merchant.find_by(id: params[:merchant_id])
    #   @products = merchant.products
    # elsif params[:category_id]
    #   category = Category.find_by(id: params[:category_id])
    #   @products = category.products
    # else
    #   @products = Product.all
    # end
    @products = Product.where(status: true)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    if session[:user_id]
      @product = Product.new(product_params)
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
  end

  def edit; end

  def update
    if session[:user_id] && (session[:user_id] == @product.merchant_id)
      if @product.update(product_params)
        flash[:status] = :success
        flash[:result_text] = "Product has been successfully updated"
        redirect_to product_path(@product)
      else
        flash[:status] = :failure
        flash[:result_text] = "Invalid data. Please try again"
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can create products"
      render :edit
    end
  end

  # Do we need a destroy action if we're going to toggle the product's active status?
  def destroy
    @product.destroy
    flash[:status] = :success
    flash[:result_text] = "Product has been sucessfully destroyed"
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity, category_ids: [])
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    head :not_found unless @product
  end
end
