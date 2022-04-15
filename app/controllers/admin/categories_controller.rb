class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_LOGIN"], password: ENV["ADMIN_PASSWORD"]

    def index
        @categories = Category.order(id: :asc).all
    end

    def new
        @category = Category.new    
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to [:admin, :categories], notice: 'Category created!'
        else
            # create anon new in  new 'action' to keep -> render :new from crashing
            render :new
        end
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
end
