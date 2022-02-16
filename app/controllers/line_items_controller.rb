class LineItemsController < ApplicationController
  before_action :set_current_basket
  before_action :set_product

  def create
    line_item = @current_basket.add_product(@product)
    redirect_to root_url, notice: "#{@product.name} added to basket"
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end
end
