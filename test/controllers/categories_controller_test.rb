require "test_helper"

describe CategoriesController do
  describe "index action" do
    
    it "gives back a successful response" do
      get categories_path
      must_respond_with :success
    end
    
    it "returns with a success if there are no categories available" do
      get categories_path
      must_respond_with :success
    end
  end
  
  
  describe 'create action' do
    
    it 'should not let the guest user to create a new category, no data' do
      post categories_path, params: {
        category: {name: "new category" }
      }
      expect(flash[:result_text]).must_equal "You must be logged in to see this page"
      must_redirect_to root_path
    end
    
    it 'should not let the guest user to create a new category' do
      category_hash = {
        category: { name: "Flowers"}
      }
      expect {
        post categories_path, params: category_hash
      }.must_differ 'Category.count', 0
      expect(flash[:result_text]).must_equal "You must be logged in to see this page"
       must_redirect_to root_path
    end
    
    it 'should let the merchant to create a new  category' do
      perform_login
      category_hash = {
        category: { name: "Yass"}
      }
      expect {
        post categories_path, params: category_hash
      }.must_differ 'Category.count', 1
      must_redirect_to root_path
    end
  end
end
