require "test_helper"

describe CategoriesController do
  describe "index action" do
    
    it "gives back a successful response" do
      get categories_path
      must_respond_with :success
    end
    
    it "gives back a 404 if there are no works available" do
      get categories_path
      
    end
  end
  
  describe 'show action' do
    it 'responds with a success when id given exists' do
      valid_work = Category.first
      
      get category_path(valid_category.id)
      
      must_respond_with :success
      
    end
  end
  
  describe 'show action' do
    
    it 'responds with a success when id given exists' do
      valid_category = Category.first
      
      get category_path(valid_category.id)
      
      must_respond_with :success
    end
    
    it 'responds with a not_found when id given does not exist' do
      get category_path("500")
      
      must_respond_with :redirect
    end
  end
end
