require "test_helper"

describe CategoriesController do
  let(:merchant_one) { merchants(:sponge) }

  describe "Logged_in Merchants" do
    before do
      perform_login(merchants(:sponge))
    end

    describe "new" do
      it "will show a new category page" do
        get new_category_path
        must_respond_with :success
      end
    end

    describe "category" do
      it 'allows merchant to create a new category' do
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
  
  describe "Guest Users" do
    describe "new" do
      it "will not allow a guest user to see new category page" do
        get new_category_path
        must_respond_with :redirect
      end
    end

    describe "create" do
      it 'should not let the guest user to create a new category' do
        start_count = Category.count
        Category.create(name: 'Flowers')

        expect(flash.now[:result_text]).must_equal "Category failed to save"
        expect(Category.count).must_equal start_count
        must_redirect_to root_path
      end
    end
  end
end