class StoreController < ApplicationController
  def index
    @products = Product.includes(:product_bundles).order(:name).all

    layout = basket_present? ? "with_basket" : "application"
    set_current_basket if basket_present?

    render layout: layout
  end
end
