class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  before_action :if_category_missing, only: [:show]
  before_action :require_login, only: [:create, :new]
  
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params) 
    if @category.save 
      flash[:success] = "Category added successfully"
      redirect_to  root_path
      return
    else 
      flash.now[:failure] = "Category failed to save"
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
      flash[:error] = "category with id #{params[:id]} was not find"
      redirect_to root_path
      return
    end
  end
end
