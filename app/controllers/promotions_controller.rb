class PromotionsController < ApplicationController
  before_action :set_current_basket

  def create
    form = PromotionsForm.new(code: params[:code], basket: @current_basket)

    if form.save
      redirect_to root_url, notice: "Code sucessfully applied"
    else
    end
  end
end
