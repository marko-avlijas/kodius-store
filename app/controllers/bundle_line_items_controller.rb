class BundleLineItemsController < ApplicationController
  before_action :set_current_basket
  before_action :set_product_bundle, only: [:create]

  def create
    @current_basket.add_product_bundle(@product_bundle)
    redirect_to root_url, notice: "#{@product_bundle.name} added to basket"
  end

  def destroy
    line_item = @current_basket.line_items.find(params[:id])
    line_item.destroy

    redirect_to root_url, notice: "Line item deleted", status: :see_other
  end

  private

    def set_product_bundle
      @product_bundle = ProductBundle.find(params[:product_bundle_id])
    end
end

