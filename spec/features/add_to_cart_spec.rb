require 'rails_helper'

def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

RSpec.feature "A visitor on the home page", type: :feature, js: true do

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
  end
  
  scenario "Can add a product to their cart" do
    # ------------------------------------ ACT ----------------------------------- #
    visit root_path
    # ---------------------------- test for empty cart --------------------------- #
    save_screenshot #My Cart (0)
    within('.navbar-right') { expect(page).to have_content 'My Cart (0)' }
    # ---------------------------- add product to cart --------------------------- #
    within(first('form.button_to')) { find('button').click }
    # ------------------------ test for cart having 1 item ----------------------- #
    within('.navbar-right') { expect(page).to have_content 'My Cart (1)' }
    save_screenshot #My Cart (1)
  end
end
