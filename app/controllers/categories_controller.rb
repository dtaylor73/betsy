class CategoriesController < ApplicationController

  before_action :find_category, only: [:show]
  before_action :if_category_missing, only: [:show]
  
  def index
    @categories = Category.all
  end
  
  def new
    @categories  = Category.new
  end
  
  def create
    @category = Category.new(category_params) 
    if @category.save 
      flash[:success] = "Category added successfully"
      redirect_to  root_path #merchant_path(@merchant)
      return
    else 
      flash.now[:failure] = "Category failed to save"
      render :new, status: :bad_request 
      return
    end
  end
  
  # def show
  #   # category_id = params[:id]
  #   # @category = Category.find_by(id: category_id)
  #   # if @category.nil?
  #   #   head :not_found
  #   #   return
  #   # end     
  # end
  
  # def edit
  #   @category = Category.find_by(id: params[:id])
    
  #   if @category.nil?
  #     head :not_found
  #     return
  #   end
  # end
  
  # def update
  #   @category = Category.find_by(id: params[:id])
    
  #   if @category.nil?
  #     head :not_found
  #     return
  #   end

  #   if @category.update(category_params)
  #     redirect_to root_path 
  #     return
  #   else 
  #     render :edit, status: :bad_request 
  #     return
  #   end
  # end
  

  # def destroy
  #   category_id = params[:id]
  #   @category = Category.find_by(id:category_id)
    
  #   if @category.nil?
  #     head :not_found
  #     return
  #   end
    
  #   @category.destroy
  #   deleted = Category.find_by(id: category_id)
  #   if !deleted
  #     flash[:success] = "Successfully deleted category"
  #   else
  #     flash[:warning] = "Can Not Delete"
  #   end
  #   redirect_to root_path
  #   # redirect_to categories_path
  #   return
  # end


  
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

