class ProductLineItemsController < ApplicationController
  before_action :set_current_basket
  before_action :set_product, only: [:create]

  def create
    @current_basket.add_product(@product)
    redirect_to root_url, notice: "#{@product.name} added to basket"
  end

  def destroy
    line_item = @current_basket.line_items.find(params[:id])
    line_item.destroy

    redirect_to root_url, notice: "Line item deleted", status: :see_other
  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end
end
