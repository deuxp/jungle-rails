class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]   

  def show
    # number of categories
    @categories = Category.all.count
    # sum of all products
    @products = 0
    # number of products of each category
    Category.all.each do |category|
      @products += category.products.count
    end
  end
end
