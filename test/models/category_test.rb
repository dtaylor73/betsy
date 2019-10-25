require "test_helper"

describe Category do
  describe 'validations' do
    before do
      # Arrange
      @Category = Category.new(name: 'Flowers')
    end
    
    it 'is valid when all fields are present and unique' do
      # Act
      result = @category.valid?
      # Assert
      expect(result).must_equal true
    end
    
    it 'is invalid without a name' do 
      @category.name = nil
      
      expect(@category.valid?).must_equal false
      expect(@category.errors.messages).must_include :name
    end
    
    it 'is invalid if the name is not unique' do
      new_category = Category.new(name: 'test work')
      new_category.save
      @categoty.name = new_work.name
      @category.save            
      expect(@category.valid?).must_equal false
      expect(@category.errors.messages).must_include :name
    end
  end
  
  describe 'relations' do 
    it 'has products' do
      category = Category.first
      products = category.votes
      products.each do |product|
        expect(product).must_be_instance_of Product
      end
    end
  end
end
