require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    
    let(:category) { $category = Category.create(name: 'name') }
    

    it 'passes if product validations are valid' do
      product = Product.new(name: 'n', price: 1, quantity: 1, category: category)
      expect(product).to be_valid
    end
    
    it 'invalid when name is not applied to new product' do
      product = Product.new(name: nil, price: 1, quantity: 1, category: category)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    
    it 'invalid when price is not applied to new product' do
      product = Product.new(name: 'n', quantity: 1, category: category)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'invalid when quantity is not applied to new product' do
      product = Product.new(name: 'n', price: 1, quantity: nil, category: category)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'invalid when category is not applied to new product' do
      product = Product.new(name: 'n', price: 1, quantity: 1, category: nil)
      expect(product).to be_invalid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
