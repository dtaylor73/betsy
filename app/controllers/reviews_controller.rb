class ReviewsController < ApplicationController
#before
def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params) 
    @review.product = @product
    if @review.save 
      flash[:success] = "Review added successfully"
     redirect_to  product_path(@product.id)
      return
    else 
      flash.now[:failure] = "A problem occurred: Could not submit your Review" 
      puts "failed work"
      render :new,  status: :bad_request
      return
    end
  end

  private

  def review_params
    return params.require(:review).permit(:rating, :product_id, :text)
  end
  
end
