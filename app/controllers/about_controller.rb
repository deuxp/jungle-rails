class AboutController < ApplicationController
  def index
    @images = Product.where(id: 12)[0]
  end
end
