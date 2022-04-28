require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    scenario "Visit the product info page" do
      # ------------------------------------ ACT ----------------------------------- #
      visit root_path

      # -------------------------- click product info link ------------------------- #
      
  
      # ------------------------------ DEBUG / VERIFY ------------------------------ #
      save_screenshot
  
      # -------------------------- CSS check, show product ------------------------- #
      expect(page).to have_css '???'
      
    end
    
  end
end
