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
        return redirect_to products_path
      else
        flash[:status] = :failure
        flash[:result_text] = "Invalid product info. Please try again."
        return render :new, status: :bad_request
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can create products"
      return render :new, status: :bad_request
    end
  end

  def show; end

  def edit; end

  def update
    if session[:user_id] && (session[:user_id] == @product.merchant_id)
      if @product.update(product_params)
        flash[:status] = :success
        flash[:result_text] = "Product has been successfully updated"
        return redirect_to product_path(@product)
      else
        flash[:status] = :failure
        flash[:result_text] = "Invalid data. Please try again"
      end
    else
      flash[:status] = :failure
      flash[:result_text] = "Only logged in merchants can create products"
      return render :edit
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
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      return redirect_to products_path
    else
      @product.status = true
      @product.save
      return redirect_to product_path(@product)
    end
  end

  def toggle_inactive
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      return redirect_to products_path
    else
      @product.status = false
      @product.save
      return redirect_to product_path(@product)
    end
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
