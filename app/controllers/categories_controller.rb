class CategoriesController < ApplicationController
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
      redirect_to marchant_path 
      return
    else 
      flash.now[:failure] = "Category failed to save"
      render :new, status: :bad_request 
      return
    end
  end
  
  def edit 
  end

  def update
    if @category.update(category_params)
      redirect_to root_path 
      return
    else 
      render :edit, status: :bad_request 
      return
    end
  end
  
  def destroy
    @category.destroy
    
    redirect_to categories_path
    return
  end
  
  private
  
  def category_params
    return params.require(:category).permit(:name)
  end
end
  
