class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  before_action :if_category_missing, only: [:show]
  before_action :find_merchant, only: [:create, :new]
  
  def new
    current_merchant
    if @current_merchant.id.to_s == params[:id]
      @category = Category.new
    else
      flash[:status] = :error
      flash[:result_text] = "You have no authorization access to this page"
      return redirect_to root_path
    end
  end
  
  def create
    @category = Category.new(category_params) 
    if @category.save 
      flash[:status] = :success
      flash[:result_text] = "Category added successfully"
      redirect_to  root_path
      return
    else
      flash.now[:status] = :failure 
      flash.now[:result_text] = "Category failed to save"
      render :new, status: :bad_request 
      return
    end
  end

  private
  
  def category_params
    return params.require(:category).permit(:name)
  end
  
  def find_category
    @category = Category.find_by_id(params[:id])
  end

  def if_category_missing
    if @category.nil?
      flash[:status] = :error
      flash[:result_text] = "category with id #{params[:id]} was not find"
      redirect_to root_path
      return
    end
  end
end
