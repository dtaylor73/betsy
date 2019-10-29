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
      expect(flash[:error]).must_equal "You must be logged in to see this page"
      must_respond_with :forbidden
    end
    
    it 'should not let the guest user to create a new category' do
      category_hash = {
        category: { name: "Flowers"}
      }
      expect {
        post categories_path, params: category_hash
      }.must_differ 'Category.count', 0
       must_respond_with :forbidden 
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
  # describe 'update action' do
  #   before do
  #     @new_category = Category.create(name: "new category")
  #   end
    
  #   it "updates an existing work successfully and redirects to home" do
  #     existing_category = Category.create
  #     updated_category_form_data = {
  #       category:{
  #         name: "Flowers"
  #       }
  #     }
  #     # Act
  #     expect {
  #       patch category_path(existing_category.id), params: updated_category_form_data
  #     }.wont_change 'Category.count'
      
  #     # Assert
  #     expect( Category.find_by(id: existing_category.id).name ).must_equal "Flowers"
  #   end
  #end
  
  
  
# end
# describe CategoriesController do
#   describe "index action" do
#     it "gives back a successful response" do
#       get categories_path
#       must_respond_with :success
#     end

#     it "gives back a 404 if there are no works available" do
#       get categories_path
#     end
#   end

#   describe "show action" do
#     it "responds with a success when id given exists" do
#       valid_work = Category.first

#       get category_path(valid_category.id)

#       must_respond_with :success
#     end
#   end

#   describe "show action" do
#     it "responds with a success when id given exists" do
#       valid_category = Category.first

#       get category_path(valid_category.id)

#       must_respond_with :success
#     end

#     it "responds with a not_found when id given does not exist" do
#       get category_path("500")

#       must_respond_with :redirect
#     end
#   end
# end
