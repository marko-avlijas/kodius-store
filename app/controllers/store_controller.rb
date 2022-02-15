class StoreController < ApplicationController
  def index
    @products = Product.includes(:quantity_discounts).order(:name).all
  end
end
