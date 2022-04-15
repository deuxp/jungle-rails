class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]

    def index
        @categories = Category.order(id: :asc).all
    end

    def new
        raise "new Category Form"
        # @category = Category.new    
    end

    def create
        raise "you are saving your new category"
    end
end
