class AboutController < ApplicationController
  def index
    # @images = Product.where(id: (1..3))
    @images = Product.where(id: 12)[0]

  end
end
