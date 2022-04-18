class AboutController < ApplicationController
  def index
    @image = Product.where(id: 12)[0].image
  end
end
