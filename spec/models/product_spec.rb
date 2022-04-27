require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @categories = Category.new({name: 'apparel'})
      @categories.save
      @cat_id = Category.where(:name == 'apparel')[0][:id]
    end
    
    it 'should save a product' do

      product = Product.new({
        name: 'loafers',
        description: 'nope',
        category_id: @cat_id,
        quantity: 5,
        image: 'no Image',
        price: 9.99
        })

        product.save
        prod = Product.where(:name == 'loafers')
        expect(prod).to exist
    end
    
    context ':name' do
      cat = Category.find_or_create_by! name: 'apparel'
      product = Product.new({
        description: 'tank top',
        category_id: cat.id,
        quantity: 3,
        image: 'none',
        price: 8
      })
      product.save
      error = product.errors.full_messages
      it 'should not save if the name field is empty' do
        expect(error).to include('Name can\'t be blank')
      end
    end

    context ':price' do
      cat = Category.find_or_create_by! name: 'apparel'
      product = Product.new({
        name: 'Air',
        description: 'tank top',
        category_id: cat.id,
        quantity: 3,
        image: 'none'
      })
      product.save
      
      error = product.errors.full_messages
      it 'should not save if the name field is empty' do
        expect(error).to include('Price can\'t be blank')
      end
    end

    context ':quantity' do
      cat = Category.find_or_create_by! name: 'apparel'
      product = Product.new({
        name: 'Air',
        description: 'tank top',
        category_id: cat.id,
        image: 'none',
        price: 10
      })
      product.save
      
      error = product.errors.full_messages
      it 'should not save if the name field is empty' do
        expect(error).to include('Quantity can\'t be blank')
      end
    end

    context ':category' do
      cat = Category.find_or_create_by! name: 'apparel'
      product = Product.new({
        name: 'Air',
        description: 'tank top',
        quantity: 9,
        image: 'none',
        price: 10
      })
      product.save
      
      error = product.errors.full_messages
      it 'should not save if the name field is empty' do
        expect(error).to include('Category can\'t be blank')
      end
    end

  end
end

