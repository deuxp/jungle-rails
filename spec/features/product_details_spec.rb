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
  
  scenario "Can click on a product and redirect to the product details" do
    # ------------------------------------ ACT ----------------------------------- #
    visit root_path
    first(".btn-default").click
    # ------------------------------ DEBUG / VERIFY ------------------------------ #
    save_screenshot
    # ---------------------------- CHECK for PRODUCTS ---------------------------- #
    expect(page).to have_css 'section.products-show'
    puts page.html
    save_screenshot
  end
end
